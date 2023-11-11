import 'package:dartz/dartz.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Exception, Type>> call(Params params);
}

class NoParams {}
