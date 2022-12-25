import 'package:booking_app/screens/reset_password.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'reset_password';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // static final auth = FirebaseAuth.instance;
  // static late AuthStatus _status;
  // @override
  // void initState() {
  //   Firebase.initializeApp();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   super.dispose();
  // }

  // Future<AuthStatus> resetPassword({required String email}) async {
  //   await auth
  //       .sendPasswordResetEmail(email: email)
  //       .then((value) => _status = AuthStatus.successful)
  //       .catchError(
  //           (e) => _status = AuthExceptionHandler.handleAuthException(e));

  //   return _status;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 70),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty email';
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
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
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
                      borderSide: BorderSide(color: Colors.orange, width: 2.0),
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
                    hintText: 'email address',
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
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const ResetPasswordScreen();
                        }));
                      },
                      minWidth: double.infinity,
                      child: const Text(
                        'RECOVER PASSWORD',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
