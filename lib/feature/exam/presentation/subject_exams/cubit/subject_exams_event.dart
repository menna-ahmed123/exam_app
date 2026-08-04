import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_exams_event.freezed.dart';

@freezed
sealed class SubjectExamsEvent with _$SubjectExamsEvent {
  const factory SubjectExamsEvent.load({required String subjectId}) =
      SubjectExamsLoad;
}
