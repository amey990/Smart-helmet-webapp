// /// working login finalized by amey//

// import 'package:flutter/material.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:smarthelmet/Dashboard.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smarthelmet/amplifyconfig.dart'; // Ensure your Amplify config file is imported

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await _configureAmplify(); // Ensure Amplify is configured here
//   runApp(MyApp());
// }

// Future<void> _configureAmplify() async {
//   try {
//     await Amplify.addPlugins([AmplifyAuthCognito()]);
//     await Amplify.configure(amplifyconfig); // Your Amplify configuration
//     print('Amplify configured successfully');
//   } catch (e) {
//     print('Amplify configuration failed: $e');
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Smart Helmet',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginWebPage(),
//     );
//   }
// }

// class LoginWebPage extends StatefulWidget {
//   @override
//   _LoginWebPageState createState() => _LoginWebPageState();
// }

// class _LoginWebPageState extends State<LoginWebPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool passwordObscured = true;

//   Future<void> _signIn() async {
//     try {
//       SignInResult result = await Amplify.Auth.signIn(
//         username: _usernameController.text.trim(),
//         password: _passwordController.text.trim(),
//       ).timeout(Duration(seconds: 15)); // Timeout set to 15 seconds

//       if (result.isSignedIn) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => DashboardPage()),
//         );
//       } else {
//         _showErrorDialog('Sign in failed. Please try again.');
//       }
//     } on AuthException catch (e) {
//       _showErrorDialog(e.message);
//     } catch (e) {
//       _showErrorDialog('An unexpected error occurred.');
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Color(0xff0F8188),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 1000,
//                 height: screenHeight,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40),
//                         bottomLeft: Radius.circular(40))),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 7),
//                         child: SizedBox(
//                             height: 70,
//                             child: Image.asset(
//                               "assets/Images/commedianew.png",
//                               fit: BoxFit.contain,
//                             )),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 90,
//                     ),

//                     Container(
//                       width: 400,
//                       height: 300,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.black)),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             "Welcome Back,",
//                             style: TextStyle(
//                                 fontSize: 27,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xff3378a5)),
//                           ),
//                           SizedBox(height: screenHeight * 0.03),
//                           SizedBox(
//                             width: 350,
//                             child: TextField(
//                               controller: _usernameController,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.person),
//                                 hintText: "Username",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide:
//                                       BorderSide(color: Colors.black, width: 2),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.04),
//                           SizedBox(
//                             width: 350,
//                             child: TextField(
//                               controller: _passwordController,
//                               obscureText: passwordObscured,
//                               obscuringCharacter: '*',
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.lock),
//                                 hintText: "Password",
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       passwordObscured = !passwordObscured;
//                                     });
//                                   },
//                                   icon: Icon(passwordObscured
//                                       ? Icons.visibility_off
//                                       : Icons.visibility),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide:
//                                       BorderSide(color: Colors.black, width: 2),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 210, top: 5),
//                             child: TextButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         content: Text(
//                                             'This feature is not available'),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Text('OK'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: Text(
//                                   "Forgot Password",
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xff3378a5)),
//                                 )),
//                           ),
//                           SizedBox(height: 5),
//                           ElevatedButton(
//                             onPressed: _signIn,
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               backgroundColor: Color(0xffc40506),
//                               minimumSize: Size(140, 40),
//                             ),
//                             child: Text(
//                               "Login",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     //
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, top: 10),
//               child: SizedBox(
//                   height: 70,
//                   child: Image.asset(
//                     "assets/Images/minilogo.png",
//                     fit: BoxFit.contain,
//                   )),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 90, left: 30),
//             child: Text(
//               "Your Safety Partner\n In Every Task",
//               style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 11, top: 190),
//             child: SizedBox(
//                 height: 420,
//                 child: Transform.rotate(
//                   angle: -0.05 * 3.14159,
//                   child: Image.asset(
//                     "assets/Images/displayhelmet.png",
//                     fit: BoxFit.contain,
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordObscured = true;
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      ).timeout(Duration(seconds: 15)); // Timeout set to 15 seconds

      if (result.isSignedIn) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        _showErrorDialog('Sign in failed. Please try again.');
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff0F8188),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 1000,
                height: screenHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40))),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: SizedBox(
                            height: 70,
                            child: Image.asset(
                              "assets/Images/commedianew.png",
                              fit: BoxFit.contain,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Welcome Back,",
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff3378a5)),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          SizedBox(
                            width: 350,
                            child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Username",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          SizedBox(
                            width: 350,
                            child: TextField(
                              controller: _passwordController,
                              obscureText: passwordObscured,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordObscured = !passwordObscured;
                                    });
                                  },
                                  icon: Icon(passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 210, top: 5),
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            'This feature is not available'),
                                        actions: <Widget>[
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
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff3378a5)),
                                )),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: _isLoading
                                  ? Color(0xff3378a5)
                                  : Color(0xffc40506),
                              minimumSize: Size(140, 40),
                            ),
                            child: Text(
                              _isLoading ? "Logging in..." : "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: SizedBox(
                  height: 70,
                  child: Image.asset(
                    "assets/Images/minilogo.png",
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 30),
            child: Text(
              "Your Safety Partner\n In Every Task",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11, top: 190),
            child: SizedBox(
                height: 420,
                child: Transform.rotate(
                  angle: -0.05 * 3.14159,
                  child: Image.asset(
                    "assets/Images/displayhelmet.png",
                    fit: BoxFit.contain,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
