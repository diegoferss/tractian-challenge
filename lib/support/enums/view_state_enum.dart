enum ViewStateEnum {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == initial;

  bool get isLoading => this == loading;

  bool get hasError => this == error;

  bool get isSuccess => this == success;
}
