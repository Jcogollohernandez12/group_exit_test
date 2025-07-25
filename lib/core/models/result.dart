sealed class Result<T> {
  final int status;
  const Result(this.status);
}

final class SuccessfulResult<T> extends Result<T> {
  const SuccessfulResult(this.payload, super.status);
  final T payload;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.exception, super.status);
  final Exception exception;
}
