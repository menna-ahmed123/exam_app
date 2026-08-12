import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_event.freezed.dart';

@freezed
sealed class ExploreEvent with _$ExploreEvent {
  const factory ExploreEvent.loadSubjects() = ExploreLoadSubjects;
  const factory ExploreEvent.searchChanged(String query) = ExploreSearchChanged;
}
