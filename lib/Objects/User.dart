class User{
  late int Id;
  late String Name;
  late String Surname;

  User({required this.Id, required this.Name,required this.Surname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['id'],
      Name: json['title'],
      Surname: json['title'],
    );
  }
}