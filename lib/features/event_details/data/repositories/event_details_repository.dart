import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/event_details/data/data_sources/remote_data/event_details_remote_data.dart';

abstract class EventDetailsRepository {
  static Future<Either<Failure, UserModel>> fetchEventCreator({
    required String userId,
  }) async {
    return await EventDetailsRemoteData.fetchEventCreator(userId: userId);
  }

  static Future<Either<Failure, List<UserModel>>> fetchParticipateUsers({
    required List<String> participateUserIds,
  }) async {
    return await EventDetailsRemoteData.fetchParticipateUsers(
      participateUserIds: participateUserIds,
    );
  }

  static Future<Either<Failure, void>> participateInEvent({
    required String eventId,
    required List<String> participateUserIds,
  }) async {
    return await EventDetailsRemoteData.participateInEvent(
      participateUserIds: participateUserIds,
      eventId: eventId,
    );
  }

  static Future<Either<Failure, void>> deleteEvent({
    required String eventId,
  }) async {
    return await EventDetailsRemoteData.deleteEvent(
      eventId: eventId,
    );
  }
}
