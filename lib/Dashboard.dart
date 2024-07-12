// //plain code with login logout feature no table data fetching//

// // import 'dart:async'; // Import Timer
// // import 'package:flutter/material.dart';
// // import 'package:amplify_flutter/amplify_flutter.dart';
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:smarthelmet/fault.dart';
// // import 'package:smarthelmet/login_mobile.dart';
// // import 'package:smarthelmet/login_web.dart';
// // import 'package:smarthelmet/reports.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   final prefs = await SharedPreferences.getInstance();
// //   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

// //   runApp(SmartHelmetApp(isLoggedIn: isLoggedIn));
// // }

// // class SmartHelmetApp extends StatelessWidget {
// //   final bool isLoggedIn;

// //   SmartHelmetApp({required this.isLoggedIn});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Smart Helmet',
// //       theme: ThemeData(
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: isLoggedIn
// //           ? DashboardPage()
// //           : (kIsWeb ? LoginWebPage() : LoginMobilePage()),
// //     );
// //   }
// // }

// // class DashboardPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           kIsWeb ? WebStrip() : MobileStrip(),
// //           Scaffold(
// //             backgroundColor:
// //                 Colors.transparent, // Make scaffold background transparent
// //             appBar: AppBar(
// //               iconTheme: IconThemeData(color: Colors.white),
// //               backgroundColor:
// //                   Colors.transparent, // Make app bar background transparent
// //               elevation: 0, // Remove shadow
// //               title: Text(
// //                 'Dashboard',
// //                 style:
// //                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
// //               ),
// //               actions: [
// //                 Padding(
// //                   padding: EdgeInsets.only(right: 20),
// //                   child: Row(
// //                     children: [
// //                       Icon(
// //                         Icons.notifications,
// //                         color: Colors.white,
// //                         size: 30.0,
// //                       ),
// //                       SizedBox(
// //                         width: 20,
// //                       ),
// //                       PopupMenuButton<String>(
// //                         onSelected: (value) {
// //                           if (value == 'logout') {
// //                             _logout(context);
// //                           }
// //                         },
// //                         itemBuilder: (BuildContext context) {
// //                           return [
// //                             PopupMenuItem(
// //                               value: 'logout',
// //                               child: Text(
// //                                 'Log Out',
// //                                 style: TextStyle(
// //                                     fontSize: 18,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Color(0xffc40506)),
// //                               ),
// //                             ),
// //                           ];
// //                         },
// //                         child: CircleAvatar(
// //                           backgroundColor: Colors.white,
// //                           child: Icon(Icons.person),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             drawer: CustomDrawer(),
// //             body: kIsWeb ? WebDashboardContent() : MobileDashboardContent(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future<void> _signOut() async {
// //     try {
// //       await Amplify.Auth.signOut();
// //     } on AuthException catch (e) {
// //       print('Error signing out: $e');
// //     }
// //   }

// //   void _logout(BuildContext context) async {
// //     await _signOut();
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setBool('isLoggedIn', false);

// //     final screenWidth = MediaQuery.of(context).size.width;
// //     if (screenWidth > 600) {
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(builder: (context) => LoginWebPage()),
// //         (route) => false,
// //       );
// //     } else {
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(builder: (context) => LoginMobilePage()),
// //         (route) => false,
// //       );
// //     }
// //   }
// // }

// // class WebStrip extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 55, // Adjust the height as needed
// //       color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
// //     );
// //   }
// // }

// // class MobileStrip extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 100, // Adjust the height as needed
// //       // color: Color(0xffc3378a5),
// //       color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
// //     );
// //   }
// // }

// // class CustomDrawer extends StatefulWidget {
// //   @override
// //   _CustomDrawerState createState() => _CustomDrawerState();
// // }

// // class _CustomDrawerState extends State<CustomDrawer>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<Offset> _slideAnimation;
// //   late Animation<double> _opacityAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: Duration(milliseconds: 500),
// //     );
// //     _slideAnimation = Tween<Offset>(
// //       begin: Offset(0, 1),
// //       end: Offset.zero,
// //     ).animate(CurvedAnimation(
// //       parent: _controller,
// //       curve: Curves.easeInOut,
// //     ));
// //     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

// //     _controller.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       child: Column(
// //         children: [
// //           SizedBox(
// //             height: 20,
// //           ),
// //           SizedBox(
// //             height: 90,
// //             child: DrawerHeader(
// //               decoration: BoxDecoration(
// //                 image: DecorationImage(
// //                   image: AssetImage('assets/Images/commedianew.png'),
// //                   fit: BoxFit.contain,
// //                 ),
// //               ),
// //               child: null,
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView(
// //               padding: EdgeInsets.zero,
// //               children: [
// //                 ListTile(
// //                   leading: Icon(Icons.dashboard),
// //                   title: Text(
// //                     'Dashboard',
// //                     style: TextStyle(color: Color(0xffc3378a5)),
// //                   ),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => DashboardPage()),
// //                     );
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.warning),
// //                   title: Text('Fault Management',
// //                       style: TextStyle(color: Color(0xffc3378a5))),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => FaultmanagementPage()),
// //                     );
// //                   },
// //                 ),
// //                 ListTile(
// //                   leading: Icon(Icons.data_usage_rounded),
// //                   title: Text('Reports',
// //                       style: TextStyle(color: Color(0xffc3378a5))),
// //                   onTap: () {
// //                     Navigator.pop(context);
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => ReportPage()),
// //                     );
// //                   },
// //                 ),
// //                 SizedBox(
// //                   width: 120,
// //                   height: 70,
// //                   child: ListTile(
// //                     title: Image.asset(
// //                       'assets/Images/nelcologo.png', // Replace with your image asset path
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   height: 90,
// //                 ),
// //                 SlideTransition(
// //                   position: _slideAnimation,
// //                   child: FadeTransition(
// //                     opacity: _opacityAnimation,
// //                     child: Image.asset(
// //                       'assets/Images/helmetmain.png',
// //                       width: 250,
// //                       height: 180,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class WebDashboardContent extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Padding(
// //         padding: EdgeInsets.only(left: 16, right: 16, bottom: 160),
// // child: Container(
// //   decoration: BoxDecoration(
// //     border: Border.all(color: Colors.black, width: 1.0),
// //     borderRadius: BorderRadius.circular(7.0),
// //   ),
// //   child: SingleChildScrollView(
// //     scrollDirection: Axis.horizontal,
// //     child: DataTable(
// //       border: TableBorder(
// //         horizontalInside: BorderSide(width: 0.5, color: Colors.black),
// //         verticalInside: BorderSide(width: 0.5, color: Colors.black),
// //         top: BorderSide(width: 0.5, color: Colors.black),
// //         bottom: BorderSide(width: 0.5, color: Colors.black),
// //         left: BorderSide(width: 0.5, color: Colors.black),
// //         right: BorderSide(width: 0.5, color: Colors.black),
// //       ),
// //       columnSpacing: 70.0,
// //       dataRowHeight: 80.0,
// //       columns: <DataColumn>[
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'Helmet ID',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'Heart Rate',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'Environment Temperature',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'User Temperature',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'Gas',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Center(
// //             child: Text(
// //               'Overall Health',
// //               style: TextStyle(
// //                 color: Color(0xffc40506),
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 22,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //       rows: const <DataRow>[
// //         DataRow(
// //           cells: <DataCell>[
// //             DataCell(Center(child: Text('SM001'))),
// //             DataCell(Center(child: Text('72'))),
// //             DataCell(Center(child: Text('36.6°C'))),
// //             DataCell(Center(child: Text('36.6°C'))),
// //             DataCell(Center(child: Text('0.5 ppm'))),
// //             DataCell(Center(child: Text('Good'))),
// //           ],
// //         ),
// //       ],
// //     ),
// //   ),
// // ),
// //   ),
// // );
// //   }
// // }

// // class MobileDashboardContent extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             SizedBox(height: 16.0),
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 border: Border.all(color: Color(0xffc40506), width: 2.0),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Card(
// //                 color: Color.fromARGB(255, 255, 255, 255),
// //                 elevation: 0,
// //                 child: ListTile(
// //                   title: Text(
// //                     'Helmet ID: SM001',
// //                     style: TextStyle(
// //                         color: Colors.black,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 20),
// //                   ),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Username: Amey muley',
// //                         style: TextStyle(
// //                             fontWeight: FontWeight.w500, color: Colors.black),
// //                       ),
// //                       Text(
// //                         'Heart Rate: 72',
// //                         style: TextStyle(
// //                             fontWeight: FontWeight.w500, color: Colors.black),
// //                       ),
// //                       Text('Temperature: 36.6°C',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('GPS: 12.9716° N, 77.5946° E',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Gas: 0.5 ppm',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Overall Health: great',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 8.0),
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 border: Border.all(color: Color(0xffc40506), width: 2.0),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Card(
// //                 color: Color.fromARGB(255, 255, 255, 255),
// //                 elevation: 0,
// //                 child: ListTile(
// //                   title: Text(
// //                     'Helmet ID: SM002',
// //                     style: TextStyle(
// //                         color: Colors.black,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 20),
// //                   ),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text('Username: Abc xyz',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Heart Rate: 75',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Temperature: 36.8°C',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('GPS: 34.0522° N, 118.2437° W',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Gas: 0.4 ppm',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                       Text('Overall Health: Good',
// //                           style: TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               color: Colors.black)),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             // Add more cards as needed
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // finalized working code for dashboard //

// import 'dart:async'; // Import Timer
// import 'package:flutter/material.dart';
// import 'package:smarthelmet/alarms.dart';
// import 'package:smarthelmet/api_service.dart'; // Import the ApiService
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:smarthelmet/fault.dart';
// import 'package:smarthelmet/login_mobile.dart';
// import 'package:smarthelmet/login_web.dart';
// import 'package:smarthelmet/reports.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smarthelmet/user_management.dart';

// class NotificationManager {
//   List<Map<String, String>> notifications = [];
//   List<Map<String, String>> viewedNotifications = [];

//   void addNotification(Map<String, String> notification) {
//     notifications.add(notification);
//     // Store the notification in cache (e.g., SharedPreferences or Hive)
//     // This is a simplified example; you'll need to implement actual storage
//   }

//   void clearNotifications() {
//     viewedNotifications.addAll(notifications);
//     notifications.clear();
//     // Update the cache to remove the notifications for the next day
//   }

//   List<Map<String, String>> getNotifications() {
//     // Combine notifications and viewedNotifications for displaying
//     return [...viewedNotifications, ...notifications];
//   }

//   void clearOldNotifications() {
//     // This function should be called at the start of a new day
//     viewedNotifications.clear();
//     notifications.clear();
//     // Clear notifications from the cache
//   }
// }

// class DashboardPage extends StatefulWidget {
//   @override
//   _DashboardPageState createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   List<SmartHelmet> smartHelmets = [];
//   Timer? _timer;
//   NotificationManager notificationManager = NotificationManager();

//   @override
//   void initState() {
//     super.initState();
//     _fetchData(); // Fetch initial data
//     _startFetchingData(); // Start periodic fetching
//     _clearNotificationsDaily(); // Clear notifications at the start of a new day
//   }

//   void _startFetchingData() {
//     _timer = Timer.periodic(Duration(seconds: 4), (timer) {
//       _fetchData();
//     });
//   }

//   Future<void> _fetchData() async {
//     try {
//       List<SmartHelmet> fetchedData = await ApiService.fetchSmartHelmets();
//       setState(() {
//         smartHelmets = fetchedData;
//         _generateNotifications();
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   void _generateNotifications() {
//     List<Map<String, String>> newNotifications = [];
//     DateTime now = DateTime.now();
//     String formattedTime = '${now.hour}:${now.minute}:${now.second}';

//     for (var helmet in smartHelmets) {
//       double heartRate = double.tryParse(helmet.hrt) ?? 0;
//       double envTemp = helmet.envTemp;
//       double objTemp = helmet.objTemp;
//       double gas = helmet.gas;

//       if (heartRate > 60 || (heartRate < 50 && heartRate > 1)) {
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Heart Rate is not in healthy range'
//         });
//       }
//       if (envTemp > 40 || envTemp < 20) {
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Environmental Temperature is not in healthy range'
//         });
//       }
//       if (objTemp > 40 || objTemp < 20) {
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Object Temperature value is not in healthy range'
//         });
//       }
//       if (gas > 1000) {
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Gas Level value is not in healthy range'
//         });
//       }
//     }

//     setState(() {
//       if (newNotifications.isNotEmpty) {
//         for (var notification in newNotifications) {
//           notificationManager.addNotification(notification);
//         }
//       }
//     });
//   }

//   void _clearNotificationsDaily() {
//     Timer.periodic(Duration(hours: 24), (timer) {
//       setState(() {
//         notificationManager.clearOldNotifications();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           kIsWeb ? WebStrip() : MobileStrip(),
//           Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               iconTheme: IconThemeData(color: Colors.white),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: Text(
//                 'Dashboard',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20),
//                   child: Row(
//                     children: [
//                       Stack(
//                         children: [
//                           PopupMenuButton<String>(
//                             onSelected: (value) {
//                               setState(() {
//                                 notificationManager
//                                     .clearNotifications(); // Reset the notification count when the menu is opened
//                               });
//                             },
//                             // itemBuilder: (BuildContext context) {
//                             //   return notificationManager
//                             //       .getNotifications()
//                             //       .map((notification) {
//                             //     return PopupMenuItem<String>(
//                             //       value: notification['message']!,
//                             //       child: Text(
//                             //           '${notification['time']} - ${notification['message']}'),
//                             //     );
//                             //   }).toList();
//                             // },
//                             itemBuilder: (BuildContext context) {
//                               List<Map<String, String>> allNotifications =
//                                   notificationManager.getNotifications();
//                               if (allNotifications.isEmpty) {
//                                 return [
//                                   PopupMenuItem<String>(
//                                     value: 'no_notifications',
//                                     child: Text('No notifications'),
//                                   ),
//                                 ];
//                               }
//                               return allNotifications.map((notification) {
//                                 return PopupMenuItem<String>(
//                                   value: notification['message']!,
//                                   child: Text(
//                                       '${notification['time']} - ${notification['message']}'),
//                                 );
//                               }).toList();
//                             },

//                             icon: Icon(
//                               Icons.notifications,
//                               color: Colors.white,
//                               size: 30.0,
//                             ),
//                           ),
//                           if (notificationManager.notifications.isNotEmpty)
//                             Positioned(
//                               right: 0,
//                               child: Container(
//                                 padding: EdgeInsets.all(1),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 constraints: BoxConstraints(
//                                   minWidth: 16,
//                                   minHeight: 16,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     '${notificationManager.notifications.length}',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'logout') {
//                             _logout(context);
//                           }
//                         },
//                         itemBuilder: (BuildContext context) {
//                           return [
//                             PopupMenuItem(
//                               value: 'logout',
//                               child: Text(
//                                 'Log Out',
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xffc40506)),
//                               ),
//                             ),
//                           ];
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: Icon(Icons.person),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             drawer: CustomDrawer(),
//             body: smartHelmets.isEmpty
//                 ? Center(child: CircularProgressIndicator())
//                 : kIsWeb
//                     ? WebDashboardContent(smartHelmets: smartHelmets)
//                     : MobileDashboardContent(smartHelmets: smartHelmets),
//           ),
//         ],
//       ),
//     );
//   }

//working//

import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:smarthelmet/alarms.dart';
import 'package:smarthelmet/api_service.dart'; // Import the ApiService
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:smarthelmet/fault.dart';
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:smarthelmet/reports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthelmet/user_management.dart';

class NotificationManager {
  List<Map<String, String>> notifications = [];
  List<Map<String, String>> viewedNotifications = [];

  void addNotification(Map<String, String> notification) {
    notifications.add(notification);
    // Store the notification in cache (e.g., SharedPreferences or Hive)
    // This is a simplified example; you'll need to implement actual storage
  }

  void clearNotifications() {
    viewedNotifications.addAll(notifications);
    notifications.clear();
    // Update the cache to remove the notifications for the next day
  }

  List<Map<String, String>> getNotifications() {
    // Combine notifications and viewedNotifications for displaying
    return [...viewedNotifications, ...notifications];
  }

  void clearOldNotifications() {
    // This function should be called at the start of a new day
    viewedNotifications.clear();
    notifications.clear();
    // Clear notifications from the cache
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<SmartHelmet> smartHelmets = [];
  Timer? _timer;
  NotificationManager notificationManager = NotificationManager();

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch initial data
    _startFetchingData(); // Start periodic fetching
    _clearNotificationsDaily(); // Clear notifications at the start of a new day
  }

  void _startFetchingData() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    try {
      List<SmartHelmet> fetchedData = await ApiService.fetchSmartHelmets();
      setState(() {
        smartHelmets = fetchedData;
        _generateNotifications();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _generateNotifications() {
    List<Map<String, String>> newNotifications = [];
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute}:${now.second}';

    for (var helmet in smartHelmets) {
      double heartRate = double.tryParse(helmet.hrt) ?? 0;
      double envTemp = helmet.envTemp;
      double objTemp = helmet.objTemp;
      // double gas = helmet.gas;

      if (heartRate > 70 || (heartRate < 100 && heartRate > 20)) {
        newNotifications.add({
          'time': formattedTime,
          'message':
              'Helmet ID: ${helmet.deviceId} - Heart Rate is not in healthy range'
        });
      }
      if (envTemp > 40 || envTemp < 20) {
        newNotifications.add({
          'time': formattedTime,
          'message':
              'Helmet ID: ${helmet.deviceId} - Environmental Temperature is not in healthy range'
        });
      }
      if (objTemp > 40 || objTemp < 20) {
        newNotifications.add({
          'time': formattedTime,
          'message':
              'Helmet ID: ${helmet.deviceId} - Object Temperature value is not in healthy range'
        });
      }
      // if (gas > 1000) {
      //   newNotifications.add({
      //     'time': formattedTime,
      //     'message':
      //         'Helmet ID: ${helmet.deviceId} - Gas Level value is not in healthy range'
      //   });
      // }
    }

    setState(() {
      if (newNotifications.isNotEmpty) {
        for (var notification in newNotifications) {
          notificationManager.addNotification(notification);
        }
      }
    });
  }

  void _clearNotificationsDaily() {
    Timer.periodic(Duration(hours: 24), (timer) {
      setState(() {
        notificationManager.clearOldNotifications();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _resetNotificationCount() {
    setState(() {
      notificationManager.clearNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          kIsWeb ? WebStrip() : MobileStrip(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Dashboard',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right:
                          40), // Adjust this value to move the icon to the left
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              setState(() {
                                _resetNotificationCount(); // Clear notifications and reset the count
                              });
                            },
                            onCanceled: () {
                              setState(() {
                                _resetNotificationCount(); // Clear notifications and reset the count
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              List<Map<String, String>> allNotifications =
                                  notificationManager.getNotifications();
                              if (allNotifications.isEmpty) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'no_notifications',
                                    child: Text('No notifications'),
                                  ),
                                ];
                              }
                              return allNotifications.map((notification) {
                                return PopupMenuItem<String>(
                                  value: notification['message']!,
                                  child: Text(
                                      '${notification['time']} - ${notification['message']}'),
                                );
                              }).toList();
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          if (notificationManager.notifications.isNotEmpty)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Center(
                                  child: Text(
                                    '${notificationManager.notifications.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                        ],
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
            body: smartHelmets.isEmpty
                ? Center(child: CircularProgressIndicator())
                : kIsWeb
                    ? WebDashboardContent(smartHelmets: smartHelmets)
                    : MobileDashboardContent(smartHelmets: smartHelmets),
          ),
        ],
      ),
    );
  }
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
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);

  final screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 600) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginWebPage()),
      (route) => false,
    );
  } else {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginMobilePage()),
      (route) => false,
    );
  }
}
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

class WebStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55, // Adjust the height as needed
      color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
    );
  }
}

class MobileStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust the height as needed
      // color: Color(0xffc3378a5),
      color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
    );
  }
}

class WebDashboardContent extends StatefulWidget {
  final List<SmartHelmet> smartHelmets;

  WebDashboardContent({required this.smartHelmets});

  @override
  _WebDashboardContentState createState() => _WebDashboardContentState();
}

class _WebDashboardContentState extends State<WebDashboardContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/Images/commedianew.png', // Update the path to your logo asset
            width: 200, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          ),
        ),
        // Center(
        //   child: Padding(
        //     padding: EdgeInsets.only(left: 16, right: 16, bottom: 180),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.black, width: 1.0),
        //         borderRadius: BorderRadius.circular(7.0),
        //       ),
        //       child: SingleChildScrollView(
        //         scrollDirection: Axis.horizontal,
        //         child: DataTable(
        //           border: TableBorder(
        //             horizontalInside:
        //                 BorderSide(width: 0.5, color: Colors.black),
        //             verticalInside: BorderSide(width: 0.5, color: Colors.black),
        //             top: BorderSide(width: 0.5, color: Colors.black),
        //             bottom: BorderSide(width: 0.5, color: Colors.black),
        //             left: BorderSide(width: 0.5, color: Colors.black),
        //             right: BorderSide(width: 0.5, color: Colors.black),
        //           ),
        //           columnSpacing: 60.0,
        //           dataRowHeight: 40.0,
        //           columns: <DataColumn>[
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'ID',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     // color: Color.fromARGB(250, 9, 14, 20),
        //                     // color: Color.fromARGB(255, 103, 103, 109),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'User',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Hrt',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Environment temp',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'User Temp',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Volatile Gas',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Carbon',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Nitrogen',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Alcohol',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             DataColumn(
        //               label: Center(
        //                 child: Text(
        //                   'Overall Health',
        //                   style: TextStyle(
        //                     color: Color(0xffc3378a5),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 22,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //           rows: widget.smartHelmets.map((helmet) {
        //             return DataRow(
        //               cells: [
        //                 DataCell(Center(child: Text(helmet.deviceId))),
        //                 DataCell(Center(child: Text("Amey"))),
        //                 DataCell(Center(child: Text(helmet.hrt.toString()))),
        //                 DataCell(Center(child: Text('${helmet.envTemp}°C'))),
        //                 DataCell(Center(child: Text('${helmet.objTemp}°C'))),
        //                 DataCell(
        //                     Center(child: Text('${helmet.volatileGas} ppm'))),
        //                 DataCell(Center(
        //                     child: Text('${helmet.carbonMonoxide} ppm'))),
        //                 DataCell(Center(
        //                     child: Text('${helmet.nitrogenDioxide} ppm'))),
        //                 DataCell(Center(child: Text('${helmet.alcohol} ppm'))),
        //                 DataCell(Center(
        //                   child: Text('Good'),
        //                 )), // Add logic for overall health
        //               ],
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        Center(
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 190),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.black),
                      columnSpacing: 50,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(255, 173, 196, 214)),
                      columns: [
                        DataColumn(
                            label: Center(
                                child: Text('ID',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('User',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Hrt',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Environment temp',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('User Temp',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Volatile Gas',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Carbon',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Nitrogen',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Alcohol',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                        DataColumn(
                            label: Center(
                                child: Text('Overall Health',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)))),
                      ],
                      rows: widget.smartHelmets.map((helmet) {
                        return DataRow(
                          cells: [
                            DataCell(Center(child: Text(helmet.deviceId))),
                            DataCell(Center(child: Text("Amey"))),
                            DataCell(
                                Center(child: Text(helmet.hrt.toString()))),
                            DataCell(
                                Center(child: Text('${helmet.envTemp}°C'))),
                            DataCell(
                                Center(child: Text('${helmet.objTemp}°C'))),
                            DataCell(Center(
                                child: Text('${helmet.volatileGas} ppm'))),
                            DataCell(Center(
                                child: Text('${helmet.carbonMonoxide} ppm'))),
                            DataCell(Center(
                                child: Text('${helmet.nitrogenDioxide} ppm'))),
                            DataCell(
                                Center(child: Text('${helmet.alcohol} ppm'))),
                            DataCell(Center(
                                child: Text(
                                    'Good'))), // Add logic for overall health
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

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

class MobileDashboardContent extends StatelessWidget {
  final List<SmartHelmet> smartHelmets;

  MobileDashboardContent({required this.smartHelmets});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: smartHelmets.map((helmet) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffc40506), width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(bottom: 8.0),
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Helmet ID: ${helmet.deviceId}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Heart Rate: ${helmet.hrt}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Temperature: ${helmet.envTemp}°C',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        'Overall Health: Good',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
