import 'package:exam_app/feature/exam/data/models/question_model.dart';
import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:exam_app/feature/exam/domain/utils/answer_review_evaluator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_questions_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckQuestionsResponseModel {
  final String message;
  @JsonKey(fromJson: intFromJson)
  final int correct;
  @JsonKey(fromJson: intFromJson)
  final int wrong;
  @JsonKey(fromJson: percentageFromJson)
  final double percentage;
  @JsonKey(name: 'WrongQuestions', fromJson: questionsFromJson)
  final List<QuestionModel> wrongQuestions;
  @JsonKey(name: 'correctQuestions', fromJson: questionsFromJson)
  final List<QuestionModel> correctQuestions;

  CheckQuestionsResponseModel({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.percentage,
    this.wrongQuestions = const [],
    this.correctQuestions = const [],
  });

  factory CheckQuestionsResponseModel.fromJson(Map<String, dynamic> json) {
    final mapped = Map<String, dynamic>.from(json);
    if (!mapped.containsKey('percentage') && mapped.containsKey('total')) {
      mapped['percentage'] = mapped['total'];
    }
    if (!mapped.containsKey('WrongQuestions') &&
        mapped.containsKey('wrongQuestions')) {
      mapped['WrongQuestions'] = mapped['wrongQuestions'];
    }
    if (!mapped.containsKey('correctQuestions') &&
        mapped.containsKey('CorrectQuestions')) {
      mapped['correctQuestions'] = mapped['CorrectQuestions'];
    }
    return _$CheckQuestionsResponseModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$CheckQuestionsResponseModelToJson(this);

  CheckResultEntity toDomain() {
    final correctIds = <String>[];
    final wrongIds = <String>[];
    final reviewById = <String, ExamAnswerReviewEntity>{};
    upsertAll(wrongQuestions, false, correctIds, wrongIds, reviewById);
    upsertAll(correctQuestions, true, correctIds, wrongIds, reviewById);
    return buildResult(correctIds, wrongIds, reviewById);
  }

  CheckResultEntity buildResult(
    List<String> correctIds,
    List<String> wrongIds,
    Map<String, ExamAnswerReviewEntity> reviewById,
  ) {
    return CheckResultEntity(
      correct: correct,
      wrong: wrong,
      percentage: percentage,
      reviewQuestions: reviewById.values.toList(),
      correctQuestionIds: correctIds,
      wrongQuestionIds: wrongIds,
    );
  }

  void upsertAll(
    List<QuestionModel> questions,
    bool isCorrectList,
    List<String> correctIds,
    List<String> wrongIds,
    Map<String, ExamAnswerReviewEntity> reviewById,
  ) {
    for (final question in questions) {
      upsertQuestion(
        question: question,
        isCorrectList: isCorrectList,
        correctIds: correctIds,
        wrongIds: wrongIds,
        reviewById: reviewById,
      );
    }
  }

  void upsertQuestion({
    required QuestionModel question,
    required bool isCorrectList,
    required List<String> correctIds,
    required List<String> wrongIds,
    required Map<String, ExamAnswerReviewEntity> reviewById,
  }) {
    if (question.id.isEmpty) return;
    trackQuestionId(
      questionId: question.id,
      isCorrectList: isCorrectList,
      correctIds: correctIds,
      wrongIds: wrongIds,
    );
    reviewById[question.id] = buildReviewEntity(
      question: question,
      existing: reviewById[question.id],
    );
  }

  void trackQuestionId({
    required String questionId,
    required bool isCorrectList,
    required List<String> correctIds,
    required List<String> wrongIds,
  }) {
    if (isCorrectList) {
      if (!correctIds.contains(questionId)) correctIds.add(questionId);
      return;
    }
    if (!wrongIds.contains(questionId)) wrongIds.add(questionId);
  }

  ExamAnswerReviewEntity buildReviewEntity({
    required QuestionModel question,
    required ExamAnswerReviewEntity? existing,
  }) {
    final answers = resolveAnswers(question, existing);
    final correctKeys = resolveCorrectKeys(question, existing, answers);
    return ExamAnswerReviewEntity(
      questionId: question.id,
      question: question.question.isNotEmpty
          ? question.question
          : (existing?.question ?? ''),
      answers: answers,
      type: question.type,
      selectedKeys: const [],
      correctKeys: correctKeys,
    );
  }

  List<String> resolveCorrectKeys(
    QuestionModel question,
    ExamAnswerReviewEntity? existing,
    List<AnswerOptionEntity> answers,
  ) {
    final rawCorrect = splitKeys(question.correct);
    final keys = AnswerReviewEvaluator.resolveCorrectKeys(
      rawCorrectValues:
          rawCorrect.isNotEmpty ? rawCorrect : (existing?.correctKeys ?? const []),
      answers: answers,
      selectedKeys: const [],
      isMarkedCorrect: false,
    );
    if (keys.isNotEmpty) return keys;
    return existing?.correctKeys ?? const [];
  }

  List<AnswerOptionEntity> resolveAnswers(
    QuestionModel question,
    ExamAnswerReviewEntity? existing,
  ) {
    if (question.answers.isNotEmpty) {
      return question.answers.map((answer) => answer.toDomain()).toList();
    }
    return existing?.answers ?? const [];
  }

  static List<String> splitKeys(String? value) {
    if (value == null || value.trim().isEmpty) return const [];
    return value
        .split(',')
        .map((key) => key.trim())
        .where((key) => key.isNotEmpty)
        .toList();
  }

  static int intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }

  static double percentageFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }

  static List<QuestionModel> questionsFromJson(dynamic value) {
    if (value is! List) return const [];
    final questions = <QuestionModel>[];
    for (final item in value) {
      final question = questionFromItem(item);
      if (question != null) questions.add(question);
    }
    return questions;
  }

  static QuestionModel? questionFromItem(dynamic item) {
    if (item is String) {
      final id = item.trim();
      if (id.isEmpty) return null;
      return QuestionModel(id: id, question: '', answers: const []);
    }
    if (item is! Map) return null;
    try {
      return QuestionModel.fromJson(Map<String, dynamic>.from(item));
    } catch (_) {
      return null;
    }
  }
}
