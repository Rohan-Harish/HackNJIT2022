import 'package:flutter/material.dart';
import 'package:mobile/components/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      theme: ThemeData(
        backgroundColor: Colors.green,
      ),
      home: AuthRouter(),
    );
  }
}

class AuthRouter extends StatefulWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  State<AuthRouter> createState() => _AuthRouterState();
}

class _AuthRouterState extends State<AuthRouter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(),
    );
  }
}
