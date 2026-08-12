import 'package:exam_app/feature/exam/data/models/answer_option_model.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  @JsonKey(name: '_id')
  final String id;
  final String question;
  @JsonKey(fromJson: answersFromJson)
  final List<AnswerOptionModel> answers;
  @JsonKey(defaultValue: 'single_choice')
  final String type;
  final String? correct;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    this.type = 'single_choice',
    this.correct,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final mapped = Map<String, dynamic>.from(json);
    mapped['_id'] =
        (mapped['_id'] ?? mapped['id'] ?? mapped['questionId'] ?? '').toString();
    if (!mapped.containsKey('answers')) {
      mapped['answers'] = mapped;
    }
    return _$QuestionModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionEntity toDomain() {
    return QuestionEntity(
      id: id,
      question: question,
      answers: answers.map((answer) => answer.toDomain()).toList(),
      type: type,
      correctAnswer: correct,
    );
  }

  static List<AnswerOptionModel> answersFromJson(dynamic value) {
    if (value is List) return answersFromList(value);
    if (value is Map) return answersFromMap(Map<String, dynamic>.from(value));
    return const [];
  }

  static List<AnswerOptionModel> answersFromList(List<dynamic> value) {
    final options = <AnswerOptionModel>[];
    for (var index = 0; index < value.length; index++) {
      final option = optionFromListItem(value[index], index);
      if (option != null) options.add(option);
    }
    return options;
  }

  static AnswerOptionModel? optionFromListItem(dynamic item, int index) {
    if (item is String) {
      final text = item.trim();
      if (text.isEmpty || text == '~') return null;
      return AnswerOptionModel(answer: text, key: 'A${index + 1}');
    }
    if (item is! Map) return null;
    final map = Map<String, dynamic>.from(item);
    final answer =
        (map['answer'] ?? map['Answer'] ?? map['text'])?.toString() ?? '';
    var key = (map['key'] ?? map['Key'])?.toString().trim() ?? '';
    if (key.isEmpty) key = 'A${index + 1}';
    if (answer.isEmpty || answer == '~') return null;
    return AnswerOptionModel(answer: answer, key: key);
  }

  static List<AnswerOptionModel> answersFromMap(Map<String, dynamic> map) {
    const keys = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6'];
    final options = <AnswerOptionModel>[];
    for (final key in keys) {
      final answer = map[key];
      if (answer == null) continue;
      final text = answer.toString();
      if (text.isEmpty || text == '~') continue;
      options.add(AnswerOptionModel(answer: text, key: key));
    }
    return options;
  }
}
