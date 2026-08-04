import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';

enum AnswerOptionReviewState {
  correct,
  incorrect,
  neutral,
}

class AnswerReviewEvaluator {
  const AnswerReviewEvaluator._();

  static AnswerOptionReviewState stateForOption({
    required String optionKey,
    required Iterable<String> selectedKeys,
    required Iterable<String> correctKeys,
  }) {
    final selected = _normalizedSet(selectedKeys);
    final correct = _normalizedSet(correctKeys);
    final key = optionKey.trim().toLowerCase();

    final isSelected = key.isNotEmpty && selected.contains(key);
    final isCorrect = key.isNotEmpty && correct.contains(key);

    if (isCorrect) return AnswerOptionReviewState.correct;
    if (isSelected) return AnswerOptionReviewState.incorrect;
    return AnswerOptionReviewState.neutral;
  }

  static List<String> resolveCorrectKeys({
    required List<String> rawCorrectValues,
    required List<AnswerOptionEntity> answers,
    required List<String> selectedKeys,
    required bool isMarkedCorrect,
  }) {
    final fromRaw = mapToOptionKeys(rawCorrectValues, answers);
    if (fromRaw.isNotEmpty) return fromRaw;
    if (isMarkedCorrect) {
      return mapToOptionKeys(selectedKeys, answers);
    }
    return const [];
  }

  static List<String> mapToOptionKeys(
    List<String> values,
    List<AnswerOptionEntity> answers,
  ) {
    if (values.isEmpty) return const [];

    final byKey = <String, String>{};
    final byAnswer = <String, String>{};
    for (final option in answers) {
      final key = option.key.trim();
      if (key.isEmpty) continue;
      byKey[key.toLowerCase()] = key;
      final answer = option.answer.trim();
      if (answer.isNotEmpty) {
        byAnswer[answer.toLowerCase()] = key;
      }
    }

    final resolved = <String>[];
    for (final value in values) {
      final raw = value.trim();
      if (raw.isEmpty) continue;
      final lower = raw.toLowerCase();
      final key = byKey[lower] ?? byAnswer[lower] ?? raw;
      if (!resolved.contains(key)) resolved.add(key);
    }
    return resolved;
  }

  static Set<String> _normalizedSet(Iterable<String> values) {
    return {
      for (final value in values)
        if (value.trim().isNotEmpty) value.trim().toLowerCase(),
    };
  }
}
