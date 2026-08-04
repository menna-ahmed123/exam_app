import 'package:exam_app/feature/exam/data/models/question_model.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:exam_app/feature/exam/domain/utils/answer_review_evaluator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_questions_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckQuestionsResponseModel {
  final String message;
  @JsonKey(fromJson: _intFromJson)
  final int correct;
  @JsonKey(fromJson: _intFromJson)
  final int wrong;
  @JsonKey(fromJson: _percentageFromJson)
  final double percentage;
  @JsonKey(name: 'WrongQuestions', fromJson: _questionsFromJson)
  final List<QuestionModel> wrongQuestions;
  @JsonKey(name: 'correctQuestions', fromJson: _questionsFromJson)
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

    void upsert({
      required QuestionModel question,
      required bool isCorrectList,
    }) {
      if (question.id.isEmpty) return;

      if (isCorrectList) {
        if (!correctIds.contains(question.id)) correctIds.add(question.id);
      } else {
        if (!wrongIds.contains(question.id)) wrongIds.add(question.id);
      }

      final existing = reviewById[question.id];
      final answers = question.answers.isNotEmpty
          ? question.answers.map((answer) => answer.toDomain()).toList()
          : (existing?.answers ?? const []);
      final rawCorrect = _splitKeys(question.correct);
      final correctKeys = AnswerReviewEvaluator.resolveCorrectKeys(
        rawCorrectValues: rawCorrect.isNotEmpty
            ? rawCorrect
            : (existing?.correctKeys ?? const []),
        answers: answers,
        selectedKeys: const [],
        isMarkedCorrect: false,
      );

      reviewById[question.id] = ExamAnswerReviewEntity(
        questionId: question.id,
        question: question.question.isNotEmpty
            ? question.question
            : (existing?.question ?? ''),
        answers: answers,
        type: question.type,
        selectedKeys: const [],
        correctKeys: correctKeys.isNotEmpty
            ? correctKeys
            : (existing?.correctKeys ?? const []),
      );
    }

    for (final question in wrongQuestions) {
      upsert(question: question, isCorrectList: false);
    }
    for (final question in correctQuestions) {
      upsert(question: question, isCorrectList: true);
    }

    return CheckResultEntity(
      correct: correct,
      wrong: wrong,
      percentage: percentage,
      reviewQuestions: reviewById.values.toList(),
      correctQuestionIds: correctIds,
      wrongQuestionIds: wrongIds,
    );
  }

  static List<String> _splitKeys(String? value) {
    if (value == null || value.trim().isEmpty) return const [];
    return value
        .split(',')
        .map((key) => key.trim())
        .where((key) => key.isNotEmpty)
        .toList();
  }

  static int _intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }

  static List<QuestionModel> _questionsFromJson(dynamic value) {
    if (value is! List) return const [];
    final questions = <QuestionModel>[];
    for (final item in value) {
      if (item is String) {
        final id = item.trim();
        if (id.isEmpty) continue;
        questions.add(
          QuestionModel(id: id, question: '', answers: const []),
        );
        continue;
      }
      if (item is! Map) continue;
      try {
        questions.add(
          QuestionModel.fromJson(Map<String, dynamic>.from(item)),
        );
      } catch (_) {}
    }
    return questions;
  }
}
