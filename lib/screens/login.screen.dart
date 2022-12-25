import 'dart:io';
import 'package:booking_app/providers/auth.provider.dart';
import 'package:booking_app/screens/forgot.password.screen.dart';
import 'package:booking_app/utils/helpers.util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'register.screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _secureText = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Welcome Buddies',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Login to book your event',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: size.height * 0.55,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.025),
                      const Text(
                        'Login to your account ',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.025),
                      TextFormField(
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
                        },
                      ),
                      SizedBox(height: size.height * 0.025),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password ',
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
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        obscureText: _secureText,
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return const ForgotPassword();
                              }));
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025),
                      Center(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              fixedSize: const Size(375, 55),
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Log In'),
                        ),
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 1,
                        //thickness: 1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: ListTile(
                          onTap: _isLoading ? null : _fb,
                          leading: const Icon(
                            Icons.facebook,
                            color: Colors.blue,
                          ),
                          title: const Text('Facebook'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t Have An Account? ',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const RegisterPage();
                      }));
                    },
                    child: const Text(
                      'Sign Up Here',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _login() async {
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
      await authProvider.login(
          name: _nameController.text, password: _pwController.text);
      if (authProvider.isAuth) {
        if (mounted) {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
        }
      }
    } on HttpException catch (e) {
      showErrorDialog(context, message: e.message);
    } on SocketException catch (_) {
      showErrorDialog(context, message: "Connection not found");
    } catch (e) {
      showErrorDialog(context);
    }

    _isLoading = false;
    setState(() {});
  }
  _fb() async {
  String fbProtocolUrl;
  if (Platform.isIOS) {
    fbProtocolUrl = 'fb://profile';
  } else {
    fbProtocolUrl = 'fb://page';
  }

  String fallbackUrl = 'https://www.facebook.com';

  try {
    bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false);
  }
}

}

