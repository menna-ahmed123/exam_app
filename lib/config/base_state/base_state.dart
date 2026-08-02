import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

@freezed
abstract class BaseState<T> with _$BaseState<T> {
  const factory BaseState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    T? data,
  }) = _BaseState<T>;
}
