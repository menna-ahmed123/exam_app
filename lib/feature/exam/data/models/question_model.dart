import 'package:exam_app/feature/exam/data/models/answer_option_model.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  @JsonKey(name: '_id')
  final String id;
  final String question;
  @JsonKey(fromJson: _answersFromJson)
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

  static List<AnswerOptionModel> _answersFromJson(dynamic value) {
    if (value is List) {
      final options = <AnswerOptionModel>[];
      for (var index = 0; index < value.length; index++) {
        final item = value[index];
        if (item is String) {
          final text = item.trim();
          if (text.isEmpty || text == '~') continue;
          options.add(AnswerOptionModel(answer: text, key: 'A${index + 1}'));
          continue;
        }
        if (item is! Map) continue;
        final map = Map<String, dynamic>.from(item);
        final answer =
            (map['answer'] ?? map['Answer'] ?? map['text'])?.toString() ?? '';
        var key = (map['key'] ?? map['Key'])?.toString().trim() ?? '';
        if (key.isEmpty) key = 'A${index + 1}';
        if (answer.isEmpty || answer == '~') continue;
        options.add(AnswerOptionModel(answer: answer, key: key));
      }
      return options;
    }

    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
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

    return const [];
  }
}
