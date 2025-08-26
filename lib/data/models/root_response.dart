abstract class RootResponse<T> {
  const RootResponse();
}

class Success<T> extends RootResponse<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends RootResponse<T> {
  final String message;
  final int? code;

  const Error(this.message, {this.code});
}
