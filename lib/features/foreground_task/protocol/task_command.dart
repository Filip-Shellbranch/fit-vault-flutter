sealed class TaskCommand {
  final String command;
  final String? text;

  TaskCommand(this.command, {this.text});

  factory TaskCommand.fromJSON(Map<String, dynamic> json) {
    String command = json["cmd"];
    switch (command) {
      case "startRun":
        return StartRunCommand.fromJSON(json);
      case "beginRun":
        return BeginRunCommand.fromJSON(json);
      case "pauseRun":
        return PauseRunCommand.fromJSON(json);
      case "resumeRun":
        return ResumeRunCommand.fromJSON(json);
      case "stopRun":
        return StopRunCommand.fromJSON(json);
      case "discardRun":
        return DiscardRunCommand.fromJSON(json);
      case "updateDist":
        return UpdateTextCommand.fromJSON(json);
      default:
        throw ArgumentError("Unknown command type '$command'");
    }
  }

  Map<String, dynamic> toJSON();
}

class StartRunCommand extends TaskCommand {
  StartRunCommand() : super("startRun");

  factory StartRunCommand.fromJSON(Map<String, dynamic> json) {
    return StartRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class BeginRunCommand extends TaskCommand {
  BeginRunCommand() : super("beginRun");

  factory BeginRunCommand.fromJSON(Map<String, dynamic> json) {
    return BeginRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class PauseRunCommand extends TaskCommand {
  PauseRunCommand() : super("pauseRun");

  factory PauseRunCommand.fromJSON(Map<String, dynamic> json) {
    return PauseRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class ResumeRunCommand extends TaskCommand {
  ResumeRunCommand() : super("resumeRun");

  factory ResumeRunCommand.fromJSON(Map<String, dynamic> json) {
    return ResumeRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class StopRunCommand extends TaskCommand {
  StopRunCommand() : super("stopRun");

  factory StopRunCommand.fromJSON(Map<String, dynamic> json) {
    return StopRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class DiscardRunCommand extends TaskCommand {
  DiscardRunCommand() : super("discardRun");

  factory DiscardRunCommand.fromJSON(Map<String, dynamic> json) {
    return DiscardRunCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class UpdateTextCommand extends TaskCommand {
  UpdateTextCommand(String distanceString)
    : super("updateDist", text: distanceString);

  factory UpdateTextCommand.fromJSON(Map<String, dynamic> json) {
    final text = json["text"].toString();
    return UpdateTextCommand(text);
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command, "text": text};
}
