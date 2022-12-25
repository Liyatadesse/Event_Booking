class Event {
  late String id;
  late String name;
  late String dateOfEvent;
  late int price;
  late String address;
  late String desc;
  late String imageUrl;
  

  Event({
    required this.id,
    required this.name,
    required this.dateOfEvent,
    required this.price,
    required this.desc,
    required this.address,
    required this.imageUrl,
  });
  Event.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    dateOfEvent = json['dateOfEvent'];
    price = json['price'];
    address = json['address'];
    desc = json['desc'];
    imageUrl = json['imageUrl'];
    //   json['image'];
  }
}
