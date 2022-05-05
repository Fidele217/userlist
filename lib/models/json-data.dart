import 'dart:convert';

class Data{
  String responseData ='''[
    {
        "firstname":"Spéro",
        "lastname":"KOFFI",
        "birthday":"16-07-1998",
        "adress":"Ctn_Rue3",
        "phone":"09954347",
        "mail":"sperokoffi@gmail.com",
        "gender":"Masculin",
        "picture":"",
        "citation":"Née pour briller"
    },
    {
        "firstname":"Anne",
        "lastname":"MIGAN",
        "birthday":"13-06-2000",
        "adress":"Ptn_50",
        "phone":"89345672",
        "mail":"annemigan@gmail.com",
        "gender":"Feminin",
        "picture":"",
        "citation":"Je viens de très loin ou même l'eau est rare mais je suis l'unique espoir de ma famille"
    },

  {
        "firstname":"Cathérine",
        "lastname":"GANGAN",
        "birthday":"03-06-1899",
        "adress":"PIU_50HN",
        "phone":"89327864",
        "mail":"catherinegangan@gmail.com",
        "gender":"Feminin",
        "picture":"",
        "citation":"Mon étoile brillera toujours"
    },

  {
        "firstname":"Norbert",
        "lastname":"GANTIN",
        "birthday":"09-01-2008",
        "adress":"Grptn_50",
        "phone":"83478590",
        "mail":"gantinnorbert@gmail.com",
        "gender":"Masculin",
        "picture":"",
        "citation":"Fait du bien à tes proches et n'attend rien en retour"
    },

  {
        "firstname":"Sonia",
        "lastname":"PADOUE",
        "birthday":"01-06-2010",
        "adress":"Grandpopo_90A",
        "phone":"97182354",
        "mail":"soniapadoue@gmail.com",
        "gender":"Feminin",
        "picture":"",
        "citation":"Mon histoire va inspirer le monde entier"
    },
    
  {
        "firstname":"Paul",
        "lastname":"LALY",
        "birthday":"28-09-2008",
        "adress":"Ptn_50",
        "phone":"66723984",
        "mail":"paullaly@gmail.com",
        "gender":"Masculin",
        "picture":"",
        "citation":"L'humilité conduit toujours au succès"
    }

]''';

  late final products=json.decode(responseData);
}