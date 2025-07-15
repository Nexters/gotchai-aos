import 'package:http_interceptor/http_interceptor.dart';
import 'package:turing/core/utils/log_util.dart';

class LoggingInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    logger.d('----- Request -----');
    logger.d(request.toString());
    logger.d(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    logger.d('----- Response -----');
    logger.d('Code: ${response.statusCode}');
    if (response is Response) {
      logger.d((response).body);
    }
    return response;
  }
}
