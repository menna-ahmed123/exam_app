import 'package:dio/dio.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/exam/api/client/exam_api_client.dart';
import 'package:exam_app/feature/exam/data/data_sources/remote/exam_remote_data_source.dart';
import 'package:exam_app/feature/exam/data/models/check_questions_request_model.dart';
import 'package:exam_app/feature/exam/data/models/check_questions_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exam_by_id_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exams_response_model.dart';
import 'package:exam_app/feature/exam/data/models/questions_response_model.dart';
import 'package:exam_app/feature/exam/data/models/subjects_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamRemoteDataSource)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  ExamRemoteDataSourceImpl({
    required this.examApiClient,
    required this.dio,
  });

  final ExamApiClient examApiClient;
  final Dio dio;

  @override
  Future<BaseResponse<SubjectsResponseModel>> getSubjects() {
    return BaseResponse.execute(examApiClient.getSubjects);
  }

  @override
  Future<BaseResponse<ExamsResponseModel>> getExams({String? subjectId}) {
    return BaseResponse.execute(
      () => examApiClient.getExams(subject: subjectId),
    );
  }

  @override
  Future<BaseResponse<ExamByIdResponseModel>> getExamById({
    required String examId,
  }) {
    return BaseResponse.execute(() => examApiClient.getExamById(examId));
  }

  @override
  Future<BaseResponse<QuestionsResponseModel>> getQuestionsByExam({
    required String examId,
  }) {
    return BaseResponse.execute(
      () => examApiClient.getQuestionsByExam(exam: examId),
    );
  }

  @override
  Future<BaseResponse<CheckQuestionsResponseModel>> checkQuestions({
    required CheckQuestionsRequestModel request,
  }) {
    return BaseResponse.execute(() async {
      final response = await dio.post<dynamic>(
        ApiConstants.checkQuestionsEndpoint,
        data: request.toJson(),
      );
      final data = response.data;
      if (data is! Map) {
        throw Exception('Unexpected check questions response.');
      }
      return CheckQuestionsResponseModel.fromJson(
        Map<String, dynamic>.from(data),
      );
    });
  }
}
