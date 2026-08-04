import 'dart:async';

import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/check_questions_use_case.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_questions_by_exam_use_case.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_event.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TakingExamCubit extends Cubit<TakingExamState> {
  TakingExamCubit(
    this._getQuestionsByExamUseCase,
    this._checkQuestionsUseCase,
  ) : super(TakingExamState.initial(durationMinutes: 0));

  final GetQuestionsByExamUseCase _getQuestionsByExamUseCase;
  final CheckQuestionsUseCase _checkQuestionsUseCase;

  Timer? _timer;
  DateTime? _startedAt;
  ExamSessionArgs? _session;

  void onEvent(TakingExamEvent event) {
    switch (event) {
      case TakingExamStarted(:final session):
        _start(session);
      case TakingExamSelectAnswer(:final answerKey):
        _selectAnswer(answerKey);
      case TakingExamNext():
        _goNext();
      case TakingExamBack():
        _goBack();
      case TakingExamFinish():
        _submit();
      case TakingExamTimerTick():
        _onTimerTick();
      case TakingExamViewScoreAfterTimeout():
        _submit(fromTimeout: true);
    }
  }

  Future<void> _start(ExamSessionArgs session) async {
    _session = session;
    _timer?.cancel();
    emit(TakingExamState.initial(durationMinutes: session.durationMinutes));

    final response = await _getQuestionsByExamUseCase(examId: session.examId);
    switch (response) {
      case SuccessResponse<List<QuestionEntity>>():
        emit(
          state.copyWith(
            questionsState: state.questionsState?.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
          ),
        );
        if (response.data.isNotEmpty) {
          _startedAt = DateTime.now();
          _startTimer();
        }
      case ErrorResponse<List<QuestionEntity>>():
        emit(
          state.copyWith(
            questionsState: state.questionsState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      onEvent(const TakingExamEvent.timerTick());
    });
  }

  void _onTimerTick() {
    if (state.isTimedOut || state.shouldNavigateToScore) return;
    if (state.remainingSeconds <= 1) {
      _timer?.cancel();
      emit(state.copyWith(remainingSeconds: 0, isTimedOut: true));
      return;
    }
    emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
  }

  void _selectAnswer(String answerKey) {
    final questions = state.questionsState?.data;
    if (questions == null || questions.isEmpty) return;

    final question = questions[state.currentIndex];
    final questionId = question.id;
    final isMultiple = question.type.toLowerCase().contains('multiple');
    final current = List<String>.from(
      state.selectedAnswers[questionId] ?? const <String>[],
    );

    if (isMultiple) {
      if (current.contains(answerKey)) {
        current.remove(answerKey);
      } else {
        current.add(answerKey);
      }
    } else {
      current
        ..clear()
        ..add(answerKey);
    }

    final updated = Map<String, List<String>>.from(state.selectedAnswers)
      ..[questionId] = current;
    emit(state.copyWith(selectedAnswers: updated));
  }

  void _goNext() {
    final questions = state.questionsState?.data;
    if (questions == null) return;
    if (state.currentIndex >= questions.length - 1) return;
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void _goBack() {
    if (state.currentIndex <= 0) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  Future<void> _submit({bool fromTimeout = false}) async {
    if (state.submitState?.isLoading == true) return;
    _timer?.cancel();

    final answers = state.selectedAnswers.entries
        .where((entry) => entry.value.isNotEmpty)
        .map(
          (entry) => {
            'questionId': entry.key,
            'correct': entry.value.join(','),
          },
        )
        .toList();

    if (answers.isEmpty && !fromTimeout) {
      emit(
        state.copyWith(
          submitState: state.submitState?.copyWith(
            isLoading: false,
            errorMessage: AppStrings.answerAtLeastOne,
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isTimedOut: fromTimeout ? true : state.isTimedOut,
        submitState: state.submitState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final response = await _checkQuestionsUseCase(
      answers: answers,
      time: _elapsedMinutes(),
    );

    switch (response) {
      case SuccessResponse<CheckResultEntity>():
        emit(
          state.copyWith(
            submitState: state.submitState?.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
            shouldNavigateToScore: true,
            isTimedOut: false,
          ),
        );
      case ErrorResponse<CheckResultEntity>():
        emit(
          state.copyWith(
            submitState: state.submitState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  int _elapsedMinutes() {
    final startedAt = _startedAt;
    final session = _session;
    if (startedAt == null || session == null) return 1;
    final elapsed = DateTime.now().difference(startedAt).inMinutes;
    if (elapsed <= 0) return 1;
    return elapsed.clamp(1, session.durationMinutes);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
