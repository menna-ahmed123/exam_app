import 'package:exam_app/feature/exam/data/models/answer_option_model.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  @JsonKey(name: '_id', fromJson: _idFromJson)
  final String id;
  @JsonKey(fromJson: _stringFromJson)
  final String question;
  @JsonKey(fromJson: _answersFromJson)
  final List<AnswerOptionModel> answers;
  @JsonKey(fromJson: _typeFromJson)
  final String type;
  @JsonKey(fromJson: _correctFromJson)
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
    mapped['_id'] = _coerceId(
      mapped['_id'] ?? mapped['id'] ?? mapped['questionId'],
    );
    mapped['correct'] = _extractCorrectRaw(mapped);

    try {
      return _$QuestionModelFromJson(mapped);
    } catch (_) {
      return QuestionModel(
        id: _idFromJson(mapped['_id']),
        question: _stringFromJson(mapped['question']),
        answers: _answersFromJson(mapped['answers'] ?? mapped),
        type: _typeFromJson(mapped['type']),
        correct: _correctFromJson(mapped['correct']),
      );
    }
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

  static dynamic _extractCorrectRaw(Map<String, dynamic> json) {
    final direct =
        json['correct'] ??
        json['correctAnswer'] ??
        json['RightAnswer'] ??
        json['correctAnswers'];

    final fromDirect = _stringifyCorrect(direct);
    if (fromDirect != null) return fromDirect;

    final answers = json['answers'];
    if (answers is! List) return null;

    final keys = <String>[];
    for (final item in answers) {
      if (item is! Map) continue;
      final map = Map<String, dynamic>.from(item);
      final flagged = map['correct'] == true || map['isCorrect'] == true;
      if (!flagged) continue;
      final key = (map['key'] ?? map['Key'])?.toString().trim();
      if (key != null && key.isNotEmpty) keys.add(key);
    }
    if (keys.isEmpty) return null;
    return keys.join(',');
  }

  static String? _stringifyCorrect(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      final parts = value
          .map(_stringifyCorrect)
          .whereType<String>()
          .where((part) => part.isNotEmpty)
          .toList();
      return parts.isEmpty ? null : parts.join(',');
    }
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      return _stringifyCorrect(
        map['key'] ?? map['Key'] ?? map['answer'] ?? map['correct'],
      );
    }
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static dynamic _coerceId(dynamic value) {
    final id = _idFromJson(value);
    return id.isEmpty ? value : id;
  }

  static String _idFromJson(dynamic value) {
    if (value == null) return '';
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      return _idFromJson(
        map['_id'] ??
            map['id'] ??
            map['questionId'] ??
            map[r'$oid'] ??
            map['oid'],
      );
    }
    return value.toString().trim();
  }

  static String _stringFromJson(dynamic value) {
    return value?.toString() ?? '';
  }

  static String _typeFromJson(dynamic value) {
    final type = value?.toString().trim();
    if (type == null || type.isEmpty) return 'single_choice';
    return type;
  }

  static String? _correctFromJson(dynamic value) {
    return _stringifyCorrect(value);
  }

  static List<AnswerOptionModel> _answersFromJson(dynamic value) {
    if (value is List) {
      final options = <AnswerOptionModel>[];
      for (var index = 0; index < value.length; index++) {
        final item = value[index];
        if (item is String) {
          final text = item.trim();
          if (text.isEmpty) continue;
          options.add(
            AnswerOptionModel(answer: text, key: 'A${index + 1}'),
          );
          continue;
        }
        if (item is! Map) continue;
        final map = Map<String, dynamic>.from(item);
        final answer =
            (map['answer'] ?? map['Answer'] ?? map['text'])?.toString() ?? '';
        var key =
            (map['key'] ?? map['Key'])?.toString().trim() ?? '';
        if (key.isEmpty) key = 'A${index + 1}';
        if (answer.isEmpty) continue;
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
