import 'dart:io';
import 'package:booking_app/utils/helpers.util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.provider.dart';
import 'login.screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _secureText = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pwController = TextEditingController();
  final _emailController = TextEditingController();
  final _pnController = TextEditingController();
  int validateEmail(String emailAddress) {
    String patttern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(patttern);
    if (emailAddress.isEmpty) {
      return 1;
    } else if (!regExp.hasMatch(emailAddress)) {
      return 2;
    } else {
      return 0;
    }
  }

  int validatePassword(String pswd) {
    if (pswd.isEmpty) {
      return 1;
    } else if (pswd.isNotEmpty && pswd.length < 4) {
      return 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottom),
        reverse: true,
        child: Column(children: [
          const Text(
            'Welcome Buddies',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Create account to book your event',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            // height: size.height * 0.55,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Text(
                      'Create your account ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'User Name ',
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        }),
                  ),
                  //flutter build apk --split-per-abi
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      /* autovalidate is disabled */
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {},
                      maxLines: 1,
                      validator: (value) {
                        int res = validateEmail(value!);
                        if (res == 1) {
                          return "Please  fill email address";
                        } else if (res == 2) {
                          return "Please enter valid email address";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Phone number',
                        ),
                        controller: _pnController,
                        // initialValue: '+251',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number is required";
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                          icon: _secureText
                              ? const Icon(Icons.security_outlined)
                              : const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                      controller: _pwController,
                      validator: (value) {
                        int res = validatePassword(value!);
                        if (res == 1) {
                          return "Please enter password";
                        } else if (res == 2) {
                          return "Please enter minimum 4 characters";
                        } else {
                          return null;
                        }
                      },
                      obscureText: _secureText,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Confirm Password ',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                          icon: _secureText
                              ? const Icon(Icons.security_outlined)
                              : const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        } else if (value != _pwController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      obscureText: _secureText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            fixedSize: const Size(375, 55),
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Sign Up'),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 1,
                    //thickness: 1,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: ListTile(
                      leading: Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      title: Text('Facebook'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already Have An Account?',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const LoginPage();
                    }));
                  },
                  child: const Text(
                    'Sign in Here',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ]),
      ),
    );
  }

  _register() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    FocusScopeNode focusScope = FocusScopeNode();
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _isLoading = true;
    setState(() {});

    try {
      await authProvider.registerUser(
        name: _nameController.text,
        password: _pwController.text,
        email: _emailController.text,
        phoneNumber: _pnController.text,
      );

      if (authProvider.isAuth) {
        if (mounted) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
        }
      }
    } on HttpException catch (e) {
      showErrorDialog(context, message: e.message);
    } on SocketException catch (_) {
      showErrorDialog(context, message: "Connection not found!");
    } catch (e) {
      showErrorDialog(context);
    }

    _isLoading = false;
    setState(() {});
  }
}
