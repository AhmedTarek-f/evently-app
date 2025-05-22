import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel({
    this.eventCreatorId,
    this.eventId,
    this.eventCategory,
    this.eventTitle,
    this.eventDescription,
    this.eventDate,
    this.eventTime,
    this.eventLocationLat,
    this.eventLocationLang,
  });
  final String? eventCreatorId;
  String? eventId;
  String? eventCategory;
  String? eventTitle;
  String? eventDescription;
  String? eventDate;
  String? eventTime;
  String? eventLocationLat;
  String? eventLocationLang;

  static EventModel empty() => EventModel();

  Map<String, dynamic> toFireStore() {
    return {
      "EventCreatorId": eventCreatorId ?? "",
      "EventId": eventId ?? "",
      "EventCategory": eventCategory ?? "",
      "EventTitle": eventTitle ?? "",
      "EventDescription": eventDescription ?? "",
      "EventDate": eventDate ?? "",
      "EventTime": eventTime ?? "",
      "EventLocationLat": eventLocationLat ?? "0",
      "EventLocationLang": eventLocationLang ?? "0",
    };
  }

  factory EventModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data != null) {
      return EventModel(
        eventCreatorId: data["EventCreatorId"] as String?,
        eventId: data["EventId"] as String?,
        eventCategory: data["EventCategory"] as String?,
        eventTitle: data["EventTitle"] as String?,
        eventDescription: data["EventDescription"] as String?,
        eventDate: data["EventDate"] as String?,
        eventTime: data["EventTime"] as String?,
        eventLocationLat: data["EventLocationLat"] as String?,
        eventLocationLang: data["EventLocationLang"] as String?,
      );
    } else {
      return empty();
    }
  }
}
