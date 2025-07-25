import 'package:group_exito/core/models/result.dart';

abstract class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  ResultFuture<Type> call();
}

typedef ResultFuture<T> = Future<Result<T>>;
