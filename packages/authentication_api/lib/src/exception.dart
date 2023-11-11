class UserNotFound implements Exception {
  String? get message => "User not found!";

  String toString() => "UserNotFoundException";

}