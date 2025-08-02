import 'package:http_interceptor/http_interceptor.dart';
import 'package:turing/core/utils/log_util.dart';

class LoggingInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    logger.d('----- Request -----\n$request\n${request.headers}');
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response is Response) {
      logger.d(
        '----- Response -----\nCode: ${response.statusCode},\nBody: ${response.body}',
      );
    } else {
      logger.d('----- Response -----\nCode: ${response.statusCode}');
    }
    return response;
  }
}
