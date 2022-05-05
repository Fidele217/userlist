import 'package:flutter/material.dart';
import 'package:tp_flutter_ifri_2022/models/dbhelper.dart';
import 'package:tp_flutter_ifri_2022/models/individu.dart';
import 'package:tp_flutter_ifri_2022/widgets/custom-text-form-field.dart';

import '../widgets/Custom-date-picker-form-field.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _citationController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  DateTime? _dateOfBirth;
  final _formKey = GlobalKey<FormState>();

  final dbHelper = DatabaseHelper.instance;
  Individu _individu = Individu(0, '', '', '', '', '', '', '');
  List<Individu> individus = [];

  List<Individu> individusByName = [];

  /*void _showMessage(String message){
    _formKey.currentState.(
        SnackBar(
          content: Text(message),
        )
    );*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //_dbHelper= DatabaseHelper.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User informations"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFormField(
                controller: _firstnameController,
                textLabel: "First name",
                icon: Icon(Icons.person),
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                controller: _lastnameController,
                textLabel: "Last name",
                icon: Icon(Icons.person),
              ),
              const SizedBox(height: 8.0),
              ////date
              CustomDatePickerFormField(
                controller: _dateOfBirthController,
                textLabel: "Date of birth",
                callback: () => pickDateOfBirth(context),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter a phone number',
                  label: Text('Phone'),
                    border: const OutlineInputBorder()
                ),
                validator: (value) {
                  if (isValidPhoneNumber(value) == false) {
                    return 'Please enter valid phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8.0),
              CustomTextFormField(
                controller: _adressController,
                textLabel: "Adress",
                icon: Icon(Icons.add_location),
              ),
              const SizedBox(height: 8.0),

              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    label:Text('Email'),
                  border: const OutlineInputBorder()),

                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter Correct Email Address";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                controller: _genderController,
                textLabel: "Gender",
                icon: Icon(Icons.person),
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                controller: _citationController,
                textLabel: "Citation",
                icon: Icon(Icons.format_quote),
              ),
              const SizedBox(height: 8.0),

              /////////////////////////////////////////////////////

              //////////////////////////////////////////////////////////////////
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onPrimary: Colors.white,
              onSurface: Colors.black),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),

      ),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      //String dob=DateFormat("/dd/mm/yyyy").format(newDate);
      _dateOfBirthController.text = newDate.toIso8601String();
    });
  }

  bool isValidPhoneNumber(String? string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form?.validate() == true) {
      form?.save();
      await dbHelper.insert(_individu);
      form?.reset();
    }
  }
}
