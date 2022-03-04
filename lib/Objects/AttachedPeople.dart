import 'dart:core';

class AttachedPeople {
  late int Id;
 late int RegistrationId;
 late int UserId;

 AttachedPeople({required this.Id, required this.RegistrationId, required this.UserId});


  factory AttachedPeople.fromJson(Map<String, dynamic> json) {
    return AttachedPeople(
      Id: json['id'],
      RegistrationId: json['Zgloszenie_Id'],
      UserId: json['Uzytkownik_Id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': Id,
    'ZgloszenieId': RegistrationId,
    'UzytkownikId': UserId,
  };
}