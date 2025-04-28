


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'state_response.dart';
part 'models/http_method.dart';

class BackendRequest {

 static Future<StateResponse<Map<String, dynamic>>>
 Function(T) call<T>({required Dio dio, required String onPath,
   HttpMethod withMethod=HttpMethod.get,
   Function(String path, T)? buildPath,
   Function(T)? extractArgData,
   Function(Response response)? andThenDo
 }){
    return (T args) async {

      debugPrint('[$withMethod] -> ' + onPath);

      debugPrint('- Extract data from ARGS');
      dynamic data = extractArgData == null? null :  extractArgData(args);

      debugPrint('data from args: ' + data.toString());

      debugPrint('Calling fetch');

      String path =  onPath;

      if(data != null && //!
      (data is String)) {
        debugPrint('encoding data to json');
        data = jsonEncode(data);

        debugPrint('data encoded: ' + data);

      }

      Response  response = await returnResponse(withMethod, dio,
          buildPath == null ? path : buildPath(path, args),  args, data);

      debugPrint( response.requestOptions.headers.toString());
      debugPrint('- Fetch responded');

      debugPrint('response status:' + response.statusCode.toString());
      debugPrint('response data:' + response.data.toString());
      debugPrint('response data tipe: ' + response.data.runtimeType.toString());

      if(response.data.runtimeType == String) {
        response.data = jsonDecode(response.data);
      }
      if(andThenDo != null) {
        debugPrint('Calling andThenDo');
        try {
          andThenDo(response);
        } catch(err) {
          debugPrint('Error happened while processing andThenDo call');
          debugPrint(err.toString());
          return StateResponse.fromResponse(response);
        }
      }

      debugPrint('Finished andThenDo');
      debugPrint('Returning backend response');

      debugPrint('response data:' + response.data.toString());

      return StateResponse.fromResponse(response);
    };
   }

 static Future<Response> returnResponse(HttpMethod withMethod, Dio dio, String path,  args, data) async {


   debugPrint('Returning response from path ' + path);

   switch (withMethod) {
     case HttpMethod.get:
       return await dio.
       get(
           path,
           data: data
       );
     case HttpMethod.post:
       return await dio.
       post(
           path,
           data: data
       );

     case HttpMethod.put:
       return await dio.
       put(
           path,
           data: data
       );
     case HttpMethod.delete:
       return await dio.
       delete(
           path,
           data: data
       );
     case HttpMethod.head:
       return await dio.
       head(
           path,
           data: data
       );
     case HttpMethod.patch:
       return await dio.
       patch(
           path,
           data: data
       );
     case HttpMethod.trace:
       // TODO: Handle this case.
       break;
     case HttpMethod.options:
       // TODO: Handle this case.
       break;
     case HttpMethod.connect:
       // TODO: Handle this case.
       break;
   }

   return Response(requestOptions: RequestOptions());
 }
}