abstract class UseCase<Params, Result> {
  Future<Result> call(Params params);
}
