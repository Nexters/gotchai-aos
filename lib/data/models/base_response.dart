abstract class BaseResponse<T> {
  const BaseResponse();
}

class Success<T> extends BaseResponse<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends BaseResponse<T> {
  final String message;
  final int? code;

  const Error(this.message, {this.code});
}
