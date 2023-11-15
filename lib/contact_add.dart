import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'contact_model.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formKey = GlobalKey<FormState>();

  var contactData = {
    'name': '',
    'email': '',
    'phone': '',
    'gender': '',
  };

  String? gender;

  late Function(Contact) addContact;

  void _submit() {
    formKey.currentState!.save();
    if (kDebugMode) {
      print(contactData);
    }
    final newContact = Contact(
      name: contactData['name']!,
      email: contactData['email']!,
      phone: contactData['phone']!,
      gender: contactData['gender']!,
    );
    addContact(newContact);
  }

  @override
  Widget build(BuildContext context) {
    addContact =
        ModalRoute.of(context)!.settings.arguments as Function(Contact);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          // weight: 17,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your Name',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB3B3B3),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-z A-Z]'),
                              ),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              if (newValue != null) {
                                contactData['name'] = newValue;
                              }
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15),
              Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                          // weight: 17,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB3B3B3),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9@._-]')),
                              LengthLimitingTextInputFormatter(50),
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }

                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              if (newValue != null) {
                                contactData['email'] = newValue;
                              }
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15),
              Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          // weight: 17,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your Phone Number',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB3B3B3),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(13),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              if (newValue != null) {
                                contactData['phone'] = newValue;
                              }
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                  )),
              Row(
                children: [
                  const Text('Gender:'),
                  const SizedBox(
                    width: 5,
                  ),
                  Radio(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          gender = value;
                        });
                      }
                    },
                  ),
                  const Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          gender = value;
                        });
                      }
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    contactData['gender'] = gender!;
                    _submit();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 600),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        content: Text(
                          'Contact added successfully',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
