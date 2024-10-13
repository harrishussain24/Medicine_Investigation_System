import 'package:flutter/material.dart';
import 'package:mis/screens/splash/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashscreen';

  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/images/bgspalsh_portrait.png')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
