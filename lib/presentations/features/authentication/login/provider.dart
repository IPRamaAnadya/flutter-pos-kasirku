import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pos/domain/entities/entities.dart';
import 'package:pos/domain/usecases/user/usecase.dart';

class LoginProvider extends ChangeNotifier {

  final UserUsecase _userUsecase;

  LoginProvider(this._userUsecase);

  Future<bool> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await saveUser(await FirebaseAuth.instance.signInWithCredential(credential));
  }

  Future<bool> saveUser(UserCredential user) async {
    return _userUsecase.saveUser(UserEntity(name: user.user?.displayName ?? "", email: user.user?.email ?? "", uid: user.user!.uid, profileURL: user.user?.photoURL ?? ""));
  }

  Future<UserCredential> signInSilently() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

}