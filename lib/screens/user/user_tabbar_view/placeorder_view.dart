import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/ordermodel.dart';

class PlaceOrder extends StatefulWidget {
  String email;
  PlaceOrder(this.email, {Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState(email);
}

class _PlaceOrderState extends State<PlaceOrder> {
  String email;
  _PlaceOrderState(this.email);
  late var date, time;
  OrderModel? _orderModel;
  final List<String> medicineName = [];

  final List<String> medicineQuantity = [];

  //list of controllers for the product texrfield
  final List<TextEditingController> _medicineControllers = [];

  //list of controller for the quantity textfield
  final List<TextEditingController> _quantityControllers = [];

  //variable to display error mesg
  String _error = '';

  bool button = false;
  //focus of textfields
  // List<FocusNode> _focusNodeList = [];
  // FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    medicineName.add('');
    medicineQuantity.add("");
    _medicineControllers.add(TextEditingController());
    _quantityControllers.add(TextEditingController());
    // _focusNodeList.add(FocusNode());
  }

  Future<OrderModel?> _addproduct(
      String dataa, String date, String time, String email) async {
    String url = "https://mis.lasanian.com/api/orders";
    var response = await http.post(Uri.parse(url),
        body: {"data": dataa, "date": date, "time": time, "email": email});
    var data = response.body;
    Fluttertoast.showToast(msg: 'Order Placed Successfully...😉');
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: Text(
            'Place Order',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          )),
          const Divider(
            thickness: 1,
            indent: 50,
            endIndent: 50,
            color: Color(0xFF223345),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: medicineName.length,
                  itemBuilder: ((context, index) {
                    //return(addwidget(index));

                    return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 60.0,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.1,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLength: 40,
                                controller: _medicineControllers[index],
                                decoration: const InputDecoration(
                                  hintText: 'Medicine Name',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              height: 58.0,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.1,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLength: 20,
                                controller: _quantityControllers[index],
                                decoration: const InputDecoration(
                                  hintText: 'Quantity',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: index == medicineName.length - 1
                            ? addIcon(index)
                            : delIcon(index));
                  })),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.065,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFF223345)),
              onPressed: () {
                _placeOrder(medicineName, medicineQuantity);
                setState(() {});
              },
              child: const Text(
                "Confirm Order",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
          )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void _deleteComments(int index) {
    setState(() {
      _medicineControllers.removeAt(index);
      medicineName.removeAt(index);
      _quantityControllers.removeAt(index);
      medicineQuantity.removeAt(index);
    });
  }

  Widget addIcon(int index) {
    return IconButton(
        onPressed: (() => {
              if (index == _medicineControllers.length - 1 &&
                  index == _quantityControllers.length - 1)
                {
                  if (_medicineControllers[_medicineControllers.length - 1]
                              .text !=
                          '' &&
                      _quantityControllers[_quantityControllers.length - 1]
                              .text !=
                          '')
                    {
                      setState(() {
                        _error = '';
                        print('commentsss');
                        print(medicineName);
                        medicineName[medicineName.length - 1] =
                            _medicineControllers[
                                    _medicineControllers.length - 1]
                                .text;
                        medicineName.add('');
                        medicineQuantity[medicineQuantity.length - 1] =
                            _quantityControllers[
                                    _quantityControllers.length - 1]
                                .text;
                        medicineQuantity.add('');
                        _medicineControllers.add(TextEditingController());
                        _quantityControllers.add(TextEditingController());
                        //button = !button;
                      })
                    }
                  else
                    {
                      setState(() {
                        _error = 'one or more text fields are empty';
                      })
                    }
                }
            }),
        icon: const Icon(Icons.add));
  }

  Widget delIcon(int index) {
    return IconButton(
        onPressed: (() => {_deleteComments(index)}),
        icon: const Icon(Icons.delete));
  }

  Future<void> _placeOrder(List medicineName, List medicineQuantity) async {
    //
    int row = medicineName.length;
    int col = 2;

    List medicines = [];

    for (int i = 0; i < medicineName.length - 1; i++) {
      medicines.add(medicine(medicineName[i], int.parse(medicineQuantity[i])));
    }
    setState(() {
      var formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      var formattedTime = DateFormat.jm().format(DateTime.now());
      date = formattedDate;
      time = formattedTime;
    });
    String em = email.toString();
    late String finalOrder;
    if (medicines.isNotEmpty) {
      finalOrder = medicines.toString();
      OrderModel? order = await _addproduct(finalOrder, date, time, em);
      setState(() {
        _orderModel = order;
      });
    }

    print(medicines.toString());
  }
}

class medicine {
  String name;
  int length;

  medicine(this.name, this.length);

  @override
  String toString() {
    return '{ ${this.name}, ${this.length} }';
  }
}

class Order {
  final String O_ID;
  final String Data;
  final String Date;
  final String Time;

  Order(
    this.O_ID,
    this.Data,
    this.Date,
    this.Time,
  );
}
