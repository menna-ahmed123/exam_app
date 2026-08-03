import 'package:exam_app/feature/exam/data/models/check_questions_response_model.dart';
import 'package:exam_app/feature/exam/data/models/question_model.dart';
import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:exam_app/feature/exam/domain/utils/answer_review_evaluator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnswerReviewEvaluator.stateForOption', () {
    test('selected correct is green', () {
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'A1',
          selectedKeys: ['A1'],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.correct,
      );
    });

    test('selected wrong is red', () {
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'A2',
          selectedKeys: ['A2'],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.incorrect,
      );
    });

    test('unselected correct is green', () {
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'A1',
          selectedKeys: ['A2'],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.correct,
      );
    });

    test('unanswered shows only correct green', () {
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'A1',
          selectedKeys: const [],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.correct,
      );
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'A2',
          selectedKeys: const [],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.neutral,
      );
    });

    test('comparison is case-insensitive', () {
      expect(
        AnswerReviewEvaluator.stateForOption(
          optionKey: 'a1',
          selectedKeys: ['A1'],
          correctKeys: ['A1'],
        ),
        AnswerOptionReviewState.correct,
      );
    });
  });

  group('AnswerReviewEvaluator.resolveCorrectKeys', () {
    final answers = [
      const AnswerOptionEntity(answer: 'Paris', key: 'A1'),
      const AnswerOptionEntity(answer: 'London', key: 'A2'),
      const AnswerOptionEntity(answer: 'Berlin', key: 'A3'),
    ];

    test('maps correct key directly', () {
      expect(
        AnswerReviewEvaluator.resolveCorrectKeys(
          rawCorrectValues: ['A3'],
          answers: answers,
          selectedKeys: ['A1'],
          isMarkedCorrect: false,
        ),
        ['A3'],
      );
    });

    test('maps correct answer text to key', () {
      expect(
        AnswerReviewEvaluator.resolveCorrectKeys(
          rawCorrectValues: ['Berlin'],
          answers: answers,
          selectedKeys: ['A1'],
          isMarkedCorrect: false,
        ),
        ['A3'],
      );
    });

    test('falls back to selected only when marked correct', () {
      expect(
        AnswerReviewEvaluator.resolveCorrectKeys(
          rawCorrectValues: const [],
          answers: answers,
          selectedKeys: ['A1'],
          isMarkedCorrect: true,
        ),
        ['A1'],
      );
      expect(
        AnswerReviewEvaluator.resolveCorrectKeys(
          rawCorrectValues: const [],
          answers: answers,
          selectedKeys: ['A1'],
          isMarkedCorrect: false,
        ),
        isEmpty,
      );
    });
  });

  group('QuestionModel / check response mapping', () {
    test('reads questionId and correct from WrongQuestions', () {
      final model = CheckQuestionsResponseModel.fromJson({
        'message': 'success',
        'correct': 1,
        'wrong': 1,
        'total': '50%',
        'WrongQuestions': [
          {
            'questionId': 'q-wrong',
            'question': 'Capital of Germany?',
            'answers': [
              {'answer': 'Paris', 'key': 'A1'},
              {'answer': 'Berlin', 'key': 'A2'},
            ],
            'correct': 'A2',
            'type': 'single_choice',
          },
        ],
        'correctQuestions': [
          {
            '_id': 'q-correct',
            'question': 'Capital of France?',
            'answers': [
              {'answer': 'Paris', 'key': 'A1'},
              {'answer': 'London', 'key': 'A2'},
            ],
            'type': 'single_choice',
          },
        ],
      });

      final domain = model.toDomain();
      expect(domain.wrongQuestionIds, ['q-wrong']);
      expect(domain.correctQuestionIds, ['q-correct']);

      final wrong = domain.reviewQuestions.firstWhere(
        (q) => q.questionId == 'q-wrong',
      );
      expect(wrong.correctKeys, ['A2']);
    });

    test('parses ObjectId map and answer-text correct value', () {
      final question = QuestionModel.fromJson({
        '_id': {r'$oid': 'abc123'},
        'question': 'Q?',
        'answers': [
          {'Answer': 'Yes', 'Key': 'A1'},
          {'Answer': 'No', 'Key': 'A2'},
        ],
        'correct': 'Yes',
      });

      expect(question.id, 'abc123');
      expect(question.correct, 'Yes');
      expect(question.answers.first.key, 'A1');
      expect(question.toDomain().correctAnswer, 'Yes');
    });
  });
}
