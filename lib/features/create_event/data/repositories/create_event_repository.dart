import 'package:dartz/dartz.dart';
import 'package:evently_app/core/utils/errors/failure.dart';
import 'package:evently_app/features/create_event/data/data_sources/remote_data_sources/create_event_remote_data.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class CreateEventRepository {
  static Future<Either<Failure, void>> createEvent({
    required EventModel eventData,
  }) async {
    return await CreateEventRemoteData.createEvent(
      eventData: eventData,
    );
  }
}
