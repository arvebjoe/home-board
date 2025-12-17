import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_provider.dart';
import '../models/verification_queue_models.dart';

part 'verification_queue_repository.g.dart';

@riverpod
VerificationQueueRepository verificationQueueRepository(
    VerificationQueueRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return VerificationQueueRepository(dio);
}

class VerificationQueueRepository {
  final Dio _dio;

  VerificationQueueRepository(this._dio);

  Future<List<VerificationQueueItemModel>> getVerificationQueue() async {
    try {
      final response = await _dio.get('/verification/pending');
      final List<dynamic> data = response.data;
      return data
          .map((json) => VerificationQueueItemModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyTask(String completionId) async {
    try {
      await _dio.post('/verification/$completionId/verify');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectTask(String completionId, String? reason) async {
    try {
      await _dio.post(
        '/verification/$completionId/reject',
        data: reason != null ? {'reason': reason} : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
