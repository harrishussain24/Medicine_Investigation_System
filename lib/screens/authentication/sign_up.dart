import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mis/screens/authentication/login_page.dart';
import 'package:http/http.dart' as http;
import '../models/userauthentication_model.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserSignUp();
}

class _UserSignUp extends State<UserSignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  UserModel? _userModel;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pharmacyname = TextEditingController();
  final TextEditingController _pharmacyregno = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  String? _validateusername(String? value) {
    if (value!.isEmpty) {
      return ("This field is Required");
    } else if (RegExp("^[0-9]").hasMatch(value)) {
      return ("Numbers not allowed");
    } else {
      return null;
    }
  }

  String? _validatemail(String? value) {
    if (value!.isEmpty) {
      return ("This field is Required");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a Valid Email");
    }
    return null;
  }

  String? _validatephoneno(String? value) {
    return value!.isEmpty ? 'This field is required' : null;
  }

  String? _validatecnic(String? value) {
    return value!.isEmpty ? 'This field is required' : null;
  }

  String? _validateaddress(String? value) {
    return value!.isEmpty ? 'This field is required' : null;
  }

  String? _validatepharmname(String? value) {
    return value!.isEmpty ? 'This field is required' : null;
  }

  String? _validatepharmregno(String? value) {
    return value!.isEmpty ? 'This field is required' : null;
  }

  String? _validatepassword(String? value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Please Enter Your Password");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Passsowrd(Min. 6 Characters)");
    }
    return null;
  }

  String? _validateconfirmpassword(String? value) {
    if (value!.isEmpty) return 'This field is required';
    if (value != _password.text) return 'Passwords are not identical';
    return null;
  }

  Future<UserModel?> _signup(
      String username,
      String email,
      String phone_no,
      String cnic,
      String address,
      String pharm_name,
      String pharm_reg,
      String password) async {
    String url = "https://mis.lasanian.com/api/users";

    try {
      if (_globalKey.currentState!.validate()) {
        var response = await http.post(Uri.parse(url), body: {
          "username": username,
          "email": email,
          "phone_no": phone_no,
          "CNIC": cnic,
          "address": address,
          "pharmacy_name": pharm_name,
          "pharmacy_reg_no": pharm_reg,
          "password": password,
        });
        var data = response.body;
        print(data);

        if (response.statusCode == 201) {
          String responseString = response.body;
          welcomeFromJson(responseString);
          navigate();
          Fluttertoast.showToast(msg: 'Account Created Successfully...😉');
          _username.clear();
          _email.clear();
          _phoneno.clear();
          _cnic.clear();
          _address.clear();
          _pharmacyname.clear();
          _pharmacyregno.clear();
          _password.clear();
          _confirmpassword.clear();
        } else {
          return null;
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void navigate() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/afterupdate', (route) => false);
  }

  void _backtologin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Color(0xFF223345),
            ),
            child: Column(
              children: [
                Form(
                  key: _globalKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage('lib/images/logo.png'),
                          radius: 70,
                          backgroundColor: Color(0xFFe2e2e2),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 500
                                ? 30
                                : MediaQuery.of(context).size.width < 500
                                    ? 23
                                    : 30,
                            color: const Color(0xFFe2e2e2),
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
                        Text(
                          'Register now to get started with your account',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 500
                                ? 20
                                : MediaQuery.of(context).size.width < 500
                                    ? 15
                                    : 20,
                            color: const Color(0xFFe2e2e2),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: _username,
                          validator: (value) => _validateusername(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Name',
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
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (value) => _validatemail(value),
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
                                Icons.mail,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneno,
                          validator: (value) => _validatephoneno(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Phone No',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _cnic,
                          validator: (value) => _validatecnic(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'CNIC',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.credit_card,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _address,
                          validator: (value) => _validateaddress(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Address',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.house_outlined,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _pharmacyname,
                          validator: (value) => _validatepharmname(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Pharmacy Name',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _pharmacyregno,
                          validator: (value) => _validatepharmregno(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Pharmacy Reg. No',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle_outlined,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _password,
                          validator: (value) => _validatepassword(value),
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
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _confirmpassword,
                          validator: (value) => _validateconfirmpassword(value),
                          style: const TextStyle(
                            color: Color(0xFFe2e2e2),
                          ),
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              labelStyle: const TextStyle(
                                color: Color(0xFFe2e2e2),
                              ),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Color(0xFFe2e2e2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFe2e2e2),
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFe2e2e2), width: 1.0))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () => _backtologin(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF223345),
                                  side: const BorderSide(
                                    width: 4.0,
                                    color: Color(0xFFe2e2e2),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 12, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 500
                                            ? 30
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    500
                                                ? 18
                                                : 30,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: ElevatedButton(
                                onPressed: () async {
                                  String username = _username.text;
                                  String email = _email.text;
                                  String phone_no = _phoneno.text;
                                  String cnic = _cnic.text;
                                  String address = _address.text;
                                  String pharm_name = _pharmacyname.text;
                                  String pharm_reg = _pharmacyregno.text;
                                  String password = _password.text;

                                  UserModel? data = await _signup(
                                      username,
                                      email,
                                      phone_no,
                                      cnic,
                                      address,
                                      pharm_name,
                                      pharm_reg,
                                      password);

                                  setState(() {
                                    _userModel = data;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF223345),
                                  side: const BorderSide(
                                    width: 4.0,
                                    color: Color(0xFFe2e2e2),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 12, bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 500
                                            ? 30
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    500
                                                ? 18
                                                : 30,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
