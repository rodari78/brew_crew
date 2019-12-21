import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<User>.value(
          value: AuthServices().user,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: Wrapper()
      ),
    );
  }
}