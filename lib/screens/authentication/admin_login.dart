import 'package:flutter/material.dart';
import 'package:mis/screens/admin/admindashboard.dart';
import 'package:mis/screens/authentication/custom_clipper.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminLoginPage();
}

class _AdminLoginPage extends State<AdminLoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  String? _validateusername(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+.[a-z]").hasMatch(value)) {
      return ("Please Enter a Valid Email");
    }
    if (value.toString() != "admin@gmail.com") {
      return ("Wrong Username");
    }
    return null;
  }

  String? _validatepassword(String? value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Please Enter Your Password");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Passsowrd(Min. 6 Characters)");
    }
    if (value.toString() != "1234567890") {
      return ("Wrong Password");
    }
  }

  void _userloginpage() {
    Navigator.pop(context);
  }

  bool _obscureText = true;

  String? _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _dashboard() {
    if (_globalKey.currentState!.validate()) {
      _email.clear();
      _userpassword.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: Column(
                  children: [
                    Container(
                      height: 610,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: const BoxDecoration(
                        color: Color(0xFF223345),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const CircleAvatar(
                            backgroundImage: AssetImage('lib/images/logo.png'),
                            backgroundColor: Color(0xFFe2e2e2),
                            radius: 60,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 5,
                              color: Color(0xFFe2e2e2),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _globalKey,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _email,
                                    validator: (value) =>
                                        _validateusername(value),
                                    style: const TextStyle(
                                      color: Color(0xFFe2e2e2),
                                    ),
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintStyle: const TextStyle(
                                          color: Color(0xFFe2e2e2),
                                        ),
                                        labelStyle: const TextStyle(
                                          color: Color(0xFFe2e2e2),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Color(0xFFe2e2e2),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFe2e2e2),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFe2e2e2),
                                                width: 1.0))),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: _userpassword,
                                    validator: (value) =>
                                        _validatepassword(value),
                                    keyboardType: TextInputType.text,
                                    onSaved: (val) => _password = val,
                                    obscureText: _obscureText,
                                    style: const TextStyle(
                                      color: Color(0xFFe2e2e2),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFFe2e2e2),
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Color(0xFFe2e2e2),
                                      ),
                                      suffixIcon: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFFe2e2e2),
                                          ),
                                          onPressed: _toggle,
                                          child: Text(
                                              _obscureText ? "Show" : "Hide")),
                                      prefixIcon: const Icon(
                                        Icons.password,
                                        color: Color(0xFFe2e2e2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFe2e2e2),
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFe2e2e2),
                                            width: 1.0),
                                      ),
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     TextButton(
                                  //       onPressed: () {},
                                  //       child: Text(
                                  //         'Forgot Password...?',
                                  //         style: TextStyle(
                                  //             color: Color(0xFFe2e2e2),
                                  //             letterSpacing: 1,
                                  //             decoration:
                                  //                 TextDecoration.underline),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ElevatedButton(
                                          onPressed: () => _dashboard(),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF223345),
                                            side: const BorderSide(
                                              width: 4.0,
                                              color: Color(0xFFe2e2e2),
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 25,
                                                right: 25,
                                                top: 12,
                                                bottom: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            'LOGIN',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      500
                                                  ? 25
                                                  : MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          500
                                                      ? 18
                                                      : 25,
                                              letterSpacing: 4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () => _userloginpage(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF223345),
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0xFFe2e2e2),
                    ),
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'LOGIN AS USER',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 500
                          ? 25
                          : MediaQuery.of(context).size.width < 500
                              ? 17
                              : 25,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
