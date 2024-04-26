import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String? password;
  String? email;
  String? genre;
  bool? _cguIsCheck = false;
  bool? checkBoxError;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  void _handleSubmit() {
    // Validate returns true if the form is valid, or false otherwise.

    if (_cguIsCheck == false) {
      setState(() {
        checkBoxError = true;
      });
    } else {
      setState(() {
        checkBoxError = false;
      });
    }

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (val) => email = val,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Enter email address'),
                EmailValidator(errorText: 'Please correct email filled'),
              ]).call,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              onChanged: (val) => password = val,
              validator: passwordValidator.call,
              decoration: const InputDecoration(
                  hintText: '********',
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.lightBlue,
                  ),
                  errorStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(9.0)))),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField(
                onChanged: (val) => genre = val,
                value: null,
                items: const [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text("Please select your genre"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Homme",
                    child: Text("Homme"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Femme",
                    child: Text("Femme"),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You need to select one item';
                  }
                  return null;
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: CheckboxListTile(
                title: const Text("Accept the cgu"),
                value: _cguIsCheck ?? false,
                onChanged: (newValue) {
                  setState(() {
                    _cguIsCheck = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ),
          ),
          if (checkBoxError == true)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Please accept CGU',
                style: TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
