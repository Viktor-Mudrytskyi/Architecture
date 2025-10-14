// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_pair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JwtPairModel _$JwtPairModelFromJson(Map<String, dynamic> json) =>
    _JwtPairModel(
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$JwtPairModelToJson(_JwtPairModel instance) =>
    <String, dynamic>{'access': instance.access, 'refresh': instance.refresh};
