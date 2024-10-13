import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MedNotifications extends StatefulWidget {
  const MedNotifications({Key? key}) : super(key: key);

  @override
  State<MedNotifications> createState() => _MedNotificationsState();
}

class _MedNotificationsState extends State<MedNotifications> {
  Future<List<Notifications>> displaynotifications() async {
    String url = "https://mis.lasanian.com/api/notify";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode((response.body));
    List<Notifications> notify = [];

    for (var u in jsonData) {
      Notifications noti = Notifications(
        u['N_ID'].toString(),
        u['Name'].toString(),
        u['Email'].toString(),
        u['Message'].toString(),
        u['Date'].toString(),
        u['Time'].toString(),
      );
      notify.add(noti);
    }
    print(notify.length);
    return notify;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'lib/images/bg_logo.png',
              ),
              opacity: 0.2,
              fit: BoxFit.fitWidth)),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'MIS Notifications',
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
              child: FutureBuilder<List<Notifications>>(
                future: displaynotifications(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: const Center(child: Text('Loading...!')),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
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
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Sender :",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFF223345),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![i].Email,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF223345)),
                                    ),
                                  ],
                                ),
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF223345)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Name :',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(snapshot.data![i].Name,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Time :',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(snapshot.data![i].Time,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Date :',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(snapshot.data![i].Date,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Message :',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Flexible(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                      snapshot.data![i].Message,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w500)),
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
                          );
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Notifications {
  final String N_ID;
  final String Name;
  final String Email;
  final String Message;
  final String Date;
  final String Time;

  Notifications(
    this.N_ID,
    this.Name,
    this.Email,
    this.Message,
    this.Date,
    this.Time,
  );
}
