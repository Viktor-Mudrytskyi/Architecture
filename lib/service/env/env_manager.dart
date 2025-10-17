import 'package:architecture_templates/service/env/env_config.dart';
import 'package:architecture_templates/service/env/flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final class EnvService {
  const EnvService({required this.flavor});
  final Flavor flavor;

  bool get isDev => flavor == Flavor.dev;
  bool get isProd => flavor == Flavor.prod;

  T map<T>({required T Function() onDev, required T Function() onProd}) {
    switch (flavor) {
      case Flavor.dev:
        return onDev();
      case Flavor.prod:
        return onProd();
    }
  }

  Future<EnvConfig> getEnvConfig() async {
    final filePath = map(
      onDev: () => 'lib/env/.env.dev',
      onProd: () => 'lib/env/.env.prod',
    );
    await dotenv.load(fileName: filePath);
    return EnvConfig(baseUrl: dotenv.env['BASE_URL'] ?? '');
  }
}
