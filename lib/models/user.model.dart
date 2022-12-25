class User {

  late String id;
  late String name;
  late String email;
  late String phoneNumber;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
   });


  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['username'];
    email = json['email'];
    phoneNumber = json['phonenumber'];
  }
}
