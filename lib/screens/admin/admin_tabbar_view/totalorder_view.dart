import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TotalOrders extends StatefulWidget {
  const TotalOrders({Key? key}) : super(key: key);

  @override
  State<TotalOrders> createState() => _TotalOrdersState();
}

class _TotalOrdersState extends State<TotalOrders> {
  Future<List<Orders>> displayproducts() async {
    String url = "https://mis.lasanian.com/api/orders";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode((response.body));
    List<Orders> orders = [];

    for (var u in jsonData) {
      Orders order = Orders(
        u['P_ID'].toString(),
        u['Data'].toString(),
        u['Date'],
        u['Time'],
        u['Email'],
      );
      orders.add(order);
    }
    print(orders.length);
    return orders;
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
            'MIS Orders',
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
              child: FutureBuilder<List<Orders>>(
                future: displayproducts(),
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
                                      "Order By :",
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
                                              const Text('Order On :',
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Order At :',
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
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Order :',
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
                                                      snapshot.data![i].Data,
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

class Orders {
  final String O_ID;
  final String Data;
  final String Date;
  final String Time;
  final String Email;

  Orders(
    this.O_ID,
    this.Data,
    this.Date,
    this.Time,
    this.Email,
  );
}
