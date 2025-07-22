class ApiConfig {
  // For local development
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String wsUrl = 'ws://127.0.0.1:8000/ws';

  // For production deployment
  // static const String baseUrl = 'https://your-api-domain.com';
  // static const String wsUrl = 'wss://your-api-domain.com/ws';

  // API Endpoints
  static const String uploadAndProcess = '\$baseUrl/upload_and_process';
}
