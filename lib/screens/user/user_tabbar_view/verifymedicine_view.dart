import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mis/screens/notify/notifymanufacturer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class VerifyMedicine extends StatefulWidget {
  const VerifyMedicine({Key? key}) : super(key: key);

  @override
  State<VerifyMedicine> createState() => _VerifyMedicineState();
}

class _VerifyMedicineState extends State<VerifyMedicine> {
  String _scanBarcode = '';
  late Future futureProducts;
  bool showwidget = false;
  String? name = 'Name';
  String? b_no = 'Batch  No';
  String? m_date = 'Mfg. Date';
  String? e_date = 'Exp. Date';
  String? r_no = 'Registration No.';
  String? price = 'Price';

  Future<List> displayproducts(String key) async {
    // String url = "https://mis.lasanian.com/api/product/$key";
    var response = await http
        .get(Uri.https("10.0.2.2:44357", "api/users/$key".toString()));
    print(response.body);
    List? items = [];
    List? items1D = [];
    if (response.body.isNotEmpty && response.body != "[]") {
      String stringResponse = response.body;
      print("Response ...... \n" + stringResponse);
      if (stringResponse.isNotEmpty) {
        List lstResponse = stringResponse.split(",");

        for (int i = 1; i < 8; i++) {
          items.add(lstResponse[i].split(":"));
        }

        for (int i = 0; i < items.length; i++) {
          items1D.add(items[i][1].replaceAll('"', ""));
        }
        print("itemmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        print(items1D);
        setState(() {
          _controller_name.text = items1D[2];
          _controller_batchno.text = items1D[1];
          _controller_mfgdate.text = items1D[3];
          _controller_expdate.text = items1D[4];
          _controller_regno.text = items1D[5];
          _controller_price.text = items1D[6].toString();
        });
      }
      return items1D;
    } else {
      print("yesssss");
      Fluttertoast.showToast(msg: "Oops! Product Not Found");
      return [];
    }
  }

  String _a = '';

  late TextEditingController _controller_checking_med =
      TextEditingController(text: _scanBarcode);
  late TextEditingController _controller_checking =
      TextEditingController(text: _a);

  void _backtohomescreen() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _controller_checking_med.text = barcodeScanRes;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _controller_checking_med.text = barcodeScanRes;
    });
  }

  late String a = _controller_checking_med.text;

  late final TextEditingController _controller_name =
      TextEditingController(text: name.toString());
  late final TextEditingController _controller_batchno =
      TextEditingController(text: b_no);
  late final TextEditingController _controller_mfgdate =
      TextEditingController(text: m_date);
  late final TextEditingController _controller_expdate =
      TextEditingController(text: e_date);
  late final TextEditingController _controller_regno =
      TextEditingController(text: r_no);
  late final TextEditingController _controller_price =
      TextEditingController(text: price);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('lib/images/bg_logo.png'),
          opacity: 0.2,
          fit: BoxFit.fitWidth,
        )),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: 58.0,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextFormField(
                            controller: _controller_checking_med,
                            decoration: const InputDecoration(
                              hintText: 'Enter Barcode No.',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF223345)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            displayproducts(_controller_checking_med.text);
                            // setState(() {
                            //   showwidget = !showwidget;
                            // });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF223345),
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 18, bottom: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Check',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFe2e2e2),
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.41,
                      child: ElevatedButton(
                        onPressed: () => {scanBarcodeNormal()},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF223345),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Scan Barcode',
                          style: TextStyle(
                            color: Color(0xFFe2e2e2),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.41,
                      child: ElevatedButton(
                        onPressed: () => {scanQR()},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF223345),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Scan QRcode',
                          style: TextStyle(
                            color: Color(0xFFe2e2e2),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                formInputField(
                  context,
                  MediaQuery.of(context).size.width * 0.89,
                  56.0,
                  _controller_name,
                ),
                const SizedBox(
                  height: 20,
                ),
                formInputField(
                  context,
                  MediaQuery.of(context).size.width * 0.89,
                  56.0,
                  _controller_batchno,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    formInputField(
                      context,
                      MediaQuery.of(context).size.width * 0.437,
                      56.0,
                      _controller_mfgdate,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    formInputField(
                      context,
                      MediaQuery.of(context).size.width * 0.437,
                      56.0,
                      _controller_expdate,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                formInputField(
                  context,
                  MediaQuery.of(context).size.width * 0.89,
                  56.0,
                  _controller_regno,
                ),
                const SizedBox(
                  height: 20,
                ),
                formInputField(
                  context,
                  MediaQuery.of(context).size.width * 0.89,
                  56.0,
                  _controller_price,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotifyManufacturer()))
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
                  'Notify Manufacturer',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFFe2e2e2),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget formInputField(BuildContext context, width, height, controller) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          hintStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF223345)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
