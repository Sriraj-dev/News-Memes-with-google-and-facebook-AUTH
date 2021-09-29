import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_memes_app/Screens/SignInPage.dart';
import 'package:news_memes_app/Screens/SignUpPage.dart';
import 'package:news_memes_app/main.dart';
import 'package:news_memes_app/services/FacebookAuth.dart';
import 'package:news_memes_app/services/googleAuth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.white,));
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!!',
                style: GoogleFonts.akronim(),
              ));
            } else if (snapshot.hasData) {
              return HomePage();
            } else
              return buildLoginPage(size, context);
          }
      ),
    );
  }

  SingleChildScrollView buildLoginPage(Size size, BuildContext context) {
    return SingleChildScrollView(
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
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome!',
                    style: GoogleFonts.lato(
                      fontSize: 46,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ), flex: 2,),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TextField(
                    //     controller: email,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         fillColor: Color(0xffe7edeb),
                    //         filled: true,
                    //         hintText: 'E-mail',
                    //         prefixIcon: Icon(
                    //           Icons.email,
                    //           color: Colors.grey[600],
                    //         )
                    //     )
                    // ),
                    // SizedBox(height: 20,),
                    // TextField(
                    //     controller: password,
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         fillColor: Color(0xffe7edeb),
                    //         filled: true,
                    //         hintText: 'Password',
                    //         prefixIcon: Icon(
                    //           Icons.lock,
                    //           color: Colors.grey[600],
                    //         )
                    //     )
                    // ),
                   // SizedBox(height: 15,),
                   //  Row(
                   //    mainAxisAlignment: MainAxisAlignment.end,
                   //    children: [
                   //      Text('Forgot your password?',
                   //        style: GoogleFonts.lato(
                   //          color: Colors.blue.shade800,
                   //          decoration: TextDecoration.underline,
                   //        ),
                   //      )
                   //    ],
                   //  ),
                   //  SizedBox(height: 15,),
                   //  Row(
                   //    mainAxisAlignment: MainAxisAlignment.center,
                   //    children: [
                   //      Text('Don\'t have an account?',
                   //        style: GoogleFonts.lato(
                   //          //color: Colors.blue.shade800,
                   //          //decoration: TextDecoration.underline,
                   //        ),
                   //      ),
                   //      GestureDetector(
                   //        onTap: (){
                   //          Navigator.push(context,
                   //          MaterialPageRoute(builder: (context) => SignUpPage())
                   //          );
                   //        },
                   //        child: Text('Create one',
                   //          style: GoogleFonts.lato(
                   //            color: Colors.blue.shade800,
                   //            decoration: TextDecoration.underline,
                   //          ),
                   //        ),
                   //      )
                   //    ],
                   //  ),
                   //  SizedBox(height: 30,),

                    Container(
                      width: size.width * 0.8,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.email_rounded,color: Colors.white,),
                        onPressed: () {
                         Navigator.push(context,
                         MaterialPageRoute(builder: (context)=>SignInPage())
                         );
                        },
                        label: Text('Sign In with Email',
                          style: GoogleFonts.alice(
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: size.width * 0.8,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: FaIcon(FontAwesomeIcons.google,
                          color: Colors.white,),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context, listen: false);
                          provider.googleLogin();
                        },
                        label: Text('Sign in with Google',
                          style: GoogleFonts.alice(
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
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
                          if(loggedIn)
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));


                        },
                        label: Text('Sign in with Facebook',
                          style: GoogleFonts.alice(
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?',
                          style: GoogleFonts.lato(
                            //color: Colors.blue.shade800,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignUpPage())
                            );
                          },
                          child: Text('Create one',
                            style: GoogleFonts.lato(
                              color: Colors.blue.shade800,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 30,),
                  ],
                ),
              ),

            ), flex: 5,)
          ],
        ),
      ),
    );
  }
}
