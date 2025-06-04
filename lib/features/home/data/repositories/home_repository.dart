import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/home/data/data_sources/home_remote_data.dart';

abstract class HomeRepository {
  static Stream<Either<Failure, List<EventModel>>> fetchAllEvents() async* {
    yield* HomeRemoteData.fetchAllEvents();
  }

  static Future<Either<Failure, void>> updateFavoriteEvents({
    required String userId,
    required List<String> favoriteEventsList,
  }) async {
    return await HomeRemoteData.updateFavoriteEvents(
      userId: userId,
      favoriteEventsList: favoriteEventsList,
    );
  }
}
