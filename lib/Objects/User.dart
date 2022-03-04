class User{
  late int Id;
  late String Name;
  late String Surname;

  User({required this.Id, required this.Name,required this.Surname});

  String getName ()
  {
    return this.Name + " " + this.Surname;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['id'],
      Name: json['imie'],
      Surname: json['nazwisko'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': Id,
    'imie': Name,
    'nazwisko': Surname,
  };
}