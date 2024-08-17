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
import 'package:smarthelmet/login_mobile.dart';
import 'package:smarthelmet/login_web.dart';
import 'package:smarthelmet/reports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthelmet/user_management.dart';
import 'package:intl/intl.dart';

class FaultPage extends StatefulWidget {
  @override
  _FaultPageState createState() => _FaultPageState();
}

class _FaultPageState extends State<FaultPage> {
  // List<SmartHelmet> smartHelmets = [];
  List<SmartHelmetWrapper> smartHelmetWrappers = [];
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

  // Future<void> _fetchData() async {
  //   try {
  //     List<SmartHelmet> fetchedData = await ApiService.fetchSmartHelmets();
  //     setState(() {
  //       smartHelmets = fetchedData;
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  Future<void> _fetchData() async {
    try {
      List<SmartHelmet> fetchedData = await ApiService.fetchSmartHelmets();
      setState(() {
        smartHelmetWrappers =
            fetchedData.map((helmet) => SmartHelmetWrapper(helmet)).toList();
        _updateSensorStatuses();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _updateSensorStatuses() {
    for (var wrapper in smartHelmetWrappers) {
      wrapper.updateSensors();
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         // Main content area
  //         GestureDetector(
  //           onTap: _collapseSidebar,
  //           child: Container(
  //             color: Color(0xffFAFBFF),
  //             child: smartHelmets.isEmpty
  //                 ? Center(child: CircularProgressIndicator())
  //                 : kIsWeb
  //                     ? WebDashboardContent(
  //                         smartHelmets: smartHelmets,
  //                         isSidebarExpanded: isSidebarExpanded,
  //                         toggleSidebar: toggleSidebar,
  //                       )
  //                     : MobileDashboardContent(
  //                         smartHelmets: smartHelmets,
  //                         isSidebarExpanded: isSidebarExpanded,
  //                         toggleSidebar: toggleSidebar,
  //                       ),
  //           ),
  //         ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _collapseSidebar,
            child: Container(
              color: Color(0xffFAFBFF),
              child: smartHelmetWrappers.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : WebDashboardContent(
                      smartHelmetWrappers: smartHelmetWrappers,
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

class Sensor {
  num? value;
  DateTime lastChanged;

  Sensor(this.value) : lastChanged = DateTime.now();

  void updateValue(num? newValue) {
    if (newValue != value) {
      value = newValue;
      lastChanged = DateTime.now();
    }
  }

  bool isActive() {
    return DateTime.now().difference(lastChanged).inMinutes < 1;
  }
}

class SmartHelmetWrapper {
  final SmartHelmet helmet;
  final Sensor heartRate;
  final Sensor envTemp;
  final Sensor objTemp;
  final Sensor volatileGas;
  final Sensor carbonMonoxide;
  final Sensor nitrogenDioxide;
  final Sensor alcohol;

  SmartHelmetWrapper(this.helmet)
      : heartRate = Sensor(int.tryParse(helmet.hrt) ?? 0),
        envTemp = Sensor(helmet.envTemp),
        objTemp = Sensor(helmet.objTemp),
        volatileGas = Sensor(helmet.volatileGas),
        carbonMonoxide = Sensor(helmet.carbonMonoxide),
        nitrogenDioxide = Sensor(helmet.nitrogenDioxide),
        alcohol = Sensor(helmet.alcohol);

  bool areSensorsActive() {
    return heartRate.isActive() &&
        envTemp.isActive() &&
        objTemp.isActive() &&
        volatileGas.isActive() &&
        carbonMonoxide.isActive() &&
        nitrogenDioxide.isActive() &&
        alcohol.isActive();
  }

  void updateSensors() {
    heartRate.updateValue(int.tryParse(helmet.hrt));
    envTemp.updateValue(helmet.envTemp);
    objTemp.updateValue(helmet.objTemp);
    volatileGas.updateValue(helmet.volatileGas);
    carbonMonoxide.updateValue(helmet.carbonMonoxide);
    nitrogenDioxide.updateValue(helmet.nitrogenDioxide);
    alcohol.updateValue(helmet.alcohol);
  }
}

class Notification {
  final String message;
  final DateTime timestamp;

  Notification(this.message, {DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class WebDashboardContent extends StatefulWidget {
  // final List<SmartHelmet> smartHelmets;
  final List<SmartHelmetWrapper> smartHelmetWrappers;
  final bool isSidebarExpanded;
  final VoidCallback toggleSidebar;

  WebDashboardContent({
    // required this.smartHelmets,
    required this.smartHelmetWrappers,
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

  List<SmartHelmet> _helmets = [];
  // List<SmartHelmet> _filteredHelmets = [];
  List<SmartHelmetWrapper> _filteredHelmets = [];
  Timer? _timer;
  List<Notification> notifications = [];

  // Track when a value first exceeded the threshold
  Map<String, DateTime> thresholdBreaches = {};

  // Threshold values
  final int heartRateMin = 60;
  final int heartRateMax = 120;
  final int envTempMin = 30;
  final int envTempMax = 45;
  final int userTempMin = 35;
  final int userTempMax = 38;
  final int volatileGasMin = 50;
  final int volatileGasMax = 70;
  final int carbonMonoxideMin = 50;
  final int carbonMonoxideMax = 70;
  final int nitrogenDioxideMin = 50;
  final int nitrogenDioxideMax = 70;
  final int alcoholMin = 50;
  final int alcoholMax = 70;

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
        _filterHelmets();
        _checkForNotifications();
      });
    } catch (e) {
      print('Error fetching helmets: $e');
    }
  }

  // void _filterHelmets() {
  //   setState(() {
  //     _filteredHelmets = _helmets.where((helmet) {
  //       final matchesSearch = helmet.deviceId.contains(_searchQuery);
  //       final helmetStatus = _calculateHelmetStatus(helmet);
  //       final matchesDropdown =
  //           dropdownValue == 'All' || dropdownValue == helmetStatus;
  //       return matchesSearch && matchesDropdown;
  //     }).toList();
  //   });
  // }

  void _filterHelmets() {
    setState(() {
      _filteredHelmets = widget.smartHelmetWrappers.where((wrapper) {
        final matchesSearch = wrapper.helmet.deviceId.contains(_searchQuery);
        final helmetStatus = wrapper.areSensorsActive() ? 'Active' : 'Inactive';
        final matchesDropdown =
            dropdownValue == 'All' || dropdownValue == helmetStatus;
        return matchesSearch && matchesDropdown;
      }).toList();
    });
  }

  void _checkForNotifications() {
    DateTime now = DateTime.now();

    for (var helmet in _helmets) {
      _checkSensor(helmet.deviceId, "Heart Rate", int.tryParse(helmet.hrt),
          heartRateMin, heartRateMax, now, true);
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
    _searchController.dispose();
    super.dispose();
  }

  bool isSensorActive(num? value, num min, num max) {
    if (value == null) return false;
    return value >= min && value <= max;
  }

  String _calculateHelmetStatus(SmartHelmet helmet) {
    int activeCount = 0;
    if (isSensorActive(int.tryParse(helmet.hrt), heartRateMin, heartRateMax))
      activeCount++;
    if (isSensorActive(helmet.envTemp, envTempMin, envTempMax)) activeCount++;
    if (isSensorActive(helmet.objTemp, userTempMin, userTempMax)) activeCount++;
    if (isSensorActive(helmet.volatileGas, volatileGasMin, volatileGasMax))
      activeCount++;
    if (isSensorActive(
        helmet.carbonMonoxide, carbonMonoxideMin, carbonMonoxideMax))
      activeCount++;
    if (isSensorActive(
        helmet.nitrogenDioxide, nitrogenDioxideMin, nitrogenDioxideMax))
      activeCount++;
    if (isSensorActive(helmet.alcohol, alcoholMin, alcoholMax)) activeCount++;
    return activeCount == 7 ? 'Active' : 'Inactive';
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
                                  "Helmet Status",
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: DropdownButtonFormField<String>(
                                    value: dropdownValue,
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
                                    items: <String>['All', 'Active', 'Inactive']
                                        .map<DropdownMenuItem<String>>(
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
                                              'Helmet Status',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                          // rows: _filteredHelmets.map((helmet) {
                                          //   return DataRow(cells: [
                                          //     DataCell(Text("         " +
                                          //         helmet.deviceId)),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 int.tryParse(
                                          //                     helmet.hrt),
                                          //                 heartRateMin,
                                          //                 heartRateMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   int.tryParse(
                                          //                       helmet.hrt),
                                          //                   heartRateMin,
                                          //                   heartRateMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet.envTemp,
                                          //                 envTempMin,
                                          //                 envTempMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet.envTemp,
                                          //                   envTempMin,
                                          //                   envTempMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet.objTemp,
                                          //                 userTempMin,
                                          //                 userTempMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet.objTemp,
                                          //                   userTempMin,
                                          //                   userTempMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet.volatileGas,
                                          //                 volatileGasMin,
                                          //                 volatileGasMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet.volatileGas,
                                          //                   volatileGasMin,
                                          //                   volatileGasMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet.carbonMonoxide,
                                          //                 carbonMonoxideMin,
                                          //                 carbonMonoxideMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet
                                          //                       .carbonMonoxide,
                                          //                   carbonMonoxideMin,
                                          //                   carbonMonoxideMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet
                                          //                     .nitrogenDioxide,
                                          //                 nitrogenDioxideMin,
                                          //                 nitrogenDioxideMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet
                                          //                       .nitrogenDioxide,
                                          //                   nitrogenDioxideMin,
                                          //                   nitrogenDioxideMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         isSensorActive(
                                          //                 helmet.alcohol,
                                          //                 alcoholMin,
                                          //                 alcoholMax)
                                          //             ? 'Active'
                                          //             : 'Inactive',
                                          //         style: TextStyle(
                                          //           color: isSensorActive(
                                          //                   helmet.alcohol,
                                          //                   alcoholMin,
                                          //                   alcoholMax)
                                          //               ? Colors.green
                                          //               : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //     DataCell(Center(
                                          //       child: Text(
                                          //         _calculateHelmetStatus(
                                          //             helmet),
                                          //         style: TextStyle(
                                          //           color:
                                          //               _calculateHelmetStatus(
                                          //                           helmet) ==
                                          //                       'Active'
                                          //                   ? Colors.green
                                          //                   : Colors.red,
                                          //         ),
                                          //       ),
                                          //     )),
                                          //   ]);
                                          // }).toList(),
                                          rows: _filteredHelmets.map((wrapper) {
                                            return DataRow(cells: [
                                              DataCell(Text(
                                                  wrapper.helmet.deviceId)),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.heartRate.isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper.heartRate
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.envTemp.isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper.envTemp
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.objTemp.isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper.objTemp
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.volatileGas.isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper.volatileGas
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.carbonMonoxide
                                                          .isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper
                                                            .carbonMonoxide
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.nitrogenDioxide
                                                          .isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper
                                                            .nitrogenDioxide
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.alcohol.isActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper.alcohol
                                                            .isActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  wrapper.areSensorsActive()
                                                      ? 'Active'
                                                      : 'Inactive',
                                                  style: TextStyle(
                                                    color: wrapper
                                                            .areSensorsActive()
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
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
