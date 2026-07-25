sealed class Command {
  final String command;
  final String? info;

  Command(this.command, {this.info});

  factory Command.fromJSON(Map<String, dynamic> json) {
    String command = json["cmd"].toString();
    switch (command) {
      case "resume":
        return ResumeCommand.fromJSON(json);
      case "pause":
        return PauseCommand.fromJSON(json);
      case "updateDist":
        return UpdateDistanceCommand.fromJSON(json);
      default:
        throw ArgumentError("Unknown command type '$command'");
    }
  }

  Map<String, dynamic> toJSON();
}

class PauseCommand extends Command {
  PauseCommand() : super("pause");

  factory PauseCommand.fromJSON(Map<String, dynamic> json) {
    return PauseCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class ResumeCommand extends Command {
  ResumeCommand() : super("resume");

  factory ResumeCommand.fromJSON(Map<String, dynamic> json) {
    return ResumeCommand();
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command};
}

class UpdateDistanceCommand extends Command {
  UpdateDistanceCommand(String distanceString)
    : super("updateDist", info: distanceString);

  factory UpdateDistanceCommand.fromJSON(Map<String, dynamic> json) {
    final distance = json["info"].toString();
    return UpdateDistanceCommand(distance);
  }

  @override
  Map<String, dynamic> toJSON() => {"cmd": command, "info": info};
}
