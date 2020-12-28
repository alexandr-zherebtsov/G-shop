class UserModel {
  String id;
  String name;
  String city;
  String surname;
  String phoneNumber;
  UserModel({this.id, this.name, this.surname, this.city, this.phoneNumber});

  Map<String, Object> toFirebase() {
    return {
      'id' : id == null ? '' : id,
      'name' : name == null ? '' : name,
      'surname' : surname == null ? '' : surname,
      'city' : city == null ? 'No City' : city,
      'phoneNumber' : phoneNumber == null ? "No Number" : phoneNumber,
    };
  }
}