import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_history_event.freezed.dart';

@freezed
sealed class ExamHistoryEvent with _$ExamHistoryEvent {
  const factory ExamHistoryEvent.load() = ExamHistoryLoad;
}
