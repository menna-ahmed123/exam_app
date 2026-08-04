import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SaveExamHistoryUseCase {
  SaveExamHistoryUseCase(this._examHistoryRepo);

  final ExamHistoryRepo _examHistoryRepo;

  Future<void> call(ExamHistoryEntity entry) {
    return _examHistoryRepo.saveHistoryEntry(entry);
  }
}
