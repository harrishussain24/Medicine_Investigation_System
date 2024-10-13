import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/notifymodel.dart';

class NotifyManufacturer extends StatefulWidget {
  const NotifyManufacturer({Key? key}) : super(key: key);

  @override
  State<NotifyManufacturer> createState() => _NotifyManufacturerState();
}

class _NotifyManufacturerState extends State<NotifyManufacturer> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  var date, time;
  NotifyModel? _notifyModel;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _message = TextEditingController();

  String? _validatename(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Name");
    }
    if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
      return ("Please Enter a Valid Name");
    }
    return null;
  }

  String? _validateemail(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+.[a-z]").hasMatch(value)) {
      return ("Please Enter a Valid Email");
    }
    return null;
  }

  String? _validatemessage(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Message");
    }
    return null;
  }

  Future<NotifyModel?> _notifyadmin(String name, String email, String message,
      String date, String time) async {
    String url = "https://mis.lasanian.com/api/notify";
    var response = await http.post(Uri.parse(url), body: {
      "name": name,
      "email": email,
      "message": message,
      "date": date,
      "time": time
    });
    var data = response.body;
    Fluttertoast.showToast(msg: 'Your message has been sent to an Admin...! ');
    //Navigator.of(context).pop(true);

    if (response.statusCode == 201) {
      String responseString = response.body;
      welcomeFromJson(responseString);
    } else {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe2e2e2),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF223345),
        toolbarHeight: 70,
        title: const Text(
          'Notify Manufacturer',
          style: TextStyle(
            color: Color(0xFFe2e2e2),
            fontSize: 20,
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
              image: AssetImage('lib/images/bg_logo.png'),
              opacity: 0.2,
              fit: BoxFit.fitWidth,
            )),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _globalKey,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Kindly fill this Form',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    notifyInputField(
                        null,
                        null,
                        null,
                        _name,
                        (value) => _validatename(value),
                        'Name',
                        'Enter Your Name'),
                    const SizedBox(
                      height: 30,
                    ),
                    notifyInputField(
                        null,
                        null,
                        null,
                        _email,
                        (value) => _validateemail(value),
                        'Email',
                        'Enter Your Email'),
                    const SizedBox(
                      height: 30,
                    ),
                    notifyInputField(
                        5,
                        8,
                        TextInputType.multiline,
                        _message,
                        (value) => _validatemessage(value),
                        'Message',
                        'Enter Your Message'),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            setState(() {
                              var formattedDate = DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now());
                              var formattedTime =
                                  DateFormat.jm().format(DateTime.now());
                              date = formattedDate;
                              time = formattedTime;
                            });
                            NotifyModel? notify = await _notifyadmin(_name.text,
                                _email.text, _message.text, date, time);
                            setState(() {
                              _notifyModel = notify;
                            });
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF223345),
                          padding: const EdgeInsets.only(
                              left: 28, right: 28, top: 18, bottom: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFe2e2e2),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget notifyInputField(minlines, maxlines, keyboardtype, controller,
      validator, labeltext, hinttext) {
    return TextFormField(
      minLines: minlines,
      maxLines: maxlines,
      keyboardType: keyboardtype,
      textAlign: TextAlign.start,
      controller: controller,
      validator: validator,
      style: const TextStyle(
        color: Color(0xFF223345),
      ),
      decoration: InputDecoration(
          labelText: labeltext,
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: Color(0xFF223345),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF223345),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Color(0xFF223345),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide:
                  const BorderSide(color: Color(0xFF223345), width: 1.0))),
    );
  }
}
