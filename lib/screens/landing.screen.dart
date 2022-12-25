import './login.screen.dart';
import './register.screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            'http://pastorjess.com/uploads/8/0/0/0/80007388/shutterstock-300283754_1_orig.jpg',
          ),
          const SizedBox(
            height: 100,
          ),
          Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const LoginPage();
                          },
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 18)),
                    child: const Text('Login'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const RegisterPage();
                          },
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 18)),
                    child: const Text(
                      'Register',
                      style: TextStyle(),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }


}
