/// Prevents sensitive values from being written to application logs.
class LogGuard {
  static const _blocked = [
    'password',
    'passwd',
    'otp',
    'token',
    'authorization',
    'private picture',
    'complaint',
  ];

  static bool isSafe(String message) {
    final t = message.toLowerCase();
    return !_blocked.any(t.contains);
  }

  static String sanitize(String message) {
    if (isSafe(message)) return message;
    return '[redacted-log]';
  }
}
