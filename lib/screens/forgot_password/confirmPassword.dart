import 'package:flutter/material.dart';
import 'package:mis/screens/forgot_password/customclipper.dart';
import 'package:http/http.dart' as http;
import 'package:mis/screens/models/userauthentication_model.dart';

class changePassword extends StatefulWidget {
  String? id;
  String? username;
  String? email;
  String? phoneNo;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  changePassword(this.id, this.username, this.email, this.phoneNo, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password,
      {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _changePassword(
      id, username, email, phoneNo, cnic, address, p_name, p_reg_no, password);
}

class _changePassword extends State<changePassword> {
  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  _changePassword(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  String? _validatepassword(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
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

  Future<UserModel?> toWelcome(
      String Id,
      String username,
      String email,
      String phone_no,
      String CNIC,
      String address,
      String pharmacy_name,
      String pharmacy_reg_no,
      String password) async {
    if (_globalKey.currentState!.validate()) {
      String url = "https://mis.lasanian.com/api/users";
      var response = await http.put(Uri.parse(url), body: {
        "username": username,
        "email": email,
        "phone_no": phone_no,
        "CNIC": CNIC,
        "address": address,
        "pharmacy_name": pharmacy_name,
        "pharmacy_reg_no": pharmacy_reg_no,
        "password": password,
      });
      var data = response.body;
      print(data);

      if (response.statusCode == 200) {
        String responseString = response.body;
        welcomeFromJson(responseString);
      } else {
        print(response.statusCode);
      }
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    return null;
  }

  bool _obscureText = true;
  bool _conobscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Toggles the password show status
  void _contoggle() {
    setState(() {
      _conobscureText = !_conobscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFe2e2e2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: MyCUstomClipperForDrawer(),
                  child: Container(
                    height: 415,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: const BoxDecoration(
                      color: Color(0xFF223345),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          child: const Image(
                            image: AssetImage('lib/images/f_password.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 500
                                ? 30
                                : MediaQuery.of(context).size.width < 500
                                    ? 23
                                    : 30,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            obscureText: _obscureText,
                            controller: _password,
                            validator: (value) => _validatepassword(value),
                            decoration: InputDecoration(
                              hintText: 'New Password',
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: _toggle,
                              ),
                              prefixIcon: const Icon(Icons.password_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            obscureText: _conobscureText,
                            controller: _confirmpassword,
                            validator: (value) =>
                                _validateconfirmpassword(value),
                            decoration: InputDecoration(
                              hintText: 'Confirm new Password',
                              prefixIcon: const Icon(Icons.password_outlined),
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onPressed: _contoggle,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: () async {
                      toWelcome(id!, username!, email!, phone_no!, cnic!,
                          address!, p_name!, p_reg_no!, _password.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF223345),
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 25, right: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 500
                            ? 30
                            : MediaQuery.of(context).size.width < 500
                                ? 25
                                : 30,
                        letterSpacing: 2,
                      ),
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
