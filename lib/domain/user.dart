class UserModel {
  String id;
  String photo;
  String name;
  String city;
  String email;
  String surname;
  String phoneNumber;
  String aboutYourself;
  UserModel({
    this.id,
    this.photo,
    this.name,
    this.surname,
    this.city,
    this.email,
    this.phoneNumber,
    this.aboutYourself,
  });

  Map<String, Object> toFirebase() {
    return {
      'id': id == null ? '' : id,
      'photo': photo == null ? '' : photo,
      'name': name == null ? '' : name,
      'surname': surname == null ? '' : surname,
      'city': city == null ? '' : city,
      'email': email == null ? '' : email,
      'phoneNumber': phoneNumber == null ? '' : phoneNumber,
      'aboutYourself': aboutYourself == null ? '' : aboutYourself,
    };
  }
}
