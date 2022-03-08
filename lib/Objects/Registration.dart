import 'AttachedPeople.dart';
import 'User.dart';

class Registration{
  late int id;
  late  String description;
  late User owner;
  late int ownerId;
  late int applicant;
  late String program;
  late String title;
  late List<AttachedPeople> attachedUsers;



 Registration({ required this.id, required this.description, required this.owner, required this.ownerId, required this.applicant,
     required this.program, required this.title});


 Registration.rere(this.description, this.ownerId, this.applicant,
     this.program, this.title, this.attachedUsers) {}

  Registration.get({required this.id, required this.title, required this.owner}){
   if(owner != null)
     owner = this.owner;
  }




 Map<String, dynamic> toJson() => {
  'Tytul': title,
  'OsobaOdpowiedzialnaId': ownerId,
  'OsobyPodpiete': attachedUsers,
  'Opis' : description
 };

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration.get(
      id: json['id'],
      title: json['tytul'],
      owner: new User.fromJson(json['osobaOdpowiedzalna'])

    );

  }

}