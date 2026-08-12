import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_entity.freezed.dart';

@freezed
abstract class SubjectEntity with _$SubjectEntity {
  const factory SubjectEntity({
    required String id,
    required String name,
    required String icon,
  }) = _SubjectEntity;
}
