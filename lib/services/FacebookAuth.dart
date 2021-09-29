
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInController extends ChangeNotifier{

  Map? userData;

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