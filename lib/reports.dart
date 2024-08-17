import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:smarthelmet/Dashboard.dart';
import 'package:smarthelmet/alarms.dart';
import 'package:smarthelmet/api_service.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:smarthelmet/fault.dart';
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthelmet/user_management.dart';
import 'package:intl/intl.dart';

class Reportpage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<Reportpage> {
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
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
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
                    height: 30,
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
  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  List<SmartHelmet> _helmets = [];
  List<SmartHelmet> _filteredHelmets = [];
  Timer? _timer;
  List<Notification> notifications = [];

  Map<String, DateTime> thresholdBreaches = {};

  final int heartRateMin = 50;
  final int heartRateMax = 60;
  final int envTempMin = 20;
  final int envTempMax = 45;
  final int userTempMin = 20;
  final int userTempMax = 38;
  final int volatileGasMin = 300;
  final int volatileGasMax = 700;
  final int carbonMonoxideMin = 50;
  final int carbonMonoxideMax = 300;
  final int nitrogenDioxideMin = 300;
  final int nitrogenDioxideMax = 500;
  final int alcoholMin = 400;
  final int alcoholMax = 700;

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
  void initState() {
    super.initState();
    _loadNotifications();
    _fetchHelmets();
    _startFetchingData();
  }

  void _startFetchingData() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      _fetchHelmets();
    });
  }

  Future<void> _fetchHelmets() async {
    try {
      List<SmartHelmet> fetchedHelmets = await ApiService.fetchSmartHelmets();
      setState(() {
        _helmets = fetchedHelmets;
        _checkForNotifications();
      });
    } catch (e) {
      print('Error fetching helmets: $e');
    }
  }

  void _checkForNotifications() {
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

    if (value < min || value > max) {
      if (!thresholdBreaches.containsKey(key)) {
        thresholdBreaches[key] = now;
      } else if (now.difference(thresholdBreaches[key]!).inMinutes >= 1) {
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
      thresholdBreaches.remove(key);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();

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
                    padding: const EdgeInsets.only(top: 10, left: 87),
                    child: Container(
                      width: 1020,
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
                    padding: const EdgeInsets.only(top: 10, left: 84),
                    child: Container(
                      width: 1020,
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
                          BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                          BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 10),
                                child: Text(
                                  "Reports",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 80),
                          SizedBox(
                            width: 300,
                            height: 40,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Select Helmet ID",
                                filled: true,
                                fillColor: Color(0xffF9FBFF),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              items: [
                                DropdownMenuItem(
                                    value: "ID",
                                    child: Text("Select Helmet Id")),
                                DropdownMenuItem(
                                    value: "01", child: Text("01")),
                                DropdownMenuItem(
                                    value: "02", child: Text("02")),
                                DropdownMenuItem(
                                    value: "03", child: Text("03")),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(height: 30),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the date fields
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 40,
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "From Date",
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      controller: TextEditingController(
                                        text: selectedFromDate == null
                                            ? ''
                                            : DateFormat('yyyy-MM-dd')
                                                .format(selectedFromDate!),
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: selectedFromDate ??
                                              DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null &&
                                            pickedDate != selectedFromDate)
                                          setState(() {
                                            selectedFromDate = pickedDate;
                                          });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  SizedBox(
                                    width: 140,
                                    height: 40,
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "To Date",
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      controller: TextEditingController(
                                        text: selectedToDate == null
                                            ? ''
                                            : DateFormat('yyyy-MM-dd')
                                                .format(selectedToDate!),
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate:
                                              selectedToDate ?? DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null &&
                                            pickedDate != selectedToDate)
                                          setState(() {
                                            selectedToDate = pickedDate;
                                          });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Row(
                                            children: [
                                              Icon(Icons.file_download,
                                                  color: Colors.blue),
                                              SizedBox(width: 10),
                                              Text("Download Report"),
                                            ],
                                          ),
                                          content: Text(
                                              "Report will get downloaded in the system."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK",
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xffc40506))),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xffc40506)),
                                  ),
                                  child: Text(
                                    "Download",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
                                 String formattedTimestamp = DateFormat('dd/MM/yyyy hh:mm:ss a').format(notification.timestamp);
      
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
                      color: const Color.fromARGB(255, 92, 92, 92)),
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
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Container(
                      width: 220,
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
                              "Alochol : 50 - 70 PPM",
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
