import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  bool get positiveStatus =>
      statusCode != null && statusCode! >= 200 && statusCode! <= 299;

  String getErrorReport(
      {required String ifNoneFound, required List<String> expectedEntries}) {
    if (data is! Map) {
      return ifNoneFound;
    }

    for (String entryKey in expectedEntries) {
      if ((data as Map).containsKey(entryKey)) {
        return data[entryKey];
      }
    }

    return ifNoneFound;
  }
}

class ResponseStatic {
  static mock() {
    return Response(requestOptions: RequestOptions(path: ''), statusCode: 200);
  }
}
