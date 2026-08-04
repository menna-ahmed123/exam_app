import 'package:exam_app/feature/exam/data/data_sources/local/exam_history_local_data_source.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamHistoryRepo)
class ExamHistoryRepoImpl implements ExamHistoryRepo {
  ExamHistoryRepoImpl({required this.examHistoryLocalDataSource});

  final ExamHistoryLocalDataSource examHistoryLocalDataSource;

  @override
  Future<List<ExamHistoryEntity>> getHistory() {
    return examHistoryLocalDataSource.getHistory();
  }

  @override
  Future<List<ExamHistoryEntity>> getHistoryBySubject({
    required String subjectId,
  }) {
    return examHistoryLocalDataSource.getHistoryBySubject(subjectId: subjectId);
  }

  @override
  Future<void> saveHistoryEntry(ExamHistoryEntity entry) {
    return examHistoryLocalDataSource.saveHistoryEntry(entry);
  }
}
