class EnvironmentConfig {
  final String apiBaseUrl;

  EnvironmentConfig({required this.apiBaseUrl});
}

class AppConfig {
  static const String _env = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static late final EnvironmentConfig _config;

  static void initialize() {
    _config = _getConfigForEnvironment(_env);
  }

  static EnvironmentConfig get config {
    return _config;
  }

  static EnvironmentConfig _getConfigForEnvironment(String env) {
    switch (env) {
      case 'prod':
        return EnvironmentConfig(apiBaseUrl: 'https://dillearning.com/api');
      case 'docker':
        return EnvironmentConfig(apiBaseUrl: '/api');
      case 'dev':
      default:
        return EnvironmentConfig(apiBaseUrl: 'http://127.0.0.1:8000');
    }
  }
}
