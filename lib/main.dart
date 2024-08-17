// //mod 2  code to signuo new user //
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_authenticator/amplify_authenticator.dart';
// import 'package:flutter/material.dart';
// import 'package:smarthelmet/amplifyconfig.dart';

// // import 'amplifyconfiguration.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }

//   Future<void> _configureAmplify() async {
//     try {
//       final auth = AmplifyAuthCognito();
//       await Amplify.addPlugin(auth);

//       // call Amplify.configure to use the initialized categories in your app
//       await Amplify.configure(amplifyconfig);
//     } on Exception catch (e) {
//       safePrint('An error occurred configuring Amplify: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Authenticator(
//       signUpForm: SignUpForm.custom(
//         fields: [
//           SignUpFormField.name(required: true),
//           SignUpFormField.email(required: true),
//           SignUpFormField.password(),
//           SignUpFormField.passwordConfirmation(),
//         ],
//       ),
//       child: MaterialApp(
//         builder: Authenticator.builder(),
//         home: const Scaffold(
//           body: Center(
//             child: Text('You are logged in!'),
//           ),
//         ),
//       ),
//     );
//   }
// }

//working main file //

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smarthelmet/Dashboard.dart';
import 'package:smarthelmet/amplifyconfig.dart';
import 'login_web.dart';
import 'login_mobile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  bool _isLoggedIn = false;

  //
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();
    await _checkLoginStatus();
  }

  //

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _isAmplifyConfigured = true;
      });
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isAmplifyConfigured
          ? (_isLoggedIn
              ? DashboardPage()
              // ? FaultPage()
              : (kIsWeb ? LoginWebPage() : LoginMobilePage()))
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}


