import '../core/exception/exception_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {

  PackageInfoService({required ExceptionHandler exceptionHandler})
    : _exceptionHandler = exceptionHandler;
  final ExceptionHandler _exceptionHandler;

  Future<PackageInfo?> getPackageInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo;
    } catch (e, stackTrace) {
      _exceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }
}
