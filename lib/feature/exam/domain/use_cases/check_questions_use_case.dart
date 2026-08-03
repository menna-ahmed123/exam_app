import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CheckQuestionsUseCase {
  CheckQuestionsUseCase(this._examRepo);

  final ExamRepo _examRepo;

  Future<BaseResponse<CheckResultEntity>> call({
    required List<Map<String, String>> answers,
    required int time,
  }) {
    return _examRepo.checkQuestions(answers: answers, time: time);
  }
}
