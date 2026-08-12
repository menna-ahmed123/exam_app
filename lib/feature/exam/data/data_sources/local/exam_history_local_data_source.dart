import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';

abstract class ExamHistoryLocalDataSource {
  Future<List<ExamHistoryEntity>> getHistory();

  Future<List<ExamHistoryEntity>> getHistoryBySubject({
    required String subjectId,
  });

  Future<void> saveHistoryEntry(ExamHistoryEntity entry);
}
