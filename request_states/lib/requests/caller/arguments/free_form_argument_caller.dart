
import 'package:request_states/requests/caller/arguments/argument_caller.dart';

class FreeFormArgumentCaller extends ArgumentCaller {
  Map<String, dynamic> args;

  FreeFormArgumentCaller({required this.args});

  bool compare(value) {
    for(var key in value.keys) {
      if(args[key] != value[key]) {
        return false;
      }
    }

    return true;
  }

  @override
  bool operator ==(other) {
    return (other is FreeFormArgumentCaller)
        && compare(other.args);
  }

  toString() {
    return '<FreeFormArgumentCaller>: $args';
  }
}
