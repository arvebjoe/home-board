import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_queue_models.freezed.dart';
part 'verification_queue_models.g.dart';

@freezed
class VerificationQueueItemModel with _$VerificationQueueItemModel {
  const factory VerificationQueueItemModel({
    required String id,
    required String taskTitle,
    String? taskDescription,
    required int points,
    required String completedByUserId,
    required String completedByUserName,
    required String completedAt,
    required String date,
    String? notes,
    String? photoUrl,
  }) = _VerificationQueueItemModel;

  factory VerificationQueueItemModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationQueueItemModelFromJson(json);
}

@freezed
class RejectTaskRequest with _$RejectTaskRequest {
  const factory RejectTaskRequest({
    String? reason,
  }) = _RejectTaskRequest;

  factory RejectTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$RejectTaskRequestFromJson(json);
}
