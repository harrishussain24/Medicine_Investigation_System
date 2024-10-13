import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mis/screens/forgot_password/customclipper.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_otp/email_otp.dart';

import 'confirmPassword.dart';

class AddEmail extends StatefulWidget {
  const AddEmail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEmail();
}

class _AddEmail extends State<AddEmail> {
  bool showWidget = false;

  String? Id = '';
  String? Username = '';
  String? Email = '';
  String? PhoneNo = '';
  String? Cnic = '';
  String? Address = '';
  String? P_name = '';
  String? P_reg_no = '';
  String? Password = '';
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _enteremail = TextEditingController();
  final TextEditingController _enterotp = TextEditingController();
  EmailOTP myauth = EmailOTP();

  String? _validate_otp(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    } else if (RegExp("^0-9").hasMatch(value)) {
      return 'Enter the otp sended';
    }
    return null;
  }

  void _sendotp() async {
    if (_globalKey.currentState!.validate()) {
      myauth.setConfig(
          appEmail: "hh825477@gmail.com",
          appName: "MIS OTP",
          userEmail: _enteremail.text,
          otpLength: 6,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Oops, OTP send failed"),
        ));
      }
    }
  }

  Future _sendingotp(String email) async {
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

        if (u['Email'].toString() == email) {
          print(response.statusCode);
          print(u['Email']);
          String? id = u['U_ID'].toString();
          String? username = u['UserName'];
          String? email = u['Email'];
          String? phoneNo = u['Phone_No'];
          String? cnic = u['CNIC'];
          String? address = u['Address'];
          String? pName = u['Pharmacy_Name'];
          String? pRegNo = u['Pharmacy_Reg_No'];
          String? password = u['Password'];
          setState(() {
            showWidget = !showWidget;
            Id = id.toString();
            Username = username;
            Email = email;
            PhoneNo = phoneNo;
            Cnic = cnic;
            Address = address;
            P_name = pName;
            P_reg_no = pRegNo;
            Password = password;
          });
          myauth.setConfig(
              appEmail: "hh825477@gmail.com",
              appName: "MIS OTP-Verification",
              userEmail: _enteremail.text,
              otpLength: 6,
              otpType: OTPType.digitsOnly);
          if (await myauth.sendOTP() == true) {
            Fluttertoast.showToast(msg: 'OTP has been sent to your ${email}');
          } else {
            Fluttertoast.showToast(msg: 'Oops! OTP sending failed');
          }
        } else {
          Fluttertoast.showToast(msg: 'Email not Found');
        }
        return users;
      }
    }
  }

  void _verifyingOTP() async {
    if (await myauth.verifyOTP(otp: _enterotp.text) == true) {
      Fluttertoast.showToast(msg: 'Otp has been verified');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => changePassword(Id, Username, Email, PhoneNo,
                  Cnic, Address, P_name, P_reg_no, Password)));
    } else {
      Fluttertoast.showToast(msg: 'Invalid Otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF223345),
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MyCUstomClipperForDrawer(),
                child: Container(
                  height: 315,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                    color: Color(0xFF223345),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        height: 150,
                        child: const Image(
                          image: AssetImage('lib/images/f_password.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forgot Password',
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
                height: 30,
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _enteremail,
                            validator: (value) => _validate_otp(value),
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              prefixIcon: const Icon(Icons.email_sharp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    showWidget
                        ? Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  controller: _enterotp,
                                  decoration: InputDecoration(
                                    hintText: 'Enter OTP',
                                    prefixIcon:
                                        const Icon(Icons.password_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                  onPressed: () => {_verifyingOTP()},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF223345),
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 20,
                                        right: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    500
                                                ? 25
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        500
                                                    ? 20
                                                    : 25,
                                        letterSpacing: 2),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () => {_sendingotp(_enteremail.text)},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF223345),
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 20, right: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 500
                                            ? 25
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    500
                                                ? 20
                                                : 25,
                                    letterSpacing: 2),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
