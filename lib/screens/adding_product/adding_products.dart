import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mis/screens/models/product_adding_model.dart';
import 'dart:math';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:http/http.dart' as http;

class AddProdduct extends StatefulWidget {
  const AddProdduct({Key? key}) : super(key: key);

  @override
  State<AddProdduct> createState() => _AddProdductState();
}

class _AddProdductState extends State<AddProdduct> {
  // for validation
  final GlobalKey<FormState> _globalKey = GlobalKey();

  ProductModel? _productModel;
  bool showWidget = false;
  var b_code_no = 'Barcode No.';
  var qr_code_no = 'QRcode No.';
  TextEditingController _controller_unique_id = TextEditingController();
  TextEditingController _controller_batch_no = TextEditingController();
  TextEditingController _controller_med_name = TextEditingController();
  TextEditingController _controller_mfg_date = TextEditingController();
  TextEditingController _controller_exp_date = TextEditingController();
  TextEditingController _controller_reg_no = TextEditingController();
  TextEditingController _controller_price = TextEditingController();
  late TextEditingController _controller_barcode =
      TextEditingController(text: b_code_no);
  late TextEditingController _controller_qrcode =
      TextEditingController(text: qr_code_no);

  String? _validate_unique_id(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Product ID");
    }
    return null;
  }

  String? _validate_batch_no(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Batch No");
    }
    return null;
  }

  String? _validate_med_name(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Medicine Name");
    }
    if (!RegExp("^[A-Za-z]").hasMatch(value)) {
      return ("Please Enter a Valid Medicine Name");
    }
    return null;
  }

  String? _validate_mfg_date(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Mfg. Date");
    }
    if (!RegExp("^[0-9]+[/-]+[0-9]+[/-]+[0-9]").hasMatch(value)) {
      return ("Please Enter a Valid Date");
    }
    return null;
  }

  String? _validate_exp_date(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Exp. Date");
    }
    if (!RegExp("^[0-9]+[/-]+[0-9]+[/-]+[0-9]").hasMatch(value)) {
      return ("Please Enter a Valid Date");
    }
    return null;
  }

  String? _validate_reg_no(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Registration No.");
    }
    if (!RegExp("^[0-9/-]").hasMatch(value)) {
      return ("Please Enter a Valid Registration No.");
    }
    return null;
  }

  String? _validate_price(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Price");
    }
    if (!RegExp("^[0-9]").hasMatch(value)) {
      return ("Please Enter a Valid Price");
    }
    return null;
  }

  // random values for barcode / qr code
  final random = Random.secure();

  late String u_id = _controller_unique_id.text;
  late String b_no = _controller_batch_no.text;
  late String m_name = _controller_med_name.text;
  late String mfg_date = _controller_mfg_date.text;
  late String exp_date = _controller_exp_date.text;
  late String r_no = _controller_reg_no.text;
  late String price = _controller_price.text;

  String generatePassword({required int length}) {
    String allValidCharacters =
        '$u_id$b_no$m_name$mfg_date$exp_date$r_no$price';

    var rest = [
      for (var i = 0; i < length; i += 1)
        allValidCharacters[random.nextInt(allValidCharacters.length)],
    ];

    return ((rest)..shuffle(random)).join().toString();
  }

  late var valueforbarcode_qrcode = generatePassword(length: 12);

  Widget barcodegenerate() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.4,
      child: SfBarcodeGenerator(
        value: valueforbarcode_qrcode,
        showValue: true,
      ),
    );
  }

  Widget qrcodegenerate() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.4,
      child: SfBarcodeGenerator(
        value: valueforbarcode_qrcode,
        showValue: true,
        symbology: QRCode(),
      ),
    );
  }

  Future<ProductModel?> _addproduct(
      String unique_id,
      String batch_no,
      String medicine_name,
      String mfg_date,
      String exp_date,
      String registration_no,
      String price,
      String barcode_no,
      String qrcode_no) async {
    String url = "https://mis.lasanian.com/api/product";
    try {
      if (_globalKey.currentState!.validate()) {
        if (showWidget == true) {
          var response = await http.post(Uri.parse(url), body: {
            "unique_id": unique_id,
            "batch_no": batch_no,
            "medicine_name": medicine_name,
            "mfg_date": mfg_date,
            "exp_date": exp_date,
            "registration_no": registration_no,
            "price": price,
            "barcode_no": barcode_no,
            "qrcode_no": qrcode_no,
          });
          var data = response.body;
          _controller_unique_id.clear();
          _controller_batch_no.clear();
          _controller_med_name.clear();
          _controller_mfg_date.clear();
          _controller_exp_date.clear();
          _controller_reg_no.clear();
          _controller_price.clear();
          _controller_barcode.clear();
          _controller_qrcode.clear();
          setState(() {
            showWidget = false;
          });
          Fluttertoast.showToast(msg: 'Product Added Successfully...😉');
          Navigator.of(context).pop(true);

          if (response.statusCode == 201) {
            String responseString = response.body;
            welcomeFromJson(responseString);
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF223345),
        title: const Text(
          'Adding Product',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'lib/images/bg_logo.png',
                    ),
                    opacity: 0.2,
                    fit: BoxFit.fitWidth)),
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: Form(
                key: _globalKey,
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Details of Product',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 500
                              ? 30
                              : MediaQuery.of(context).size.width < 500
                                  ? 25
                                  : 30,
                          color: const Color(0xFF223345),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addProductField(
                              context,
                              MediaQuery.of(context).size.width * 0.443,
                              _controller_unique_id,
                              (value) => _validate_unique_id(value),
                              'Unique ID'),
                          const SizedBox(
                            width: 5,
                          ),
                          addProductField(
                              context,
                              MediaQuery.of(context).size.width * 0.442,
                              _controller_batch_no,
                              (value) => _validate_batch_no(value),
                              'Batch No.'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      addProductField(
                          context,
                          MediaQuery.of(context).size.width * 0.89,
                          _controller_med_name,
                          (value) => _validate_med_name(value),
                          'Medicine Name'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addProductField(
                            context,
                            MediaQuery.of(context).size.width * 0.442,
                            _controller_mfg_date,
                            (value) => _validate_mfg_date(value),
                            "Mfg. Date",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          addProductField(
                              context,
                              MediaQuery.of(context).size.width * 0.443,
                              _controller_exp_date,
                              (value) => _validate_exp_date(value),
                              'Exp. Date')
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      addProductField(
                          context,
                          MediaQuery.of(context).size.width * 0.89,
                          _controller_reg_no,
                          (value) => _validate_reg_no(value),
                          'Registration No.'),
                      const SizedBox(
                        height: 20,
                      ),
                      addProductField(
                        context,
                        MediaQuery.of(context).size.width * 0.89,
                        _controller_price,
                        (value) => _validate_price(value),
                        'Price',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  showWidget = !showWidget;
                                  b_code_no = valueforbarcode_qrcode;
                                  qr_code_no = valueforbarcode_qrcode;
                                }),
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF223345),
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, top: 18, bottom: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Generate Barcode & QRcode',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFe2e2e2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      showWidget
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    barcodegenerate(),
                                    qrcodegenerate(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    addProductField(
                                        context,
                                        MediaQuery.of(context).size.width *
                                            0.442,
                                        _controller_qrcode,
                                        null,
                                        null),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    addProductField(
                                        context,
                                        MediaQuery.of(context).size.width *
                                            0.443,
                                        _controller_qrcode,
                                        null,
                                        null),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: ElevatedButton(
                              onPressed: () async {
                                String unique_id = _controller_unique_id.text;
                                String batch_no = _controller_batch_no.text;
                                String med_name = _controller_med_name.text;
                                String mfg_date = _controller_mfg_date.text;
                                String exp_date = _controller_exp_date.text;
                                String reg_no = _controller_reg_no.text;
                                String price = _controller_price.text;
                                String b_code = _controller_barcode.text;
                                String qrcode = _controller_qrcode.text;

                                ProductModel? data = await _addproduct(
                                    unique_id,
                                    batch_no,
                                    med_name,
                                    mfg_date,
                                    exp_date,
                                    reg_no,
                                    price,
                                    b_code,
                                    qrcode);

                                setState(() {
                                  _productModel = data;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF223345),
                                padding: const EdgeInsets.only(
                                    left: 28, right: 28, top: 13, bottom: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: MediaQuery.of(context).size.width >
                                          500
                                      ? 30
                                      : MediaQuery.of(context).size.width < 500
                                          ? 22
                                          : 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addProductField(
      BuildContext context, width, controller, validator, hinttext) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xFF223345)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF223345), width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
