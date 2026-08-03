import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';

abstract class ExamRepo {
  Future<BaseResponse<List<SubjectEntity>>> getSubjects();

  Future<BaseResponse<List<ExamEntity>>> getExams({String? subjectId});

  Future<BaseResponse<ExamEntity>> getExamById({required String examId});

  Future<BaseResponse<List<QuestionEntity>>> getQuestionsByExam({
    required String examId,
  });

  Future<BaseResponse<CheckResultEntity>> checkQuestions({
    required List<Map<String, String>> answers,
    required int time,
  });
}
