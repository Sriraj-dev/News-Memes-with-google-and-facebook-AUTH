

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{

  final googleSignIn = GoogleSignIn();
  Map? userData;

  GoogleSignInAccount? _user;

 GoogleSignInAccount get user => _user!;

 Future googleLogin()async{
   try{
     final googleUser =await googleSignIn.signIn();
     if(googleUser == null) return;
     _user = googleUser;

     final googleAuth = await googleUser.authentication;

     final credentials = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );

     await FirebaseAuth.instance.signInWithCredential(credentials);

     notifyListeners();
   }catch(e){
     print(e.toString());
   }

 }

 Future googleLogout()async{
   try{
     print('Logging Out');
     await googleSignIn.disconnect();

     FirebaseAuth.instance.signOut();
   }catch(e){
     FirebaseAuth.instance.signOut();
   }
   await FacebookAuth.i.logOut();
   userData = null;
   notifyListeners();
 }

  Future<bool> facebookLogin()async{
    bool loggedIn = false;
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile","email"],
    );

    if(result.status == LoginStatus.success){
      print('login sucessfull');
      final requestdata = await FacebookAuth.i.getUserData(
        fields: "email,name,picture",
      );

      userData = requestdata;
      print(userData);
      loggedIn = true;
      notifyListeners();

    }
    print('returning $loggedIn');
    return loggedIn;
  }

  facebookLogout()async{
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }
}