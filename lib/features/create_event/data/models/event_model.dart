import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel({
    this.eventCreatorId,
    this.eventId,
    this.eventCategory,
    this.eventTitle,
    this.eventDescription,
    this.eventDate,
    this.eventLocationLat,
    this.eventLocationLong,
    this.eventCountry,
    this.eventCity,
    this.participateUsers,
  });
  final String? eventCreatorId;
  String? eventId;
  String? eventCategory;
  String? eventTitle;
  String? eventDescription;
  DateTime? eventDate;
  String? eventLocationLat;
  String? eventLocationLong;
  String? eventCountry;
  String? eventCity;
  List<String>? participateUsers;

  static EventModel empty() => EventModel();

  Map<String, dynamic> toFireStore() {
    return {
      "EventCreatorId": eventCreatorId ?? "",
      "EventId": eventId ?? "",
      "EventCategory": eventCategory ?? "",
      "EventTitle": eventTitle ?? "",
      "EventDescription": eventDescription ?? "",
      "EventDate": eventDate != null ? Timestamp.fromDate(eventDate!) : null,
      "EventLocationLat": eventLocationLat ?? "0",
      "EventLocationLong": eventLocationLong ?? "0",
      "EventCountry": eventCountry ?? "",
      "EventCity": eventCity ?? "",
      "ParticipateUsers": participateUsers ?? <String>[],
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
        eventDate: (data["EventDate"] as Timestamp?)?.toDate(),
        eventLocationLat: data["EventLocationLat"] as String?,
        eventLocationLong: data["EventLocationLong"] as String?,
        eventCountry: data["EventCountry"] as String?,
        eventCity: data["EventCity"] as String?,
        participateUsers: data["ParticipateUsers"] != null
            ? List<String>.from(data["ParticipateUsers"])
            : [],
      );
    } else {
      return empty();
    }
  }
}
