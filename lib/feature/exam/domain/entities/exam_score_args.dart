import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_score_args.freezed.dart';

@freezed
abstract class ExamScoreArgs with _$ExamScoreArgs {
  const factory ExamScoreArgs({
    required String examId,
    required String examTitle,
    required String subjectId,
    required String subjectName,
    required int durationMinutes,
    required int numberOfQuestions,
    required int correct,
    required int wrong,
    required double percentage,
  }) = _ExamScoreArgs;
}
