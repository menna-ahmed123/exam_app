import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetExamsUseCase {
  GetExamsUseCase(this._examRepo);

  final ExamRepo _examRepo;

  Future<BaseResponse<List<ExamEntity>>> call({String? subjectId}) {
    return _examRepo.getExams(subjectId: subjectId);
  }
}
