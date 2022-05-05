
import 'package:tp_flutter_ifri_2022/models/dbhelper.dart';

class Individu{

  late int id;
  late String firstname;
  late String lastname;
  late String dateOfBirth;
  late String phone;
  late String mail;
  late  String gender;
  late String citation;

static const tblIndividu='indidus';
static const colId='id';
static const colFirstname='firstname';
static const colLastname='lastname';
static const colDateOfBirth='dateOfBirth';
static const colPhone='phone';
static const colMail='mail';
static const colGender='gender';
static const colCitation='citation';


  Individu(this.id, this.firstname, this.lastname, this.dateOfBirth,
     this.phone, this.mail, this.gender, this.citation
  );


  Individu.fromMap(Map<String,dynamic> map){
    id=map[colId];
    lastname=map[colLastname];
    firstname=map[colFirstname];
    dateOfBirth=map[colDateOfBirth];
    phone=map[colPhone];
    mail=map[colMail];
    gender=map[colGender];
    citation=map[colCitation];
  }





 Map<String,dynamic> toMap(){
    return {

    DatabaseHelper.colId:id,
    DatabaseHelper.colFirstname: firstname,
    DatabaseHelper.colLastname:lastname,
      DatabaseHelper.colDateOfBirth:dateOfBirth,
      DatabaseHelper.colMail:mail,
      DatabaseHelper.colGender:gender,
      DatabaseHelper.colPhone:phone,
      DatabaseHelper.colCitation:citation,

 };

  }

}