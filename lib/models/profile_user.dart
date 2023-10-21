import 'dart:io';

class ProfileUser {
  String? id;
  String? name;
  String? email;
  String? password;
  String? address;
  String? phone;
  String? token;
  File? image;

  ProfileUser(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.address,
        this.phone,
        this.token,
        this.image});
}
