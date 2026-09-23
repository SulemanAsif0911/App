import 'package:http/http.dart' as http;

/// Prepared for FastAPI. Must never block startup.
class ApiClient {
  ApiClient({this.baseUrl = 'https://api.example.invalid/api/v1'});
  final String baseUrl;
  final timeout = const Duration(seconds: 8);

  Future<bool> health() async {
    try {
      final r = await http.get(Uri.parse('$baseUrl/health')).timeout(timeout);
      return r.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
