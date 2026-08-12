import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_session_args.freezed.dart';

@freezed
abstract class ExamSessionArgs with _$ExamSessionArgs {
  const factory ExamSessionArgs({
    required String examId,
    required String examTitle,
    required String subjectId,
    required String subjectName,
    required int durationMinutes,
    required int numberOfQuestions,
  }) = _ExamSessionArgs;
}
