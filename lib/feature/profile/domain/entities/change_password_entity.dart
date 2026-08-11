import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_entity.freezed.dart';

@freezed
abstract class ChangePasswordEntity with _$ChangePasswordEntity {
  const factory ChangePasswordEntity({required String? token}) =
      _ChangePasswordEntity;
}
