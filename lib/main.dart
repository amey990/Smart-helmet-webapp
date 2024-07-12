// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:smarthelmet/login_mobile.dart';
// import 'package:smarthelmet/login_web.dart';

// void main() async {
//   runApp(FlutterApp());
// }

// class FlutterApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "FlutterApp",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.orange),
//       // home: Loginpage()
//       home: kIsWeb ? LoginWebPage() : LoginMobilePage(),
//     );
//   }
// }

// //

// class DashBoardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(""),
//       ),
//     );
//   }
// }

// //mod 2//
// // import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// // import 'package:amplify_flutter/amplify_flutter.dart';
// // import 'package:amplify_authenticator/amplify_authenticator.dart';
// // import 'package:flutter/material.dart';

// // import 'amplifyconfiguration.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatefulWidget {
// //   const MyApp({super.key});

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     _configureAmplify();
// //   }

// //   Future<void> _configureAmplify() async {
// //     try {
// //       final auth = AmplifyAuthCognito();
// //       await Amplify.addPlugin(auth);

// //       // call Amplify.configure to use the initialized categories in your app
// //       await Amplify.configure(amplifyconfig);
// //     } on Exception catch (e) {
// //       safePrint('An error occurred configuring Amplify: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Authenticator(
// //       signUpForm: SignUpForm.custom(
// //         fields: [
// //           SignUpFormField.name(required: true),
// //           SignUpFormField.email(required: true),
// //           SignUpFormField.password(),
// //           SignUpFormField.passwordConfirmation(),
// //         ],
// //       ),
// //       child: MaterialApp(
// //         builder: Authenticator.builder(),
// //         home: const Scaffold(
// //           body: Center(
// //             child: Text('You are logged in!'),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

//mod2//

// import 'package:amplify_authenticator/amplify_authenticator.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:flutter/material.dart';

// import 'amplifyconfiguration.dart';

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
//       child: MaterialApp(
//         builder: Authenticator.builder(),
//         home: const Scaffold(
//           body: Center(
//             child: Text('You are logged in!'),
//           ),
//         ),
//       ),
//     );
//   }`
// }

//mod3//
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

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _checkLoginStatus();
  }

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
              : (kIsWeb ? LoginWebPage() : LoginMobilePage()))
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
