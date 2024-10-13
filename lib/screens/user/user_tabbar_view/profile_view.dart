import 'package:flutter/material.dart';
import 'package:mis/screens/user/userprofile.dart';

class UserProfile extends StatefulWidget {
  String id;
  String username;
  String email;
  String phone_no;
  String cnic;
  String address;
  String p_name;
  String p_reg_no;
  String password;
  UserProfile(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password,
      {Key? key})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfile(
      id, username, email, phone_no, cnic, address, p_name, p_reg_no, password);
}

class _UserProfile extends State<UserProfile> {
  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  _UserProfile(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  late final TextEditingController _username =
      TextEditingController(text: username);
  late final TextEditingController _email = TextEditingController(text: email);
  late final TextEditingController _phone_no =
      TextEditingController(text: phone_no);
  late final TextEditingController _cnic = TextEditingController(text: cnic);
  late final TextEditingController _address =
      TextEditingController(text: address);
  late final TextEditingController _p_name =
      TextEditingController(text: p_name);
  late final TextEditingController _p_reg_no =
      TextEditingController(text: p_reg_no);

  void _userprofile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Userprofile(
                id.toString(),
                _username.text,
                _email.text,
                _phone_no.text,
                _cnic.text,
                _address.text,
                _p_name.text,
                _p_reg_no.text,
                password.toString(),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'lib/images/bg_logo.png',
                ),
                opacity: 0.2,
                fit: BoxFit.fitWidth)),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 35),
          child: Column(
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  wordSpacing: 2,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _username),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _email),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _phone_no),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _cnic),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _address),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _p_name),
              const SizedBox(
                height: 20,
              ),
              formInputField(
                  context, MediaQuery.of(context).size.width * 0.89, _p_reg_no),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: () => _userprofile(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF223345),
                        padding: const EdgeInsets.only(
                            left: 28, right: 28, top: 13, bottom: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          letterSpacing: 3,
                          fontSize: MediaQuery.of(context).size.width > 500
                              ? 25
                              : MediaQuery.of(context).size.width < 500
                                  ? 20
                                  : 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formInputField(BuildContext context, width, controller) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: const InputDecoration(
          hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF223345)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
