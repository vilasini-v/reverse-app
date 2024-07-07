import 'package:construction_part2/pages/used_page.dart';

import 'inventory_page.dart';
import 'receive_page.dart';
import 'request_page.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: 
          ButtonsTabBar(
        // Customize the appearance and behavior of the tab bar
        backgroundColor: Colors.deepPurple[400],
        borderWidth: 0,
        borderColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
        ),
        unselectedDecoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 60,
        radius: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 14)  ,
        buttonMargin: EdgeInsets.all(8)    ,
                tabs: const [
                  Tab(
                    text: 'Inventory',
                  ),
                  Tab(
                    text: ' Receive ',
                  ),
                  Tab(
                    text: ' Request ',
                  ),
                  Tab(
                    text: '  Used  ',
                  )
                ]),
        
      body: const TabBarView(children: [
            InventoryPage(),
            ReceivePage(),
            RequestPage(),
            UsedPage(),
          ]),
        ));
  }
}