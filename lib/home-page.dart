import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite/custom-text-form-field.dart';
import 'package:flutter_with_sqflite/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _citationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _firstNameController.text = existingJournal['firstName'];
      _lastNameController.text = existingJournal['lastName'];
      _phoneController.text = existingJournal['phone'];
      _mailController.text = existingJournal['mail'];
      _addressController.text = existingJournal['address'];
      _genderController.text = existingJournal['gender'];
      _photoController.text = existingJournal['photo'];
      _citationController.text = existingJournal['citation'];
    }

    showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (_) =>
            Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 2,
                  // this will prevent the soft keyboard from covering the text fields
                  bottom: MediaQuery
                      .of(context)
                      .viewPadding
                      .bottom + 5,
                ),
                child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextFormField(
                          controller: _firstNameController,
                          textLabel: "First name",
                          icon: Icon(Icons.person),
                        ),

                        const SizedBox(height: 8.0),
                        CustomTextFormField(
                          controller: _lastNameController,
                          textLabel: "Last name",
                          icon: Icon(Icons.person),
                        ),
                        const SizedBox(height: 8.0),
                        ////date
                        /*CustomDatePickerFormField(
                      controller: _dateOfBirthController,
                      textLabel: "Date of birth",
                      callback: () => pickDateOfBirth(context),
                    ),*/
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                              icon: const Icon(Icons.phone),
                              hintText: 'Enter a phone number',
                              label: Text('Phone'),
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (CustomTextFormField.isValidPhoneNumber(value) ==
                                false) {
                              return 'Please enter valid phone number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 8.0),
                        CustomTextFormField(
                          controller: _addressController,
                          textLabel: "Adress",
                          icon: Icon(Icons.add_location),
                        ),
                        const SizedBox(height: 8.0),

                        TextFormField(
                          controller: _mailController,
                          decoration: const InputDecoration(
                              icon: const Icon(Icons.mail),
                              hintText: 'Enter your email',
                              label: Text('Email'),
                              border: const OutlineInputBorder()),
                          validator: (value) =>
                              CustomTextFormField.validateEmail(value),
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextFormField(
                          controller: _genderController,
                          textLabel: "Gender",
                          icon: Icon(Icons.person),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                            child: TextFormField(
                              controller: _citationController,
                              decoration: const InputDecoration(
                                  icon: const Icon(Icons.format_quote),
                                  hintText: 'Enter your favorite quote',
                                  label: Text('Citation'),
                                  border: const OutlineInputBorder()),
                            )),

                        ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // Save new journal
                              if (id == null) {
                                await _addItem();
                              }

                              if (id != null) {
                                await _updateItem(id);
                              }

                              // Clear the text fields
                              _firstNameController.text = '';
                              _lastNameController.text = '';
                              _dobController.text = '';
                              _phoneController.text = '';
                              _mailController.text = '';
                              _addressController.text = '';
                              _genderController.text = '';
                              _photoController.text = '';
                              _citationController.text = '';

                              // Close the bottom sheet
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(id == null ? 'Create New' : 'Update'),
                        )
                      ],
                    ),
                  ),
                )));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _firstNameController.text,
        _lastNameController.text,
        _phoneController.text,
        _mailController.text,
        _addressController.text,
        _genderController.text,
        _photoController.text,
        _citationController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id,
        _firstNameController.text,
        _lastNameController.text,
        _phoneController.text,
        _mailController.text,
        _addressController.text,
        _genderController.text,
        _photoController.text,
        _citationController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a user!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("TP1:User's data app"),
      ),

        body: _isLoading
          ? Container(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        shrinkWrap: true,
        itemCount: _journals.length,
        itemBuilder: (context, index) =>
            Card(
              color: Colors.orange[200],
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      //color: Colors.orange,
                      // width: 350,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.pink,
                        //backgroundImage: Image.asset("bgimg.png"),
                        //backgroundImage:,
                        radius: 45,
                      ),
                    ),
                  ),
                  Container(
                      width: 250,
                      padding: EdgeInsets.all(8),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("First name: ".toUpperCase() +
                                "${_journals[index]['firstName']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Last name: ".toUpperCase() +
                                "${_journals[index]['lastName']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Date of Birth: ".toUpperCase() +
                                "${_journals[index]['dob']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Phone: ".toUpperCase() +
                                "${_journals[index]['phone']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Email: ".toUpperCase() +
                                "${_journals[index]['mail']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Address: ".toUpperCase() +
                                "${_journals[index]['address']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Gender: ".toUpperCase() +
                                "${_journals[index]['gender']}"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Citation: ".toUpperCase() +
                                "${_journals[index]['citation']}"),
                          ])),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    //padding: EdgeInsets.all(0.8),
                    //width: 10,
                    child: Column(children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showForm(_journals[index]['id']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteItem(_journals[index]['id']),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}