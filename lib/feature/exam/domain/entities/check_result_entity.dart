import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_result_entity.freezed.dart';

@freezed
abstract class CheckResultEntity with _$CheckResultEntity {
  const factory CheckResultEntity({
    required int correct,
    required int wrong,
    required double percentage,
  }) = _CheckResultEntity;
}
