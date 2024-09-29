class PlatformException implements Exception {
  final String code;

  PlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';

      case 'too-many-requests':
        return 'Too many requests. Please try again later.';

      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';

      case 'invalid-password':
        return 'Incorrect password. Please try again.';

      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';

      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';

      case 'internal-error':
        return 'Internal error. Please try again later.';

      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}
