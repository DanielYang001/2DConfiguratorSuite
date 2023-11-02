String readableErrorMessage(String errorCode) {
  switch (errorCode) {
    case "wrong-password":
      return "Wrong credentials please check your nick and password";
    case "invalid-email":
      return "Invalid email, please check your email";
    case 'user-not-found':
      return 'User not found';
    case "user-disabled":
      return "This account is disabled, please contact support";
    case 'email-already-in-use':
      return 'This email is already in use, please login or choose another email';
    case "operation-not-allowed":
      return "Unexpected error, please try again later";
    case 'weak-password':
      return 'Password is too weak, please choose a stronger password';
    default:
      return 'Unexpected error, please try again later';
  }
}
