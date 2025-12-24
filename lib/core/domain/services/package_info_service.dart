import 'package:architecture_templates/core/core_src.dart';
import 'package:dartz/dartz.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  Future<Either<PackageInfoFailure, PackageInfo>> getPackageInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return Right(packageInfo);
    } catch (e, stackTrace) {
      AppLogger.e('Failed to get package info', ex: e, stacktrace: stackTrace);
      return const Left(PackageInfoFailure());
    }
  }
}
