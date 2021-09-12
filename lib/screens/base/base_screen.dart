import 'package:flutter/material.dart';
import 'package:lojavirtual/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/admin/admin_users.dart';
import 'package:lojavirtual/screens/base/home/home_screen.dart';
import 'package:lojavirtual/screens/base/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
@override
Widget build(BuildContext context) {
  return Provider(
    create: (_) => PageManager(pageController),
    child: Consumer<UserManager>(
      builder:(_,userManager,__){
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[

            HomeScreen(),
            ProductsScreen(),

            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home 2'),
              ),
            ),
            Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home 3'),
              ),
            ),

            if(userManager.adminEnabled)
              ...[

                AdminUsersScreen(),

                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: const Text('Pedidos'),
                  ),
                ),

              ]

          ],
        );
      },
    ),
  );
}
}
