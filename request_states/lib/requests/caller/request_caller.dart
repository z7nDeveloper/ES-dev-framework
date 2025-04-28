import 'arguments/argument_caller.dart';


class RequestCaller<INPUT, OUTPUT> {
  
  Future<OUTPUT> Function(INPUT) request;
  List<Function(OUTPUT, INPUT)> onCalledRequest = [];
  INPUT? defaultArgument;

  OUTPUT? responseInCaseOfException; // Response if request ends with an exception

  RequestCaller(this.request,
      {this.defaultArgument, this.responseInCaseOfException});

  Future<OUTPUT> call({required INPUT? argument}) async {
    argument ??= defaultArgument;

    if (argument == null) {
      throw Exception('Argument passed to Request Caller is null');
    }
    /* if(nextEmptyCachedResponse != null) {
      OUTPUT cachedResponse = nextEmptyCachedResponse!( );
      nextEmptyCachedResponse = null;
      return cachedResponse;
    }*/

    try {
      return await runRequest(argument);
    } catch (err) {
      if (responseInCaseOfException == null) {
        rethrow;
      }

      return responseInCaseOfException!;
    }
  }

  runRequest(argument) async {
    OUTPUT result = await request(argument);

    for (Function(OUTPUT, INPUT) listener in onCalledRequest) {
      listener(result, argument);
    }

    return result;
  }
}
