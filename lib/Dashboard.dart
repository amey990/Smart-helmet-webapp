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

//finalized by amey//

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
//       // double volatileGas = helmet.volatileGas;
//       // double carbonMonoxide = helmet.carbonMonoxide;
//       // double nitrogenDioxide = helmet.nitrogenDioxide;
//       // double alcohol = helmet.alcohol;

//       int thresholdCount = 0;

//       if (heartRate > 120 || (heartRate < 50 && heartRate != 0)) {
//         thresholdCount++;
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Heart Rate is not in healthy range'
//         });
//       }
//       if (envTemp > 40 || envTemp < 20) {
//         thresholdCount++;
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - Environmental Temperature is not in healthy range'
//         });
//       }
//       if (objTemp > 40 || objTemp < 20) {
//         thresholdCount++;
//         newNotifications.add({
//           'time': formattedTime,
//           'message':
//               'Helmet ID: ${helmet.deviceId} - User Temperature value is not in healthy range'
//         });
//       }
//       // if (volatileGas > 5000 || volatileGas < 1000) {
//       //   newNotifications.add({
//       //     'time': formattedTime,
//       //     'message':
//       //         'Helmet ID: ${helmet.deviceId} - Volatile Gas value is not in healthy range'
//       //   });
//       // }
//       // if (carbonMonoxide > 1000 || carbonMonoxide < 500) {
//       //   newNotifications.add({
//       //     'time': formattedTime,
//       //     'message':
//       //         'Helmet ID: ${helmet.deviceId} - Carbon Monoxide value is not in healthy range'
//       //   });
//       // }
//       // if (nitrogenDioxide > 1000 || nitrogenDioxide < 500) {
//       //   newNotifications.add({
//       //     'time': formattedTime,
//       //     'message':
//       //         'Helmet ID: ${helmet.deviceId} - Nitrogen Dioxide value is not in healthy range'
//       //   });
//       // }
//       // if (alcohol > 1000 || alcohol < 500) {
//       //   newNotifications.add({
//       //     'time': formattedTime,
//       //     'message':
//       //         'Helmet ID: ${helmet.deviceId} - Alcohol value is not in healthy range'
//       //   });
//       // }

//       String overallHealth = 'Good';
//       if (thresholdCount >= 2) {
//         overallHealth = 'Critical';
//       } else if (thresholdCount == 1) {
//         overallHealth = 'Moderate';
//       }
//     }

//     setState(() {
//       // helmet.overallHealth = overallHealth;
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

//   void _resetNotificationCount() {
//     setState(() {
//       notificationManager.clearNotifications();
//     });
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
//                 'Smart Helmet Dashboard',
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       right:
//                           20), // Adjust this value to move the icon to the left
//                   child: Row(
//                     children: [
//                       Stack(
//                         children: [
//                           PopupMenuButton<String>(
//                             onSelected: (value) {
//                               setState(() {
//                                 _resetNotificationCount(); // Clear notifications and reset the count
//                               });
//                             },
//                             onCanceled: () {
//                               setState(() {
//                                 _resetNotificationCount(); // Clear notifications and reset the count
//                               });
//                             },
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
// }

// Future<void> _signOut() async {
//   try {
//     await Amplify.Auth.signOut();
//   } on AuthException catch (e) {
//     print('Error signing out: $e');
//   }
// }

// void _logout(BuildContext context) async {
//   await _signOut();
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('isLoggedIn', false);

//   final screenWidth = MediaQuery.of(context).size.width;
//   if (screenWidth > 600) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => LoginWebPage()),
//       (route) => false,
//     );
//   } else {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => LoginMobilePage()),
//       (route) => false,
//     );
//   }
// }
// // }

// class CustomDrawer extends StatefulWidget {
//   @override
//   _CustomDrawerState createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

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
//           SizedBox(
//             height: 20,
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
//                 ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text('User Management',
//                       style: TextStyle(color: Color(0xffc3378a5))),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => UserPage()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.crisis_alert),
//                   title: Text('Alarms',
//                       style: TextStyle(color: Color(0xffc3378a5))),
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AlarmsPage()),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   width: 120,
//                   height: 70,
//                   child: ListTile(
//                     title: Image.asset(
//                       'assets/Images/company.png', // Replace with yCompany logo
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: FadeTransition(
//                     opacity: _opacityAnimation,
//                     child: Image.asset(
//                       'assets/Images/helmetmain.png',
//                       width: 250,
//                       height: 180,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WebStrip extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 55, // Adjust the height as needed
//       color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
//     );
//   }
// }

// class MobileStrip extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100, // Adjust the height as needed
//       // color: Color(0xffc3378a5),
//       color: Color.fromARGB(251, 25, 87, 128), // The color of the strip
//     );
//   }
// }

// class WebDashboardContent extends StatefulWidget {
//   final List<SmartHelmet> smartHelmets;

//   WebDashboardContent({required this.smartHelmets});

//   @override
//   _WebDashboardContentState createState() => _WebDashboardContentState();
// }

// class _WebDashboardContentState extends State<WebDashboardContent> {
//   @override
//   Widget build(BuildContext context) {

//     // //
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: Image.asset(
//             'assets/Images/commedianew.png', // Update the path to your logo asset
//             width: 200, // Adjust the width as needed
//             height: 100, // Adjust the height as needed
//           ),
//         ),
//         Center(
//           child: Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(left: 10, right: 10, bottom: 190, top: 70),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         border: TableBorder.all(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         columnSpacing: 40,
//                         headingRowColor: MaterialStateColor.resolveWith(
//                           (states) => Color.fromARGB(251, 25, 87, 128),
//                         ),
//                         columns: [
//                           DataColumn(
//                               label: Center(
//                                   child: Center(
//                             child: Text('        ID',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600)),
//                           ))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('User',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('           Time',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('Heart Rate',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('Environment\nTemperature',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('       User\nTemperature',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('Volatile\n   Gas',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('  Carbon\nMonoxide',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('Nitrogen\n Dioxide',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('  Ethyl\nAlcohol',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                           DataColumn(
//                               label: Center(
//                                   child: Text('Overall\n Health',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600)))),
//                         ],
//                         rows: widget.smartHelmets.map((helmet)
//                             // rows: combinedData.map((helmet)
//                             {
//                           return DataRow(
//                             cells: [
//                               DataCell(Center(child: Text(helmet.deviceId))),
//                               DataCell(Center(child: Text("User_1"))),
//                               DataCell(
//                                   Center(child: Text('${helmet.datetime} '))),
//                               DataCell(
//                                   Center(child: Text(helmet.hrt.toString()))),
//                               DataCell(
//                                   Center(child: Text('${helmet.envTemp}°C'))),
//                               DataCell(
//                                   Center(child: Text('${helmet.objTemp}°C'))),
//                               DataCell(Center(
//                                   child: Text('${helmet.volatileGas} ppb'))),
//                               DataCell(Center(
//                                   child: Text('${helmet.carbonMonoxide} ppm'))),
//                               DataCell(Center(
//                                   child:
//                                       Text('${helmet.nitrogenDioxide} ppm'))),
//                               DataCell(
//                                   Center(child: Text('${helmet.alcohol} ppm'))),
//                               DataCell(
//                                   Center(child: Text(helmet.overallHealth))),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 20, bottom: 50),
//               child: Container(
//                 width: 230,
//                 height: 170,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(width: 1, color: Colors.red)),
//                 child: const Column(
//                   children: [
//                     Text(
//                       "Wellness Range",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Heart Rate : 50 - 70",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Env Temp :   20 - 45 ",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "User Temp : 35 - 38 ",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Volatile Gas : 1000 - 5000 ppb",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Carbon Monoxide : 500 - 1000 ppm",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Nitrogen Dioxide : 500 - 1000 ppm",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Alcohol : 500 - 1000 ppm",
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             padding: EdgeInsets.all(8),
//             color: Colors.grey[200],
//             child: Center(
//               child: Text(
//                 '\u00a9 Copyright 2024 - Commedia All Rights Reserved',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MobileDashboardContent extends StatelessWidget {
//   final List<SmartHelmet> smartHelmets;

//   MobileDashboardContent({required this.smartHelmets});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: smartHelmets.map((helmet) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Color(0xffc40506), width: 2.0),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               margin: EdgeInsets.only(bottom: 8.0),
//               child: Card(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 elevation: 0,
//                 child: ListTile(
//                   title: Text(
//                     'Helmet ID: ${helmet.deviceId}',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Heart Rate: ${helmet.hrt}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500, color: Colors.black),
//                       ),
//                       Text(
//                         'Temperature: ${helmet.envTemp}°C',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500, color: Colors.black),
//                       ),
//                       Text(
//                         'Overall Health: Good',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

//above code is old dashboard that we dispplayed at chromaflow//

// approved by amey//

import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:smarthelmet/alarms.dart';
import 'package:smarthelmet/api_service.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:smarthelmet/fault.dart';
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:smarthelmet/reports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthelmet/user_management.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<SmartHelmet> smartHelmets = [];
  Timer? _timer;
  bool isSidebarExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _startFetchingData();
  }

  void _startFetchingData() {
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    try {
      List<SmartHelmet> fetchedData = await ApiService.fetchSmartHelmets();
      setState(() {
        smartHelmets = fetchedData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void toggleSidebar() {
    setState(() {
      isSidebarExpanded = !isSidebarExpanded;
    });
  }

  void _collapseSidebar() {
    if (isSidebarExpanded) {
      setState(() {
        isSidebarExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content area
          GestureDetector(
            onTap: _collapseSidebar,
            child: Container(
              color: Color(0xffFAFBFF),
              child: smartHelmets.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : kIsWeb
                      ? WebDashboardContent(
                          smartHelmets: smartHelmets,
                          isSidebarExpanded: isSidebarExpanded,
                          toggleSidebar: toggleSidebar,
                        )
                      : MobileDashboardContent(
                          smartHelmets: smartHelmets,
                          isSidebarExpanded: isSidebarExpanded,
                          toggleSidebar: toggleSidebar,
                        ),
            ),
          ),
          // Minimized sidebar
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: 60.0,
              color: Colors.white,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: toggleSidebar,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.dashboard,
                      size: 30,
                    ),
                    onPressed: () => _navigateTo(context, DashboardPage()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.warning,
                      size: 30,
                    ),
                    onPressed: () => _navigateTo(context, FaultPage()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.data_usage_rounded,
                      size: 30,
                    ),
                    onPressed: () => _navigateTo(context, Reportpage()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 30,
                    ),
                    onPressed: () => _navigateTo(context, Usermanagementpage()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.crisis_alert,
                      size: 30,
                    ),
                    onPressed: () => _navigateTo(context, AlarmPage()),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: 40,
                      height: 43,
                      child: Image.asset('assets/Images/helmeticon.png'))
                ],
              ),
            ),
          ),
          // Expanded sidebar
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isSidebarExpanded ? 0 : -200,
            top: 0,
            bottom: 0,
            child: CustomSidebar(
              isExpanded: isSidebarExpanded,
              toggleSidebar: toggleSidebar,
              onNavigate: _navigateTo,
            ),
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

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class CustomSidebar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback toggleSidebar;
  final void Function(BuildContext, Widget) onNavigate;

  CustomSidebar({
    required this.isExpanded,
    required this.toggleSidebar,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      child: Container(
        width: isExpanded ? 250.0 : 0.0,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            if (isExpanded)
              Container(
                height: 90,
                child: Image.asset(
                  'assets/Images/commedianew.png',
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SidebarItem(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    isExpanded: isExpanded,
                    onTap: () => onNavigate(context, DashboardPage()),
                  ),
                  SidebarItem(
                    icon: Icons.warning,
                    label: 'Fault Management',
                    isExpanded: isExpanded,
                    onTap: () => onNavigate(context, FaultPage()),
                  ),
                  SidebarItem(
                    icon: Icons.data_usage_rounded,
                    label: 'Reports',
                    isExpanded: isExpanded,
                    onTap: () => onNavigate(context, Reportpage()),
                  ),
                  SidebarItem(
                    icon: Icons.person,
                    label: 'User Management',
                    isExpanded: isExpanded,
                    onTap: () => onNavigate(context, Usermanagementpage()),
                  ),
                  SidebarItem(
                    icon: Icons.crisis_alert,
                    label: 'Alarms',
                    isExpanded: isExpanded,
                    onTap: () => onNavigate(context, AlarmPage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isExpanded;
  final VoidCallback onTap;

  SidebarItem({
    required this.icon,
    required this.label,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: isExpanded ? Text(label) : null,
      onTap: onTap,
    );
  }
}

class Notification {
  final String message;
  final DateTime timestamp;

  // Notification(this.message) : timestamp = DateTime.now();
  Notification(this.message, {DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class WebDashboardContent extends StatefulWidget {
  final List<SmartHelmet> smartHelmets;
  final bool isSidebarExpanded;
  final VoidCallback toggleSidebar;

  WebDashboardContent({
    required this.smartHelmets,
    required this.isSidebarExpanded,
    required this.toggleSidebar,
  });

  @override
  State<WebDashboardContent> createState() => _WebDashboardContentState();
}

class _WebDashboardContentState extends State<WebDashboardContent> {
  String dropdownValue = 'All';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // List<SmartHelmet> _helmets = [];
  // List<SmartHelmet> _filteredHelmets = [];
  // Timer? _dataFetchTimer;
  // Timer? _monitoringTimer;
  // List<Notification> notifications = [];

  // // Track when a value first exceeded the threshold

  // Map<String, DateTime> thresholdBreaches = {};

  // // Threshold values
  // final int heartRateMin = 50;
  // final int heartRateMax = 60;
  // final int envTempMin = 20;
  // final int envTempMax = 45;
  // final int userTempMin = 20;
  // final int userTempMax = 38;
  // final int volatileGasMin = 300;
  // final int volatileGasMax = 700;
  // final int carbonMonoxideMin = 50;
  // final int carbonMonoxideMax = 300;
  // final int nitrogenDioxideMin = 300;
  // final int nitrogenDioxideMax = 500;
  // final int alcoholMin = 400;
  // final int alcoholMax = 700;

  // Future<void> _saveNotifications() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> savedNotifications = notifications
  //       .map((notification) =>
  //           "${notification.message}||${notification.timestamp.toIso8601String()}")
  //       .toList();
  //   await prefs.setStringList('notifications', savedNotifications);
  // }

  // Future<void> _loadNotifications() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String>? savedNotifications = prefs.getStringList('notifications');
  //   if (savedNotifications != null) {
  //     setState(() {
  //       notifications = savedNotifications.map((notificationString) {
  //         var parts = notificationString.split('||');
  //         return Notification(
  //           parts[0],
  //           timestamp: DateTime.parse(parts[1]),
  //         );
  //       }).toList();
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadNotifications();
  //   _fetchHelmets();
  //   _startFetchingData();
  //   _startMonitoring();
  // }

  // void _startFetchingData() {
  //   _dataFetchTimer = Timer.periodic(Duration(seconds: 6), (timer) {
  //     _fetchHelmets();
  //   });
  // }

  // void _startMonitoring() {
  //   _monitoringTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     _monitorSensorValues();
  //   });
  // }

  // Future<void> _fetchHelmets() async {
  //   try {
  //     List<SmartHelmet> fetchedHelmets = await ApiService.fetchSmartHelmets();
  //     setState(() {
  //       _helmets = fetchedHelmets;
  //       _filterHelmets();
  //     });
  //   } catch (e) {
  //     print('Error fetching helmets: $e');
  //   }
  // }

  // void _filterHelmets() {
  //   setState(() {
  //     _filteredHelmets = _helmets.where((helmet) {
  //       final matchesSearch = helmet.deviceId.contains(_searchQuery) ||
  //           helmet.datetime.contains(_searchQuery);
  //       final matchesDropdown =
  //           dropdownValue == 'All' || helmet.overallHealth == dropdownValue;
  //       return matchesSearch && matchesDropdown;
  //     }).toList();
  //   });
  // }

  // void _monitorSensorValues() {
  //   DateTime now = DateTime.now();

  //   for (var helmet in _helmets) {
  //     _checkSensor(helmet.deviceId, "Heart Rate", int.tryParse(helmet.hrt),
  //         heartRateMin, heartRateMax, now);
  //     _checkSensor(helmet.deviceId, "Environment Temperature", helmet.envTemp,
  //         envTempMin, envTempMax, now);
  //     _checkSensor(helmet.deviceId, "User Temperature", helmet.objTemp,
  //         userTempMin, userTempMax, now);
  //     _checkSensor(helmet.deviceId, "Volatile Gas", helmet.volatileGas,
  //         volatileGasMin, volatileGasMax, now);
  //     _checkSensor(helmet.deviceId, "Carbon Monoxide", helmet.carbonMonoxide,
  //         carbonMonoxideMin, carbonMonoxideMax, now);
  //     _checkSensor(helmet.deviceId, "Nitrogen Dioxide", helmet.nitrogenDioxide,
  //         nitrogenDioxideMin, nitrogenDioxideMax, now);
  //     _checkSensor(helmet.deviceId, "Alcohol", helmet.alcohol, alcoholMin,
  //         alcoholMax, now);
  //   }

  //   // Remove expired notifications
  //   notifications.removeWhere(
  //       (notification) => now.difference(notification.timestamp).inHours >= 12);
  // }

  // void _checkSensor(String deviceId, String sensorName, num? value, num min,
  //     num max, DateTime now,
  //     [bool ignoreZero = false]) {
  //   if (value == null) return;
  //   if (ignoreZero && value == 0) return;

  //   String key = "$deviceId-$sensorName";

  //   // Monitor values and trigger notification if out of threshold
  //   if (value < min || value > max) {
  //     // Log the breach time
  //     thresholdBreaches[key] = now;

  //     // Trigger notification for the breach
  //     if (!notifications.any((notification) =>
  //         notification.message ==
  //         "Helmet Id: $deviceId, $sensorName Value is out of threshold")) {
  //       setState(() {
  //         notifications.add(Notification(
  //             "Helmet Id: $deviceId, $sensorName Value is out of threshold"));
  //       });
  //       _saveNotifications(); // Save notifications after adding
  //     }
  //   } else {
  //     // If the value returns to normal, clear the breach record
  //     thresholdBreaches.remove(key);
  //   }
  // }

  // @override
  // void dispose() {
  //   _dataFetchTimer?.cancel();
  //   _monitoringTimer?.cancel();
  //   _searchController.dispose();
  //   super.dispose();
  // }

  List<SmartHelmet> _helmets = [];
  List<SmartHelmet> _filteredHelmets = [];
  Timer? _dataFetchTimer;
  Timer? _monitoringTimer;
  List<Notification> notifications = [];

  // Track when a value first exceeded the threshold
  Map<String, DateTime> thresholdBreaches = {};

  // Threshold values
  final int heartRateMin = 50;
  final int heartRateMax = 120;
  final int envTempMin = 20;
  final int envTempMax = 45;
  final int userTempMin = 35;
  final int userTempMax = 38;
  final int volatileGasMin = 300;
  final int volatileGasMax = 700;
  final int carbonMonoxideMin = 50;
  final int carbonMonoxideMax = 300;
  final int nitrogenDioxideMin = 300;
  final int nitrogenDioxideMax = 500;
  final int alcoholMin = 600;
  final int alcoholMax = 700;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _fetchHelmets();
    _startFetchingData();
    _startMonitoring();
  }

  void _startFetchingData() {
    _dataFetchTimer = Timer.periodic(Duration(seconds: 6), (timer) {
      _fetchHelmets();
    });
  }

  void _startMonitoring() {
    _monitoringTimer = Timer.periodic(Duration(seconds: 32), (timer) {
      _monitorSensorValues();
    });
  }

  Future<void> _fetchHelmets() async {
    try {
      List<SmartHelmet> fetchedHelmets = await ApiService.fetchSmartHelmets();
      setState(() {
        _helmets = fetchedHelmets;
        _filterHelmets();
      });
    } catch (e) {
      print('Error fetching helmets: $e');
    }
  }

  void _filterHelmets() {
    setState(() {
      _filteredHelmets = _helmets.where((helmet) {
        final matchesSearch = helmet.deviceId.contains(_searchQuery) ||
            helmet.datetime.contains(_searchQuery);
        final matchesDropdown =
            dropdownValue == 'All' || helmet.overallHealth == dropdownValue;
        return matchesSearch && matchesDropdown;
      }).toList();
    });
  }

  void _monitorSensorValues() {
    DateTime now = DateTime.now();

    for (var helmet in _helmets) {
      _checkSensor(helmet.deviceId, "Heart Rate", int.tryParse(helmet.hrt),
          heartRateMin, heartRateMax, now);
      _checkSensor(helmet.deviceId, "Environment Temperature", helmet.envTemp,
          envTempMin, envTempMax, now);
      _checkSensor(helmet.deviceId, "User Temperature", helmet.objTemp,
          userTempMin, userTempMax, now);
      _checkSensor(helmet.deviceId, "Volatile Gas", helmet.volatileGas,
          volatileGasMin, volatileGasMax, now);
      _checkSensor(helmet.deviceId, "Carbon Monoxide", helmet.carbonMonoxide,
          carbonMonoxideMin, carbonMonoxideMax, now);
      _checkSensor(helmet.deviceId, "Nitrogen Dioxide", helmet.nitrogenDioxide,
          nitrogenDioxideMin, nitrogenDioxideMax, now);
      _checkSensor(helmet.deviceId, "Alcohol", helmet.alcohol, alcoholMin,
          alcoholMax, now);
    }

    // Remove expired notifications
    notifications.removeWhere(
        (notification) => now.difference(notification.timestamp).inHours >= 24);
  }

  void _checkSensor(String deviceId, String sensorName, num? value, num min,
      num max, DateTime now,
      [bool ignoreZero = false]) {
    if (value == null) return;
    if (ignoreZero && value == 0) return;

    String key = "$deviceId-$sensorName";

    // Monitor values and trigger notification if out of threshold
    if (value < min || value > max) {
      // Log the breach time
      if (!thresholdBreaches.containsKey(key)) {
        thresholdBreaches[key] = now;
      } else if (now.difference(thresholdBreaches[key]!).inSeconds >= 30) {
        if (!notifications.any((notification) =>
            notification.message ==
            "Helmet Id: $deviceId, $sensorName Value is out of threshold")) {
          setState(() {
            notifications.add(Notification(
                "Helmet Id: $deviceId, $sensorName Value is out of threshold"));
          });
          _saveNotifications(); // Save notifications after adding
        }
        thresholdBreaches.remove(key); // Reset the timer after notifying
      }
    } else {
      // If the value returns to normal, clear the breach record
      thresholdBreaches.remove(key);
    }
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedNotifications = notifications
        .map((notification) =>
            "${notification.message}||${notification.timestamp.toIso8601String()}")
        .toList();
    await prefs.setStringList('notifications', savedNotifications);
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedNotifications = prefs.getStringList('notifications');
    if (savedNotifications != null) {
      setState(() {
        notifications = savedNotifications.map((notificationString) {
          var parts = notificationString.split('||');
          return Notification(
            parts[0],
            timestamp: DateTime.parse(parts[1]),
          );
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    _dataFetchTimer?.cancel();
    _monitoringTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffEEF7FD).withOpacity(0.5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset('assets/Images/commedianew.png',
                      fit: BoxFit.cover),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<String>(
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
                              color: Color(0xffc40506),
                            ),
                          ),
                        ),
                      ];
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/Images/usericon.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 80),
                    child: Container(
                      width: 1045,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffe8e8e8),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                            BoxShadow(
                                color: Colors.white, offset: Offset(-5, 0)),
                            BoxShadow(color: Colors.white, offset: Offset(5, 0))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE2FDFF).withOpacity(0.6),
                                ),
                                child:
                                    Image.asset('assets/Images/totalusers.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, left: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Total Users",
                                      style: TextStyle(
                                          color: Color(0xffACACAC),
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE2FDFF).withOpacity(0.6),
                                ),
                                child: Image.asset(
                                    'assets/Images/activeusers.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, left: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Active Users",
                                      style: TextStyle(
                                          color: Color(0xffACACAC),
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffE2FDFF).withOpacity(0.6),
                                  ),
                                  child:
                                      Image.asset('assets/Images/active.png')),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, left: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      "Active Helmets",
                                      style: TextStyle(
                                          color: Color(0xffACACAC),
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 80),
                    child: Container(
                      width: 1045,
                      height: 440,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffe8e8e8),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                            BoxShadow(
                                color: Colors.white, offset: Offset(-5, 0)),
                            BoxShadow(color: Colors.white, offset: Offset(5, 0))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 2),
                                child: Text(
                                  "All Users",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                              Spacer(),

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        _searchQuery = value;
                                        _filterHelmets();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      prefixIcon: Icon(Icons.search),
                                      filled:
                                          true, // Ensures that the background color is applied
                                      fillColor: Color(0xffF9FBFF),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              // Sort by drop down//

                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: DropdownButtonFormField<String>(
                                    value: dropdownValue == 'All'
                                        ? null
                                        : dropdownValue,
                                    hint: Text(
                                      'Sort By',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF9FBFF),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        _filterHelmets();
                                      });
                                    },
                                    dropdownColor: Color(0xffF9FBFF),
                                    items: <String>[
                                      'All',
                                      'Good',
                                      'Critical',
                                      'Moderate'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // user table//

                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          minWidth: constraints.maxWidth),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: DataTable(
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                '          ID',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            DataColumn(
                                                label: Text(
                                              ' User\nname',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '    Heart\nRate (BPM)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '   Environment\nTemperature (°C)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '       User\nTemperature (°C)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '    Volatile\n  Gas (PPB)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '      Carbon\nMonoxide (PPM)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              '     Nitrogen\n Dioxide (PPM)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'Alcohol (PPM)',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'Overall\n Health',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],

                                          // rows: _filteredUsers.map((user)
                                          rows: _filteredHelmets.map((helmet) {
                                            return DataRow(cells: [
                                              DataCell(Text("         " +
                                                  helmet.deviceId)),
                                              DataCell(Text("User1")),
                                              DataCell(
                                                  Text("      " + helmet.hrt)),
                                              DataCell(Text("          " +
                                                  helmet.envTemp.toString())),
                                              DataCell(Text("        " +
                                                  helmet.objTemp.toString())),
                                              DataCell(Text("       " +
                                                  helmet.volatileGas
                                                      .toString())),
                                              DataCell(Text("         " +
                                                  helmet.carbonMonoxide
                                                      .toString())),
                                              DataCell(Text("         " +
                                                  helmet.nitrogenDioxide
                                                      .toString())),
                                              DataCell(Text("       " +
                                                  helmet.alcohol.toString())),
                                              DataCell(Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: helmet.overallHealth ==
                                                          'Good'
                                                      ? Colors.green
                                                      : helmet.overallHealth ==
                                                              'Moderate'
                                                          ? Colors.yellow
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  helmet.overallHealth,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                            ]);
                                          }).toList(),
                                          horizontalMargin: 0,
                                          dividerThickness: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //Recent Warnings container//

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 10,
                    ),
                    child: Container(
                      width: 210,
                      height: 340,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffe8e8e8),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                            BoxShadow(
                                color: Colors.white, offset: Offset(-5, 0)),
                            BoxShadow(color: Colors.white, offset: Offset(5, 0))
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "Recent Warnings",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Divider(
                            height: 1,
                            indent: 20,
                            endIndent: 20,
                            color: const Color.fromARGB(255, 114, 113, 113),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Notification list
                          Expanded(
                            child: ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                String formattedTimestamp =
                                    DateFormat('dd/MM/yyyy hh:mm:ss a')
                                        .format(notification.timestamp);

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Container(
                                    width: 225,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 233, 240, 252)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, bottom: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notification.message,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Timestamp: $formattedTimestamp',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: const Color.fromARGB(
                                                    255, 92, 92, 92)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 10,
                    ),
                    child: Container(
                      width: 210,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffe8e8e8),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                            BoxShadow(
                                color: Colors.white, offset: Offset(-5, 0)),
                            BoxShadow(color: Colors.white, offset: Offset(5, 0))
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Wellness Range",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Divider(
                            height: 1,
                            indent: 30,
                            endIndent: 30,
                            color: const Color.fromARGB(255, 114, 113, 113),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Text(
                              "Heart Rate : 50 - 120 BPM",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff000000).withOpacity(0.7)),
                            ),
                          ),
                          Text(
                            "Environment Temp : 30 - 45 °C",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff000000).withOpacity(0.7)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 49),
                            child: Text(
                              "User Temp : 35 - 38 °C",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff000000).withOpacity(0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              "Volatile Gas : 50 - 70 PPB",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff000000).withOpacity(0.7)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Carbon Monoxide : 50 - 70 PPM",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff000000).withOpacity(0.7)),
                            ),
                          ),
                          Text(
                            "Nitrogen Dioxide : 50 - 70 PPM",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff000000).withOpacity(0.7)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 53),
                            child: Text(
                              "Alcohol : 50 - 70 PPM",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff000000).withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

void _logout(BuildContext context) async {
  await Amplify.Auth.signOut();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginWebPage()),
    (route) => false,
  );
}

class MobileDashboardContent extends StatelessWidget {
  final List<SmartHelmet> smartHelmets;
  final bool isSidebarExpanded;
  final VoidCallback toggleSidebar;

  MobileDashboardContent({
    required this.smartHelmets,
    required this.isSidebarExpanded,
    required this.toggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: toggleSidebar,
            ),
            Spacer(),
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
              child: SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.asset("assets/Images/usericon.png")),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
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
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              'Temperature: ${helmet.envTemp}°C',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              'Overall Health: Good',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    await Amplify.Auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginMobilePage()),
      (route) => false,
    );
  }
}
