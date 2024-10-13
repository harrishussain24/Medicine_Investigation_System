import 'package:flutter/material.dart';
import 'package:mis/screens/user/user_tabbar_view/placeorder_view.dart';
import 'package:mis/screens/user/user_tabbar_view/profile_view.dart';
import 'package:mis/screens/user/user_tabbar_view/verifymedicine_view.dart';

class UserDashboard extends StatefulWidget {
  //static String id = 'userdashboard';
  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  UserDashboard(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  @override
  State<StatefulWidget> createState() => _UserDashboard(
      id, username, email, phone_no, cnic, address, p_name, p_reg_no, password);
}

class _UserDashboard extends State<UserDashboard> {
  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? cnic;
  String? address;
  String? p_name;
  String? p_reg_no;
  String? password;
  _UserDashboard(this.id, this.username, this.email, this.phone_no, this.cnic,
      this.address, this.p_name, this.p_reg_no, this.password);

  Future<void> _userlogout() async {
    Navigator.pushNamedAndRemoveUntil(
        context, '/afterupdate', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 70,
            elevation: 20,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF223345),
            // ignore: prefer_const_constructors
            title: Text(
              'Dashboard',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).bottomAppBarColor,
              tabs: [
                Tab(
                  text: 'Order',
                ),
                Tab(
                  text: 'Verify Medicine',
                ),
                Tab(
                  text: 'Profile',
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => _userlogout(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              PlaceOrder(email.toString()),
              const VerifyMedicine(),
              UserProfile(
                id.toString(),
                username.toString(),
                email.toString(),
                phone_no.toString(),
                cnic.toString(),
                address.toString(),
                p_name.toString(),
                p_reg_no.toString(),
                password.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
