import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/data/models/exam_by_id_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exams_response_model.dart';
import 'package:exam_app/feature/exam/data/models/subjects_response_model.dart';

abstract class ExamRemoteDataSource {
  Future<BaseResponse<SubjectsResponseModel>> getSubjects();

  Future<BaseResponse<ExamsResponseModel>> getExams({String? subjectId});

  Future<BaseResponse<ExamByIdResponseModel>> getExamById({
    required String examId,
  });
}
