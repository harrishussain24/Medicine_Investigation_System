import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mis/screens/adding_product/adding_products.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Future<List<Products>> displayproducts() async {
    String url = "https://mis.lasanian.com/api/product";
    var response = await http
        .get(Uri.parse(url), headers: {'content-type': 'application/json'});
    var jsonData = jsonDecode((response.body));
    List<Products> products = [];

    for (var u in jsonData) {
      Products product = Products(
          u['P_ID'].toString(),
          u['Unique_ID'].toString(),
          u['Batch_No'],
          u['Medicine_Name'],
          u['Mfg_Date'],
          u['Exp_Date'],
          u['Registration_No'],
          u['Price'].toString(),
          u['Barcode_No'],
          u['QRcode_No']);
      products.add(product);
    }
    print(products.length);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage(
      //         'lib/images/bg_logo.png',
      //       ),
      //       opacity: 0.2,
      //       fit: BoxFit.fitWidth),
      // ),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.065,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProdduct()))
                        .then((value) => setState(() {}))
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF223345),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 13, bottom: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'MIS Products',
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
              child: FutureBuilder<List<Products>>(
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
                                title: Text(
                                  snapshot.data![i].Medicine_Name,
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
                                                'Unique ID :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Unique_ID,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Batch No. :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Batch_No,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Mfg. Date :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Mfg_Date,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Exp. Date :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Exp_Date,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Registration No. :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot
                                                    .data![i].Registration_No,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Price :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Price,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Barcode No. :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].Barcode_No,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'QRcode No. :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data![i].QRcode_No,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
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

class Products {
  final String P_ID;
  final String Unique_ID;
  final String Batch_No;
  final String Medicine_Name;
  final String Mfg_Date;
  final String Exp_Date;
  final String Registration_No;
  final String Price;
  final String Barcode_No;
  final String QRcode_No;

  Products(
      this.P_ID,
      this.Unique_ID,
      this.Batch_No,
      this.Medicine_Name,
      this.Mfg_Date,
      this.Exp_Date,
      this.Registration_No,
      this.Price,
      this.Barcode_No,
      this.QRcode_No);
}
