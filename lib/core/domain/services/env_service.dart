import 'package:architecture_templates/core/core_src.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvService {
  Future<EnvConfig> loadConfig();
}

class EnvServiceImpl implements EnvService {
  EnvServiceImpl();

  static const dir = 'lib/core/env/';

  @override
  Future<EnvConfig> loadConfig() async {
    const flavorStr = String.fromEnvironment('flavor');
    const filePath = '$dir.env.$flavorStr';
    await dotenv.load(fileName: filePath);
    AppLogger.i('Loaded env file: $filePath');
    return EnvConfigImpl(
      flavor: Flavor.fromString(flavorStr),
      launchMode: LaunchMode.fromRuntime(),
      baseUrl: dotenv.env['BASE_URL'] ?? '',
    );
  }
}
