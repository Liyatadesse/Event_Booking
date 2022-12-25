import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _pdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      obscureText: false,
                      controller: _pdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty Password';
                        }
                        return null;
                      },
                      autofocus: false,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              30.0,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              30.0,
                            ),
                          ),
                        ),

                        isDense: true,
                        // fillColor: kPrimaryColor,
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: false,
                      controller: _pdController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty password';
                        } else if (value != _pdController.text) {
                          return 'password doesn\'t match';
                        }

                        return null;
                      },
                      autofocus: false,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              30.0,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              30.0,
                            ),
                          ),
                        ),

                        isDense: true,
                        // fillColor: kPrimaryColor,
                        filled: true,
                        errorStyle: TextStyle(fontSize: 15),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: double.infinity,
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
