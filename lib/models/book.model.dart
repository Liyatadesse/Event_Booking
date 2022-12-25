import 'package:booking_app/screens/user_booked_detail.dart';

class Book {
  late String id;
  late String event;
  late String userId;

  Book({
    required this.id,
    required this.userId,
    required this.event,
  });
  Book.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    event = json['event']['name'];
    userId = json['userId'];

    //   json['image'];
  }
}
