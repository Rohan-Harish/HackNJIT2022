import 'package:flutter/material.dart';
import 'package:mobile/components/appbar.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/login.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/globals.dart' as global;
import 'package:provider/provider.dart';

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
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Authentication>(
        create: (context) => auth,
        child: Consumer<Authentication>(
          builder: (context, authProvider, child) {
            if (authProvider.getStatus()) {
              return (const HomePage());
            } else {
              return (const LoginPage());
            }
          },
        ));
  }
}
