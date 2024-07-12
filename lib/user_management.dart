import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:smarthelmet/Dashboard.dart';
import 'package:smarthelmet/adduser.dart';
import 'package:smarthelmet/alarms.dart';
import 'package:smarthelmet/fault.dart';
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:smarthelmet/reports.dart';
import 'package:smarthelmet/userlist.dart';

void main() {
  runApp(SmartHelmetApp());
}

class SmartHelmetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Helmet',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/dashboard',
    );
  }
}

class UserPage extends StatelessWidget {
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
                'User Management',
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
            body: kIsWeb ? WebReportsContent() : MobileReportsContent(),
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

class WebReportsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,

          // child: Padding(
          //   padding: EdgeInsets.only( left: 70),
          child: Image.asset(
            'assets/Images/commedianew.png', // Update the path to your logo asset
            width: 200, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          ),
          // ),
          // ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 220),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdduserPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                              0xffc40506), // Use primary to set the background color to red
                        ),
                        child: Text(
                          "Add User",
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserListPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(
                              0xffc40506), // Use primary to set the background color to red
                        ),
                        child: Text(
                          "User List",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                // ),
                // Add DataTable for reports data here
              ],
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

class MobileReportsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  items: <String>[
                    'Select Helmet ID',
                    'H001',
                    'H002',
                    'H003',
                    // Add more options as needed
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  hint: Text('Select Helmet ID'),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  items: <String>[
                    'Select Timeframe',
                    '1 Week',
                    '15 Days',
                    '1 Month',
                    // Add more options as needed
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  hint: Text('Select Timeframe'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement download report functionality
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Download Report'),
                          content: Text(
                            'Implement logic to download report for selected parameters.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                        0xffc40506), // Use primary to set the background color to red
                  ),
                  child: Text(
                    'Download',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
