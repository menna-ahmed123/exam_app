import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/exam/data/models/exam_by_id_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exams_response_model.dart';
import 'package:exam_app/feature/exam/data/models/subjects_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'exam_api_client.g.dart';

@RestApi()
abstract class ExamApiClient {
  factory ExamApiClient(Dio dio, {String baseUrl}) = _ExamApiClient;

  @GET(ApiConstants.subjectsEndpoint)
  Future<SubjectsResponseModel> getSubjects();

  @GET(ApiConstants.examsEndpoint)
  Future<ExamsResponseModel> getExams({
    @Query('subject') String? subject,
  });

  @GET('${ApiConstants.examsEndpoint}/{examId}')
  Future<ExamByIdResponseModel> getExamById(@Path('examId') String examId);
}
