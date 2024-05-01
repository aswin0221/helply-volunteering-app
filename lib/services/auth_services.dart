import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {

  late final FirebaseAuth auth;

  AuthServices()
  {
     auth = FirebaseAuth.instance;
  }

  ///create Account with email and password
  createAccountWithEmail(String email, String password) {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  ///Login with email and password
   loginWithEmail()
   {

   }
}
