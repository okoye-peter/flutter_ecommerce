sealed class ApiState<T> {
  const ApiState();
}

final class ApiLoadingState extends ApiState {
  const ApiLoadingState();
}

final class ApiLoadedState<T> extends ApiState {
  const ApiLoadedState(this.data);

  final T data;
}

final class ApiErrorState<T> extends ApiState {
  const ApiErrorState(this.message);

  final T message;
}
