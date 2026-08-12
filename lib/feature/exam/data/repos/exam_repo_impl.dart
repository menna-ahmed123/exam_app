import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/data/data_sources/remote/exam_remote_data_source.dart';
import 'package:exam_app/feature/exam/data/models/check_answer_request_model.dart';
import 'package:exam_app/feature/exam/data/models/check_questions_request_model.dart';
import 'package:exam_app/feature/exam/data/models/check_questions_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exam_by_id_response_model.dart';
import 'package:exam_app/feature/exam/data/models/exams_response_model.dart';
import 'package:exam_app/feature/exam/data/models/questions_response_model.dart';
import 'package:exam_app/feature/exam/data/models/subjects_response_model.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:exam_app/feature/exam/domain/repos/exam_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamRepo)
class ExamRepoImpl implements ExamRepo {
  ExamRepoImpl({required this.examRemoteDataSource});

  final ExamRemoteDataSource examRemoteDataSource;

  @override
  Future<BaseResponse<List<SubjectEntity>>> getSubjects() async {
    final response = await examRemoteDataSource.getSubjects();
    switch (response) {
      case SuccessResponse<SubjectsResponseModel>():
        return SuccessResponse(
          response.data.subjects.map((subject) => subject.toDomain()).toList(),
        );
      case ErrorResponse<SubjectsResponseModel>():
        return ErrorResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<List<ExamEntity>>> getExams({String? subjectId}) async {
    final response = await examRemoteDataSource.getExams(subjectId: subjectId);
    switch (response) {
      case SuccessResponse<ExamsResponseModel>():
        return SuccessResponse(
          response.data.exams.map((exam) => exam.toDomain()).toList(),
        );
      case ErrorResponse<ExamsResponseModel>():
        return ErrorResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<ExamEntity>> getExamById({required String examId}) async {
    final response = await examRemoteDataSource.getExamById(examId: examId);
    switch (response) {
      case SuccessResponse<ExamByIdResponseModel>():
        final exam = response.data.exam;
        if (exam == null) {
          return ErrorResponse(errorMessage: 'Exam not found');
        }
        return SuccessResponse(exam.toDomain());
      case ErrorResponse<ExamByIdResponseModel>():
        return ErrorResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<List<QuestionEntity>>> getQuestionsByExam({
    required String examId,
  }) async {
    final response = await examRemoteDataSource.getQuestionsByExam(
      examId: examId,
    );
    switch (response) {
      case SuccessResponse<QuestionsResponseModel>():
        return SuccessResponse(
          response.data.questions
              .map((question) => question.toDomain())
              .toList(),
        );
      case ErrorResponse<QuestionsResponseModel>():
        return ErrorResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<CheckResultEntity>> checkQuestions({
    required List<Map<String, String>> answers,
    required int time,
  }) async {
    final request = buildCheckRequest(answers: answers, time: time);
    final response = await examRemoteDataSource.checkQuestions(request: request);
    switch (response) {
      case SuccessResponse<CheckQuestionsResponseModel>():
        return SuccessResponse(response.data.toDomain());
      case ErrorResponse<CheckQuestionsResponseModel>():
        return ErrorResponse(errorMessage: response.errorMessage);
    }
  }

  CheckQuestionsRequestModel buildCheckRequest({
    required List<Map<String, String>> answers,
    required int time,
  }) {
    return CheckQuestionsRequestModel(
      answers: answers
          .map(
            (answer) => CheckAnswerRequestModel(
              questionId: answer['questionId'] ?? '',
              correct: answer['correct'] ?? '',
            ),
          )
          .toList(),
      time: time,
    );
  }
}
