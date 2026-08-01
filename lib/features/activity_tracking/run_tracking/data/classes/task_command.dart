sealed class TaskCommand {
  final String command;
  final String? text;

  TaskCommand(this.command, {this.text});

  factory TaskCommand.fromJSON(Map<String, dynamic> json) {
    String command = json["cmd"].toString();
    switch (command) {
      case "resume":
        return ResumeCommand.fromJSON(json);
      case "pause":
        return PauseCommand.fromJSON(json);
      case "updateDist":
        return UpdateTextCommand.fromJSON(json);
      default:
        throw ArgumentError("Unknown command type '$command'");
    }
  }

  Map<String, dynamic> toJSON();
}

class PauseCommand extends TaskCommand {
  PauseCommand() : super("pause");

  factory PauseCommand.fromJSON(Map<String, dynamic> json) {
    return PauseCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class ResumeCommand extends TaskCommand {
  ResumeCommand() : super("resume");

  factory ResumeCommand.fromJSON(Map<String, dynamic> json) {
    return ResumeCommand();
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
