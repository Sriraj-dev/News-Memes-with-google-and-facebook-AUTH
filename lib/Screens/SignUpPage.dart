import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_memes_app/main.dart';
import 'package:news_memes_app/services/googleAuth.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isSigningIn = false;
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
                        'Sign Up',
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
                          height: 30,
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              try {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text).then((value) => {
                                setState(() {
                                isSigningIn = true;
                                }),
                                Future.delayed(Duration(seconds: 1,milliseconds: 50),(){
                                Navigator.popUntil(context, (route) => route.isFirst);
                                }),
                                }).catchError((e){
                                  final snackBar = new SnackBar(
                                    content: Text('Invalid Credentials!'),
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: !isSigningIn?Text(
                              'Sign Up',
                              style: GoogleFonts.alice(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ):CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              height: 10,
                            )),
                            Text('or'),
                            Expanded(
                                child: Divider(
                              height: 10,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 60,
                          child: ElevatedButton.icon(
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                            label: Text(
                              'Sign Up with Google',
                              style: GoogleFonts.alice(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.8,
                          height: 60,
                          child: ElevatedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.facebook,
                              color: Colors.white,),
                            onPressed: () async{
                              final provider = Provider.of<GoogleSignInProvider>(
                                  context, listen: false);
                              bool loggedIn =await provider.facebookLogin();
                              print('recieved - $loggedIn');
                              if(loggedIn){
                                Navigator.popUntil(context, (route) => false);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                              }



                            },
                            label: Text('Sign Up with Facebook',
                              style: GoogleFonts.alice(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20
                              ),
                            ),

                          ),
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
