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



 Registration(this.description,  this.owner,this.ownerId, this.applicant,
      this.program, this.title);


 Registration.rere(this.description, this.ownerId, this.applicant,
     this.program, this.title, this.attachedUsers) {}

 Map<String, dynamic> toJson() => {
  'Tytul': title,
  'OsobaOdpowiedzialnaId': ownerId,
  'OsobyPodpiete': attachedUsers,
  'Opis' : description
 };

}