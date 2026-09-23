/// Signed remote content updates. If validation fails, keep last known-good.
class ContentUpdateGuard {
  const ContentUpdateGuard();

  /// Returns the bundle to use. Never applies an invalid or older package.
  String selectBundle({
    required String bundledVersion,
    required String? cachedVersion,
    required bool cachedValidSignature,
    required String? remoteVersion,
    required bool remoteValidSignature,
  }) {
    if (remoteVersion != null &&
        remoteValidSignature &&
        _newer(remoteVersion, cachedVersion ?? bundledVersion)) {
      return 'remote';
    }
    if (cachedVersion != null &&
        cachedValidSignature &&
        _newer(cachedVersion, bundledVersion)) {
      return 'cached';
    }
    return 'bundled';
  }

  bool _newer(String a, String b) => a.compareTo(b) > 0;
}
