import 'package:flutter/material.dart';
import 'package:mis/screens/authentication/login_page.dart';
import 'package:mis/screens/verification_form/verification_form.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'welcome';

  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _verifymedicine() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MedVerification()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Image.asset(
                  'lib/images/bg_logo-wt.png',
                  height: 400,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () => _verifymedicine(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF223345),
                      padding: const EdgeInsets.only(
                          top: 17, bottom: 17, left: 40, right: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Verify Medicine',
                      style: TextStyle(
                        color: const Color(0xFFe2e2e2),
                        fontSize: MediaQuery.of(context).size.width > 500
                            ? 35
                            : MediaQuery.of(context).size.width < 500
                                ? 20
                                : 30,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () => _login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF223345),
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 40, right: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: const Color(0xFFe2e2e2),
                          fontSize: MediaQuery.of(context).size.width > 500
                              ? 35
                              : MediaQuery.of(context).size.width < 500
                                  ? 20
                                  : 30,
                          letterSpacing: 3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
