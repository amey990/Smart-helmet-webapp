import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:smarthelmet/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordObscured = true;

  Future<void> _signIn() async {
    try {
      SignInResult result = await Amplify.Auth.signIn(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (result.isSignedIn) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        _showErrorDialog('Sign in failed. Please try again.');
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.message);
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Image.asset('assets/Images/commedianewlogo.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                    color: Color(0xffF4F2F2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        spreadRadius: 0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffc40506)),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        TextField(
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
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content:
                                      Text('This feature is not available'),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Forgot password?",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff034676)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          // onPressed: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => DashboardPage()));
                          // },
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color(0xffc40506),
                            minimumSize: Size(300, 60),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
