import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../models/user.dart';

class FirebaseService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<User> signIn(String email, String password) async {
    auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = User(uid: userCredential.user!.uid, email: userCredential.user!.email!);
    return user;
  }

  static Future<User> signUp(String name, String email, String password) async {
    auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.updateDisplayName(name);
    User user = User(uid: userCredential.user!.uid, email: userCredential.user!.email!);
    return user;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<String> getCountryCode() async {
    await _remoteConfig.fetchAndActivate();
    return _remoteConfig.getString('country_code');
  }
}
