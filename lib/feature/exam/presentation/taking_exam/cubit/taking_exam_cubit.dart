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
    this.getQuestionsByExamUseCase,
    this.checkQuestionsUseCase,
  ) : super(TakingExamState.initial(durationMinutes: 0));

  final GetQuestionsByExamUseCase getQuestionsByExamUseCase;
  final CheckQuestionsUseCase checkQuestionsUseCase;

  Timer? timer;
  DateTime? startedAt;
  ExamSessionArgs? session;

  void onEvent(TakingExamEvent event) {
    switch (event) {
      case TakingExamStarted(:final session):
        start(session);
      case TakingExamSelectAnswer(:final answerKey):
        selectAnswer(answerKey);
      case TakingExamNext():
        goNext();
      case TakingExamBack():
        goBack();
      case TakingExamFinish():
        submit();
      case TakingExamTimerTick():
        onTimerTick();
      case TakingExamViewScoreAfterTimeout():
        submit(fromTimeout: true);
    }
  }

  Future<void> start(ExamSessionArgs sessionArgs) async {
    session = sessionArgs;
    timer?.cancel();
    emit(TakingExamState.initial(durationMinutes: sessionArgs.durationMinutes));
    final response = await getQuestionsByExamUseCase(examId: sessionArgs.examId);
    switch (response) {
      case SuccessResponse<List<QuestionEntity>>():
        onQuestionsLoaded(response.data);
      case ErrorResponse<List<QuestionEntity>>():
        emitQuestionsError(response.errorMessage);
    }
  }

  void onQuestionsLoaded(List<QuestionEntity> questions) {
    emit(
      state.copyWith(
        questionsState: state.questionsState?.copyWith(
          isLoading: false,
          data: questions,
          errorMessage: '',
        ),
      ),
    );
    if (questions.isNotEmpty) {
      startedAt = DateTime.now();
      startTimer();
    }
  }

  void emitQuestionsError(String message) {
    emit(
      state.copyWith(
        questionsState: state.questionsState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      onEvent(const TakingExamEvent.timerTick());
    });
  }

  void onTimerTick() {
    if (state.isTimedOut || state.shouldNavigateToScore) return;
    if (state.remainingSeconds <= 1) {
      timer?.cancel();
      emit(state.copyWith(remainingSeconds: 0, isTimedOut: true));
      return;
    }
    emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
  }

  void selectAnswer(String answerKey) {
    final questions = state.questionsState?.data;
    if (questions == null || questions.isEmpty) return;
    final question = questions[state.currentIndex];
    final updated = Map<String, List<String>>.from(state.selectedAnswers)
      ..[question.id] = toggleAnswer(question, answerKey);
    emit(state.copyWith(selectedAnswers: updated));
  }

  List<String> toggleAnswer(QuestionEntity question, String answerKey) {
    final isMultiple = question.type.toLowerCase().contains('multiple');
    final current = List<String>.from(
      state.selectedAnswers[question.id] ?? const <String>[],
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
    return current;
  }

  void goNext() {
    final questions = state.questionsState?.data;
    if (questions == null) return;
    if (state.currentIndex >= questions.length - 1) return;
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void goBack() {
    if (state.currentIndex <= 0) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  Future<void> submit({bool fromTimeout = false}) async {
    if (state.submitState?.isLoading == true) return;
    timer?.cancel();
    final answers = buildAnswersPayload();
    if (answers.isEmpty && !fromTimeout) {
      emitEmptyAnswersError();
      return;
    }
    emitSubmitting(fromTimeout);
    final response = await checkQuestionsUseCase(
      answers: answers,
      time: elapsedMinutes(),
    );
    switch (response) {
      case SuccessResponse<CheckResultEntity>():
        emitSubmitSuccess(response.data);
      case ErrorResponse<CheckResultEntity>():
        emitSubmitError(response.errorMessage);
    }
  }

  List<Map<String, String>> buildAnswersPayload() {
    return state.selectedAnswers.entries
        .where((entry) => entry.value.isNotEmpty)
        .map(
          (entry) => {
            'questionId': entry.key,
            'correct': entry.value.join(','),
          },
        )
        .toList();
  }

  void emitEmptyAnswersError() {
    emit(
      state.copyWith(
        submitState: state.submitState?.copyWith(
          isLoading: false,
          errorMessage: AppStrings.answerAtLeastOne,
        ),
      ),
    );
  }

  void emitSubmitting(bool fromTimeout) {
    emit(
      state.copyWith(
        isTimedOut: fromTimeout ? true : state.isTimedOut,
        submitState: state.submitState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void emitSubmitSuccess(CheckResultEntity result) {
    emit(
      state.copyWith(
        submitState: state.submitState?.copyWith(
          isLoading: false,
          data: result,
          errorMessage: '',
        ),
        shouldNavigateToScore: true,
        isTimedOut: false,
      ),
    );
  }

  void emitSubmitError(String message) {
    emit(
      state.copyWith(
        submitState: state.submitState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }

  int elapsedMinutes() {
    final startTime = startedAt;
    final examSession = session;
    if (startTime == null || examSession == null) return 1;
    final elapsed = DateTime.now().difference(startTime).inMinutes;
    if (elapsed <= 0) return 1;
    return elapsed.clamp(1, examSession.durationMinutes);
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
