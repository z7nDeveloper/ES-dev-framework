
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:request_states/main/request_configuration.dart';


Dio AppRequestDio({url, contentType,
  allowOrigin = true, usesNgrok = true,
  useApiKey=true}) {

  Dio dio = Dio();
  dio.options.baseUrl = (url ?? GetIt.I.get<RequestConfiguration>().baseUrl);
  /*dio.options.responseType = ResponseType.json;*/


  _setDioHeaders(dio, contentType, allowOrigin, useApiKey, usesNgrok);

  return dio;
}

void _setDioHeaders(Dio dio, contentType, allowOrigin, useApiKey, usesNgrok) {
  dio.options.headers['Content-Type'] =
      contentType ?? "application/json; charset=UTF-8";
  if (allowOrigin) {
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
  }

  if(useApiKey) {
    dio.options.headers['x-api-key'] = GetIt.I.get<RequestConfiguration>().apiKey;
  }

  if (usesNgrok) {
    dio.options.headers['ngrok-skip-browser-warning'] = "*****";
  }
}
