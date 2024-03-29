import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

final FirebaseAuth  _auth = FirebaseAuth.instance;

User _userFromFirebaseUser( FirebaseUser user){
  return user !=null ? User(uid: user.uid) :null;
}

Stream <User> get user {
  //return _auth.onAuthStateChanged.map((FirebaseUser user) => _createFromFirebaseUser(user));
  return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
}

//sing in anon
Future singInAnon() async {
  try{
    AuthResult  result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser (user);
  } catch (e){
    print(e.toString());
    return null;
  }
}


//sing in with email & Password
Future signInWithEmailAndPassword( String email, String password) async {
try {
  AuthResult  result = await _auth.signInWithEmailAndPassword (email: email, password: password);
  FirebaseUser user =result.user;
  return _userFromFirebaseUser (user);
} catch (e) {
  print(e.toString());
  return null;
}
}


//registrer with email & password
Future registerWithEmailAndPassword( String email, String password) async {
try {
  AuthResult  result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  FirebaseUser user =result.user;

  await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

  return _userFromFirebaseUser (user);
} catch (e) {
  print(e.toString());
  return null;
}
}


//sign out
Future signOut  () async {
  try {
    return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }

}


}