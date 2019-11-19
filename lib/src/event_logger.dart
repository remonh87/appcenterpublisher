import 'package:meta/meta.dart';

class EventLogger {
  const EventLogger({@required this.verboseLoggingEnabled});

  final bool verboseLoggingEnabled;

  void log(String message) {
    print(message);
  }

  void logVerbose(String message) {
    if (verboseLoggingEnabled) {
      print(message);
    }
  }
}
