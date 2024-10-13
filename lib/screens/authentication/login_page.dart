import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mis/screens/authentication/admin_login.dart';
import 'package:mis/screens/authentication/custom_clipper.dart';
import 'package:mis/screens/authentication/sign_up.dart';
import 'package:mis/screens/user/usersdashboard.dart';
import 'package:http/http.dart' as http;

import '../forgot_password/add_email.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final bool _allow = true;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  String? errorMessage;

  String? _validateusername(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z]+.[a-z]").hasMatch(value)) {
      return ("Email badly formatted");
    }
    return null;
  }

  String? _validatepassword(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Please Enter Your Password");
    }
    return null;
  }

  void _adminloginpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminLoginPage()),
    );
  }

  Future _afterlogin(String email, String password) async {
    if (_globalKey.currentState!.validate()) {
      String url = "https://mis.lasanian.com/api/users";
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      List<Users> users = [];

      for (var u in jsonData) {
        Users user = Users(
            u['U_ID'].toString(),
            u['UserName'].toString(),
            u['Email'].toString(),
            u['Phone_No'].toString(),
            u['CNIC'].toString(),
            u['Address'].toString(),
            u['Pharmacy_Name'].toString(),
            u['Pharmacy_Reg_No'].toString(),
            u['Password'].toString());
        users.add(user);

        if (u['Email'].toString() == email &&
            u['Password'].toString() == password) {
          print(response.statusCode);
          String? id = u['U_ID'].toString();
          String? username = u['UserName'];
          String? email = u['Email'];
          String? phoneNo = u['Phone_No'];
          String? cnic = u['CNIC'];
          String? address = u['Address'];
          String? p_name = u['Pharmacy_Name'];
          String? p_reg_no = u['Pharmacy_Reg_No'];
          String? password = u['Password'];
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDashboard(id, username, email,
                      phoneNo, cnic, address, p_name, p_reg_no, password)));
          _email.clear();
          _userpassword.clear();
          return Fluttertoast.showToast(msg: 'Login Successfull...😊');
        }
      }
    }
  }

  void _forgotpassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEmail()),
    );
    _email.clear();
    _userpassword.clear();
  }

  void _usersignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserSignUp()),
    );
  }

  bool _obscureText = true;

  String? _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => _allow,
        child: Scaffold(
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
                        height: 680,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: const BoxDecoration(
                          color: Color(0xFF223345),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/images/logo.png'),
                              radius: 70,
                              backgroundColor: Color(0xFFe2e2e2),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color(0xFFe2e2e2),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 70,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: Color(0xFFe2e2e2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Welcome back. Please enter your details',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFe2e2e2),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 40,
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
                                      onSaved: (value) {
                                        _email.text = value!;
                                      },
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
                                      onSaved: (value) {
                                        _userpassword.text = value!;
                                      },
                                      keyboardType: TextInputType.text,
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
                                              foregroundColor: Colors.white60,
                                            ),
                                            onPressed: _toggle,
                                            child: Text(_obscureText
                                                ? "Show"
                                                : "Hide")),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () => _forgotpassword(),
                                          child: const Text(
                                            'Forgot Password...?',
                                            style: TextStyle(
                                                color: Color(0xFFe2e2e2),
                                                letterSpacing: 1,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: ElevatedButton(
                                            onPressed: () => _usersignup(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF223345),
                                              side: const BorderSide(
                                                width: 4.0,
                                                color: Color(0xFFe2e2e2),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 13,
                                                  bottom: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              'SIGN UP',
                                              style: TextStyle(
                                                color: const Color(0xFFe2e2e2),
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
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: ElevatedButton(
                                            onPressed: () => _afterlogin(
                                                _email.text,
                                                _userpassword.text),
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
                                                color: const Color(0xFFe2e2e2),
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
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () => _adminloginpage(),
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
                      'LOGIN AS ADMIN',
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
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
          ),
        ));
  }
}

class Users {
  late String id;
  late String username;
  late String email;
  late String phone_no;
  late String cnic;
  late String address;
  late String pharmacy_name;
  late String pharmacy_reg_no;
  late String password;

  Users(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.pharmacy_name, this.pharmacy_reg_no, this.password);
}
