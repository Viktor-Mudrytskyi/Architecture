import 'package:architecture_templates/core/exception/exception_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  final ExceptionHandler _exceptionHandler;

  PackageInfoService({required ExceptionHandler exceptionHandler})
    : _exceptionHandler = exceptionHandler;

  Future<PackageInfo?> getPackageInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo;
    } catch (e, stackTrace) {
      _exceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }
}
