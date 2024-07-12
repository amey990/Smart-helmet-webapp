import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:smarthelmet/Dashboard.dart';
import 'package:smarthelmet/alarms.dart';
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:smarthelmet/reports.dart';
import 'package:smarthelmet/user_management.dart';

void main() {
  runApp(SmartHelmetApp());
}

class SmartHelmetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Helmet',
      theme: ThemeData(
        primaryColor: Color(0xFF3378A5),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/dashboard',
      routes: {},
    );
  }
}

class FaultmanagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          kIsWeb ? WebStrip() : MobileStrip(),
          Scaffold(
            backgroundColor:
                Colors.transparent, // Make scaffold background transparent
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor:
                  Colors.transparent, // Make app bar background transparent
              elevation: 0, // Remove shadow
              title: Text(
                'Fault Management',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'logout') {
                            _logout(context);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: 'logout',
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffc40506)),
                              ),
                            ),
                          ];
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            drawer: CustomDrawer(),
            body: kIsWeb ? WebFaultContent() : MobileFaultContent(),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print('Error signing out: $e');
    }
  }

  void _logout(BuildContext context) async {
    await _signOut();
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      // Navigate to Web Login Page if screen width is greater than 600
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginWebPage()),
        (route) => false,
      );
    } else {
      // Navigate to Mobile Login Page if screen width is 600 or less
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginMobilePage()),
        (route) => false,
      );
    }
  }
}

class WebStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55, // Adjust the height as needed
      // color: Color(0xffc3378a5), // The color of the strip
      color: Color.fromARGB(251, 25, 87, 128),
    );
  }
}

class MobileStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height as needed
      // color: Color(0xffc3378a5), // The color of the strip
      color: Color.fromARGB(251, 25, 87, 128),
    );
  }
}

// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: 90,
//             child: DrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/Images/commedianew.png'),
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               child: null,
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.dashboard),
//                   title: Text(
//                     'Dashboard',
//                     style: TextStyle(color: Color(0xffc3378a5)),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => DashboardPage()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.warning),
//                   title: Text('Fault Management',
//                       style: TextStyle(color: Color(0xffc3378a5))),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => FaultmanagementPage()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.data_usage_rounded),
//                   title: Text('Reports',
//                       style: TextStyle(color: Color(0xffc3378a5))),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ReportPage()),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   width: 120,
//                   height: 70,
//                   child: ListTile(
//                     title: Image.asset(
//                       'assets/Images/nelcologo.png', // Replace with your image asset path
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 90,
//                 ),
//                 Image.asset(
//                   'assets/Images/helmetmain.png',
//                   width: 250,
//                   height: 180,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 90,
            child: DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Images/commedianew.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: null,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(color: Color(0xffc3378a5)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.warning),
                  title: Text('Fault Management',
                      style: TextStyle(color: Color(0xffc3378a5))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FaultmanagementPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.data_usage_rounded),
                  title: Text('Reports',
                      style: TextStyle(color: Color(0xffc3378a5))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User Management',
                      style: TextStyle(color: Color(0xffc3378a5))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.crisis_alert),
                  title: Text('Alarms',
                      style: TextStyle(color: Color(0xffc3378a5))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlarmsPage()),
                    );
                  },
                ),
                SizedBox(
                  width: 120,
                  height: 70,
                  child: ListTile(
                    title: Image.asset(
                      'assets/Images/nelcologo.png', // Replace with your image asset path
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Image.asset(
                      'assets/Images/helmetmain.png',
                      width: 250,
                      height: 180,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WebFaultContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          // child: Padding(
          //   padding: EdgeInsets.all(16),
          child: Image.asset(
            'assets/Images/commedianew.png', // Update the path to your logo asset
            width: 200, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          ),
          // ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 160),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder(
                    horizontalInside:
                        BorderSide(width: 0.5, color: Colors.black),
                    verticalInside: BorderSide(width: 0.5, color: Colors.black),
                    top: BorderSide(width: 0.5, color: Colors.black),
                    bottom: BorderSide(width: 0.5, color: Colors.black),
                    left: BorderSide(width: 0.5, color: Colors.black),
                    right: BorderSide(width: 0.5, color: Colors.black),
                  ),
                  columnSpacing: 100.0,
                  dataRowHeight: 80.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Helmet ID',
                          style: TextStyle(
                            color: Color(0xffc3378a5),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Active Sensors',
                          style: TextStyle(
                            color: Color(0xffc3378a5),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'In-Active Sensors',
                          style: TextStyle(
                            color: Color(0xffc3378a5),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Helmet Status',
                          style: TextStyle(
                            color: Color(0xffc3378a5),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Center(child: Text('01'))),
                        DataCell(Center(child: Text('3'))),
                        DataCell(Center(child: Text('1'))),
                        DataCell(Center(child: Text('working'))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 5),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/Images/bottomhelmet.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
        // Footer Section
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[200],
            child: Center(
              child: Text(
                '\u00a9 Copyright 2024 - Commedia All Rights Reserved',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileFaultContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffc40506), width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Helmet ID: SM001',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username: Amey muley',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Active Sensors: 3',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Inactive Sensors: 1',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Helmet Status: Working',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffc40506), width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Helmet ID: SM002',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username: Abc xyz',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Active Sensors: 4',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Inactive Sensors:0',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Helmet Status: Working',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Add more cards as needed
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
