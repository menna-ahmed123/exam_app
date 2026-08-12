import 'dart:convert';

import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';
import 'package:exam_app/feature/exam/data/data_sources/local/exam_history_local_data_source.dart';
import 'package:exam_app/feature/exam/data/models/exam_history_model.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamHistoryLocalDataSource)
class ExamHistoryLocalDataSourceImpl implements ExamHistoryLocalDataSource {
  ExamHistoryLocalDataSourceImpl(this.secureStorageService);

  final SecureStorageService secureStorageService;

  @override
  Future<List<ExamHistoryEntity>> getHistory() async {
    final models = await readModels();
    final entities = models.map((model) => model.toDomain()).toList()
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return entities;
  }

  @override
  Future<List<ExamHistoryEntity>> getHistoryBySubject({
    required String subjectId,
  }) async {
    final history = await getHistory();
    return history.where((entry) => entry.subjectId == subjectId).toList();
  }

  @override
  Future<void> saveHistoryEntry(ExamHistoryEntity entry) async {
    final models = await readModels();
    models.insert(0, ExamHistoryModel.fromDomain(entry));
    await writeModels(models);
  }

  Future<List<ExamHistoryModel>> readModels() async {
    final raw = await secureStorageService.read(key: StorageKeys.examHistory);
    if (raw == null || raw.isEmpty) return [];
    try {
      return parseModels(jsonDecode(raw));
    } on FormatException {
      return [];
    }
  }

  List<ExamHistoryModel> parseModels(dynamic decoded) {
    if (decoded is! List) return [];
    return decoded
        .whereType<Map>()
        .map((item) => ExamHistoryModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> writeModels(List<ExamHistoryModel> models) {
    final payload = jsonEncode(models.map((model) => model.toJson()).toList());
    return secureStorageService.write(
      key: StorageKeys.examHistory,
      value: payload,
    );
  }
}
