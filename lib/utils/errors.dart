class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'invalid-email':
        return "The email address is badly formatted.";

      case 'account-exists-with-different-credential':
        return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'wrong-password':
        return "E-mail address or password is incorrect.";

      default:
        return "An error has occurred";
    }
  }
}
