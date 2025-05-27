import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/favorite/data/data_sources/favorite_remote_data.dart';

abstract class FavoriteRepository {
  static Future<Either<Failure, void>> updateFavoriteEvents({
    required String userId,
    required List<String> favoriteEventsList,
  }) async {
    return await FavoriteRemoteData.updateFavoriteEvents(
      userId: userId,
      favoriteEventsList: favoriteEventsList,
    );
  }

  static List<EventModel> getFavoriteEvents({
    required List<String> favoriteEventIds,
  }) {
    final List<EventModel> favoriteList = [];
    for (int i = 0; i < favoriteEventIds.length; i++) {
      for (int j = 0; j < EventlyMethodsHelper.allEvents.length; j++) {
        if (favoriteEventIds[i] == EventlyMethodsHelper.allEvents[j].eventId) {
          favoriteList.add(EventlyMethodsHelper.allEvents[j]);
          break;
        }
      }
    }
    favoriteList.sort((a, b) {
      if (a.eventDate == null && b.eventDate == null) return 0;
      if (a.eventDate == null) return 1;
      if (b.eventDate == null) return -1;
      return a.eventDate!.compareTo(b.eventDate!);
    });
    return favoriteList;
  }
}
