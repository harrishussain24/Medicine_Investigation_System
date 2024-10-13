import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mis/screens/models/userauthentication_model.dart';

class Userprofile extends StatefulWidget {
  String id;
  String username;
  String email;
  String phone_no;
  String cnic;
  String address;
  String p_name;
  String p_reg_no;
  String password;
  Userprofile(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  @override
  State<StatefulWidget> createState() => _Userprofile(
      id, username, email, phone_no, cnic, address, p_name, p_reg_no, password);
}

class _Userprofile extends State<Userprofile> {
  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  _Userprofile(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  UserModel? _userModel;

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
  TextEditingController _passwordcomparison = TextEditingController();

  Future<UserModel?> updatedata(
      String Id,
      String username,
      String email,
      String phone_no,
      String CNIC,
      String address,
      String pharmacy_name,
      String pharmacy_reg_no) async {
    String url = "https://mis.lasanian.com/api/users/$Id";
    var response = await http.put(Uri.parse(url), body: {
      "username": username,
      "email": email,
      "phone_no": phone_no,
      "CNIC": CNIC,
      "address": address,
      "pharmacy_name": pharmacy_name,
      "pharmacy_reg_no": pharmacy_reg_no,
      "password": password.toString(),
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      welcomeFromJson(responseString);
    } else {
      print(response.statusCode);
    }
    return null;
  }

  void _updateuserprofile() async {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Column(
                children: const [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Updating Profile',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 1,
                    color: Color(0xFF223345),
                  ),
                ],
              ),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 120,
                    child: Column(
                      children: [
                        const Text(
                          'Please enter your Password to Update your Info...!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.7,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextFormField(
                            controller: _passwordcomparison,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF223345)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                            onPressed: () async {
                              String Id = id.toString();
                              String username = _username.text;
                              String email = _email.text;
                              String phone_no = _phone_no.text;
                              String cnic = _cnic.text;
                              String address = _address.text;
                              String p_name = _p_name.text;
                              String p_reg_no = _p_reg_no.text;
                              if (password == _passwordcomparison.text) {
                                updatedata(Id, username, email, phone_no, cnic,
                                    address, p_name, p_reg_no);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/afterupdate', (route) => false);
                              } else {
                                Fluttertoast.showToast(msg: 'Invalid Password');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF223345),
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 13, bottom: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 19, letterSpacing: 2),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF223345),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'lib/images/bg_logo.png',
                    ),
                    opacity: 0.2,
                    fit: BoxFit.fitWidth)),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Column(
              children: [
                inputfields(context, _username),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _email),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _phone_no),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _cnic),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _address),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _p_name),
                const SizedBox(
                  height: 20,
                ),
                inputfields(context, _p_reg_no),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      margin: const EdgeInsets.only(left: 10, right: 30),
                      child: ElevatedButton(
                        onPressed: () => {_updateuserprofile()},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF223345),
                          padding: const EdgeInsets.only(
                              left: 28, right: 28, top: 13, bottom: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 500
                                ? 25
                                : MediaQuery.of(context).size.width < 500
                                    ? 20
                                    : 25,
                            letterSpacing: 2,
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
      ),
    );
  }

  Container inputfields(BuildContext context, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xFF223345)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
