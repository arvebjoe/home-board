import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/verification_queue_models.dart';
import '../repositories/verification_queue_repository.dart';

part 'verification_queue_provider.g.dart';

@riverpod
class VerificationQueue extends _$VerificationQueue {
  @override
  Future<List<VerificationQueueItemModel>> build() async {
    return _fetchVerificationQueue();
  }

  Future<List<VerificationQueueItemModel>> _fetchVerificationQueue() async {
    final repository = ref.read(verificationQueueRepositoryProvider);
    return await repository.getVerificationQueue();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchVerificationQueue());
  }

  Future<void> verifyTask(String completionId) async {
    try {
      final repository = ref.read(verificationQueueRepositoryProvider);
      await repository.verifyTask(completionId);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rejectTask(String completionId, String? reason) async {
    try {
      final repository = ref.read(verificationQueueRepositoryProvider);
      await repository.rejectTask(completionId, reason);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }
}
