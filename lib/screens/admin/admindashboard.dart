import 'package:flutter/material.dart';
import 'package:mis/screens/admin/admin_tabbar_view/addproduct_view.dart';
import 'package:mis/screens/admin/admin_tabbar_view/appnotifications.dart';
import 'package:mis/screens/admin/admin_tabbar_view/totalorder_view.dart';
import 'package:mis/screens/authentication/admin_login.dart';
import 'package:mis/screens/user/userprofile.dart';

import 'admin_tabbar_view/appusers_view.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminDashboard> {
  void _amdinlogout() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 20,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF223345),
            title: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 500
                    ? 30
                    : MediaQuery.of(context).size.width < 500
                        ? 25
                        : 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).bottomAppBarColor,
              tabs: const [
                Tab(
                  text: 'Orders',
                ),
                Tab(
                  text: 'Products',
                ),
                Tab(
                  text: 'Users',
                ),
                Tab(
                  text: 'Notification',
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => _amdinlogout(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              TotalOrders(),
              Product(),
              AppUsers(),
              MedNotifications()
            ],
          ),
        ),
      ),
    );
  }
}
