import 'dart:async';
import 'dart:io';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

const int maxLogs = 3;
const int maxLogFileSize = 3 * 1024 * 1024; // 3 MB

void _print(String string) {
  dPrint("AppLogger: $string");
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<String> _getCurrentFileName(String fileName) async {
  final dir = await _localPath;
  return "$dir/$fileName";
}

String _getFileNameByIndex(String path, int? i) {
  return "$path.$i";
}

class FileOutput extends LogOutput {
  String fileName;
  late File _logFile;
  late IOSink _sink;
  bool _rotating = false;
  Future<void> _queue = Future.value();

  FileOutput(this.fileName);

  @override
  Future<void> init() async {
    _logFile = File(await _getCurrentFileName(fileName));
    _openSink();
  }

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      _print("${DateTime.now().toIso8601String()} $line");
    }
    _print("Output arrived: ${event.lines.toString()}");
    _queue = _queue.then((value) => _write(event));
  }

  void _openSink() {
    _sink = _logFile.openWrite(mode: FileMode.append);
    _sink.done.catchError((e) {
      _print("Error with IOSink: ${e.toString()}");
    });
  }

  Future<void> _write(OutputEvent event) async {
    try {
      for (String line in event.lines) {
        _sink.writeln('${DateTime.now().toIso8601String()} $line');
      }
      _print("Flush IOSink");
      await _sink.flush();
      await rotateIfNeeded();
    } catch (e) {
      _print("Error writing to log: ${e.toString()}");
    }
  }

  Future<void> rotateIfNeeded() async {
    if (_rotating) {
      return;
    }

    if (!await _logFile.exists()) {
      return;
    }

    final size = await _logFile.length();

    if (size < maxLogFileSize) {
      return;
    }

    _print("Rotating log files.");
    _rotating = true;

    try {
      await _sink.flush();
      await _sink.close();

      // Remove oldest log file.
      final oldest = File(_getFileNameByIndex(_logFile.path, maxLogs));
      if (await oldest.exists()) {
        await oldest.delete();
      }

      // Rename all files to the next index.
      for (var i = maxLogs - 1; i >= 1; i--) {
        final oldFile = File(_getFileNameByIndex(_logFile.path, i));
        final newFile = File(_getFileNameByIndex(_logFile.path, i + 1));

        if (await oldFile.exists()) {
          await oldFile.rename(newFile.path);
        }
      }

      // Move current log file to index 1.
      if (await _logFile.exists()) {
        await _logFile.rename(_getFileNameByIndex(_logFile.path, 1));
      }

      // Create new log file.
      _logFile = File(await _getCurrentFileName(fileName));
      _sink = _logFile.openWrite(mode: FileMode.append);
    } catch (e) {
      _print("Error rotating log file: ${e.toString()}");
      try {
        await _sink.flush();
        await _sink.close();
      } catch (_) {}
      _openSink();
    } finally {
      _rotating = false;
    }
  }

  Future<void> dispose() async {
    await _sink.flush();
    await _sink.close();
  }
}
