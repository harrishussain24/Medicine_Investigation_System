import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AppUsers extends StatefulWidget {
  const AppUsers({Key? key}) : super(key: key);

  @override
  State<AppUsers> createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  Future<List<Users>> displayusers() async {
    String url = "https://mis.lasanian.com/api/users";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode((response.body));
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
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
            child: Text(
          'MIS Users',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        const Divider(
          thickness: 1,
          indent: 50,
          endIndent: 50,
          color: Color(0xFF223345),
        ),
        Expanded(
          child: Card(
            child: FutureBuilder<List<Users>>(
              future: displayusers(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: const Center(child: Text('Loading...!')),
                  );
                } else {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xFF223345)),
                            ),
                            child: ExpansionTile(
                              trailing: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF223345),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              title: Text(
                                snapshot.data![index].UserName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF223345)),
                              ),
                              children: [
                                Container(
                                  color: const Color(0xFF223345),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Email :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data![index].Email,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7.5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Phone No. :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data![index].Phone_No,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7.5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'CNIC :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data![index].CNIC,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7.5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Address :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              addresssplit(snapshot
                                                  .data![index].Address),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7.5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Pharmacy Name :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].Pharmacy_Name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7.5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Pharmacy Reg. No. :',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot
                                                  .data![index].Pharmacy_Reg_No,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: ElevatedButton(
                                              onPressed: () => {
                                                deleteData(
                                                    snapshot.data![index].U_ID)
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF223345),
                                                side: const BorderSide(
                                                  width: 4.0,
                                                  color: Color(0xFFe2e2e2),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 12,
                                                    bottom: 12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'DELETE USER',
                                                style: TextStyle(
                                                  color: Color(0xFFe2e2e2),
                                                  fontSize: 17,
                                                  letterSpacing: 4,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  addresssplit(String address) {
    var a = address.split(',');
    var b = a[0].trim();
    var finaladdress = b + "...";
    return finaladdress;
  }

  deleteData(String u_id) async {
    String url = "https://mis.lasanian.com/api/users/$u_id";
    var response = await http.delete(Uri.parse(url));
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      setState(() {});
      Fluttertoast.showToast(msg: 'User Deleted');
      print('User deleted');
    } else {
      return print('Not deleted');
    }
    return null;
  }
}

class Users {
  final String U_ID;
  final String UserName;
  final String Email;
  final String Phone_No;
  final String CNIC;
  final String Address;
  final String Pharmacy_Name;
  final String Pharmacy_Reg_No;
  final String Password;

  Users(this.U_ID, this.UserName, this.Email, this.Phone_No, this.CNIC,
      this.Address, this.Pharmacy_Name, this.Pharmacy_Reg_No, this.Password);
}

class DisplayUsers {
  final String U_ID;
  final String UserName;
  final String Email;
  final String Phone_No;
  final String CNIC;
  final String Address;
  final String Pharmacy_Name;
  final String Pharmacy_Reg_No;
  final String Password;

  DisplayUsers(this.U_ID, this.UserName, this.Email, this.Phone_No, this.CNIC,
      this.Address, this.Pharmacy_Name, this.Pharmacy_Reg_No, this.Password);
}
