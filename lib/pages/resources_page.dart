
import 'materials_page.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 6,
    child:Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      leadingWidth: 54,
      leading: Icon(Icons.arrow_back),
      title: Text('flutterr'),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.picture_as_pdf,
            size: 24,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.notifications,
            size: 24,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.more_vert,
            size: 24,
          ),
        ),
      ],
      bottom: TabBar(
        isScrollable: true,
          tabs: const <Widget>[
            Tab(
              text: 'Transactions',
            ),
            Tab(
              text: 'Site',
            ),
            Tab(
              text: 'Task'
            ),
            Tab(
              text:'Attendance',
            ),
            Tab(
              text: 'Materials',
            ),
            Tab(
              text: 'Files',
            )
          ],
      
      ),
    ),

      body:  TabBarView(
          children: <Widget>[
            Center(
              child: Text("Transaction will appear here"),
            ),
            Center(
              child: Text("Site will appear here"),
            ),
            Center(
              child: Text("Task will appear here"),
            ),
            Center(
              child: Text('Attendance will appear here'),
            ),
              MaterialsPage(),
            Center(
              child: Text('Files will appear here'),
            )
          ],
        ),
    )
);
    
  }
}
