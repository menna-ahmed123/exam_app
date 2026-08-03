import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetExamHistoryBySubjectUseCase {
  GetExamHistoryBySubjectUseCase(this._examHistoryRepo);

  final ExamHistoryRepo _examHistoryRepo;

  Future<List<ExamHistoryEntity>> call({required String subjectId}) {
    return _examHistoryRepo.getHistoryBySubject(subjectId: subjectId);
  }
}
