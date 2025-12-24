import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt_pair_model.freezed.dart';
part 'jwt_pair_model.g.dart';

@freezed
abstract class JwtPairModel with _$JwtPairModel {
  const factory JwtPairModel({String? access, String? refresh}) = _JwtPairModel;

  factory JwtPairModel.fromJson(Map<String, dynamic> json) =>
      _$JwtPairModelFromJson(json);
}
