import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient extends DioForNative {
  DioClient(String pathPrefix, [BaseOptions? baseOptions])
      : super(baseOptions) {
    options
      ..contentType = Headers.jsonContentType
      ..baseUrl =
          baseOptions?.baseUrl ?? 'https://api.openweathermap.org/$pathPrefix'
      ..queryParameters = {
        'appid': 'c94a899b724d06b8838be780265ffae0',
      };

    interceptors.addAll(
      [
        PrettyDioLogger(
          responseBody: true,
          requestBody: true,
          logPrint: (logMsg) => log(
            logMsg.toString(),
            time: DateTime.now(),
          ),
        ),
      ],
    );
  }
}
