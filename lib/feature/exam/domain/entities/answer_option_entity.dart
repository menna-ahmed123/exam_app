import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_option_entity.freezed.dart';

@freezed
abstract class AnswerOptionEntity with _$AnswerOptionEntity {
  const factory AnswerOptionEntity({
    required String answer,
    required String key,
  }) = _AnswerOptionEntity;
}
