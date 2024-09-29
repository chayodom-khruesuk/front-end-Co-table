class Exceptions implements Exception {
  final String message;

  const Exceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);

  factory Exceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const Exceptions(
            'The email address is already registered. Please use a different email.');

      case 'invalid-email':
        return const Exceptions(
            'The email address provided is invalid. Please enter a valid email.');

      case 'weak-password':
        return const Exceptions(
            'The password is too weak. Please choose a stronger password.');

      case 'user-disabled':
        return const Exceptions(
            'This user account has been disabled. Please contact support for assistance.');

      case 'user-not-found':
        return const Exceptions('Invalid login details. User not found.');

      case 'wrong-password':
        return const Exceptions(
            'Incorrect password. Please check your password and try again.');

      case 'INVALID_LOGIN_CREDENTIALS':
        return const Exceptions(
            'Invalid login credentials. Please double-check your information.');

      case 'too-many-requests':
        return const Exceptions('Too many requests. Please try again later.');

      case 'invalid-argument':
        return const Exceptions(
            'Invalid argument provided to the authentication method.');

      case 'invalid-password':
        return const Exceptions('Incorrect password. Please try again.');

      case 'sign_in_failed':
        return const Exceptions('Sign-in failed. Please try again.');

      case 'network-request-failed':
        return const Exceptions(
            'Network request failed. Please check your internet connection.');

      case 'internal-error':
        return const Exceptions('Internal error. Please try again later.');

      default:
        return const Exceptions();
    }
  }
}
