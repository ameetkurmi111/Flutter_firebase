import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'side_bar_screens/categories_screen.dart';
import 'side_bar_screens/dashboard_screen.dart';
import 'side_bar_screens/order_screen.dart';
import 'side_bar_screens/product_screen.dart';
import 'side_bar_screens/upload_banner.dart';
import 'side_bar_screens/vendors_screen.dart';
import 'side_bar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DahboardScreen();

  void _screenSelector(AdminMenuItem item) {
    switch (item.route) {
      case DahboardScreen.routeName:
        setState(() {
          _selectedItem = DahboardScreen();
        });
        break;
      case VendorScreen.routeName:
        setState(() {
          _selectedItem = VendorScreen();
        });
        break;
      case CategoryScreen.routeName:
        setState(() {
          _selectedItem = CategoryScreen();
        });
        break;
      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;
      case UploadBanner.routeName:
        setState(() {
          _selectedItem = UploadBanner();
        });
        break;
      case WithdrawlScreen.routeName:
        setState(() {
          _selectedItem = WithdrawlScreen();
        });
        break;
    }
    Navigator.pop(context); // Close the drawer after selecting an item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: Text('Management'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: const Color(0xff444444),
              child: const Center(
                child: Text(
                  'Admin Store Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Dashboard'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Dashboard',
                        icon: Icons.dashboard,
                        route: DahboardScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.person_3),
                    title: Text('Vendors'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Vendors',
                        icon: CupertinoIcons.person_3,
                        route: VendorScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.money_dollar),
                    title: Text('Withdrawal'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Withdrawal',
                        icon: CupertinoIcons.money_dollar,
                        route: WithdrawlScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.shopping_cart),
                    title: Text('Orders'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Orders',
                        icon: CupertinoIcons.shopping_cart,
                        route: OrderScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text('Categories'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Categories',
                        icon: Icons.category,
                        route: CategoryScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text('Products'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Products',
                        icon: Icons.shop,
                        route: ProductScreen.routeName,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.add),
                    title: Text('Upload Banners'),
                    onTap: () => _screenSelector(
                      AdminMenuItem(
                        title: 'Upload Banners',
                        icon: CupertinoIcons.add,
                        route: UploadBanner.routeName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xff444444),
              child: const Center(
                child: Text(
                  'Footer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _selectedItem,
    );
  }
}
