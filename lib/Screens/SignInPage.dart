import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_memes_app/Screens/SignUpPage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool loggingIn = false;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.lato(
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                            controller: email,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fillColor: Color(0xffe7edeb),
                                filled: true,
                                hintText: 'E-mail',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey[600],
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fillColor: Color(0xffe7edeb),
                                filled: true,
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[600],
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot your password?',
                              style: GoogleFonts.lato(
                                color: Colors.blue.shade800,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.lato(
                                  //color: Colors.blue.shade800,
                                  //decoration: TextDecoration.underline,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                'Create one',
                                style: GoogleFonts.lato(
                                  color: Colors.blue.shade800,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text)
                                    .then((value) => {
                                          setState(() {
                                            loggingIn = true;
                                          }),
                                          Future.delayed(
                                              Duration(
                                                  seconds: 1,
                                                  milliseconds: 50), () {
                                            Navigator.pop(context);
                                          })
                                        })
                                    .catchError((e) {
                                  final snackBar = new SnackBar(
                                    content: Text('Invalid Credentials!'),
                                    backgroundColor: Colors.red,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                                // setState(() {
                                //   loggingIn = true;
                                // });
                                //  Future.delayed(
                                //     Duration(seconds: 1, milliseconds: 50), () {
                                //   Navigator.pop(context);
                                // });
                              } catch (e) {
                                print('Error --- $e');
                              }
                            },
                            child: !loggingIn
                                ? Text(
                                    'Login',
                                    style: GoogleFonts.alice(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  )
                                : CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
