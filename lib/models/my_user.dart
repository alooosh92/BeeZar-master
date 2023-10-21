

class NewUser {
  String name;
  String email;
  String password;
  String address;
  String phone;


  NewUser({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phone,

  });
}

class User {
  late String email;
  late String password;

  User({
    required this.email,
    required this.password,
  });
}

