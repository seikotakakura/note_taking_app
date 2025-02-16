class Result {
  final bool success;
  final String message;

  Result(this.success, this.message);

  factory Result.success(String message) => Result(true, message);
  factory Result.error(String message) => Result(false, message);
}
