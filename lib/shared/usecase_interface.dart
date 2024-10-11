import 'dart:async';

import 'package:dartz/dartz.dart';

abstract class UseCaseFuture<Failure, Type, T> {
  FutureOr<Either<Failure, Type>> call(T params);
}
