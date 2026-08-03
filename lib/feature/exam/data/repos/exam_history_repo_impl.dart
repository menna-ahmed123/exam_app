import 'package:exam_app/feature/exam/data/data_sources/local/exam_history_local_data_source.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamHistoryRepo)
class ExamHistoryRepoImpl implements ExamHistoryRepo {
  ExamHistoryRepoImpl(this._localDataSource);

  final ExamHistoryLocalDataSource _localDataSource;

  @override
  Future<List<ExamHistoryEntity>> getHistory() {
    return _localDataSource.getHistory();
  }

  @override
  Future<List<ExamHistoryEntity>> getHistoryBySubject({
    required String subjectId,
  }) {
    return _localDataSource.getHistoryBySubject(subjectId: subjectId);
  }

  @override
  Future<void> saveHistoryEntry(ExamHistoryEntity entry) {
    return _localDataSource.saveHistoryEntry(entry);
  }
}
