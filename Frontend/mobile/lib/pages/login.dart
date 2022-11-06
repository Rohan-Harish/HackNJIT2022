import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/services/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int caseNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(
      builder: (context, authProvider, child) {
        final emailController = TextEditingController();
        final passwordController = TextEditingController();
        switch (caseNumber) {
          case 0: // Login Page
            return WillPopScope(
              onWillPop: () async {
                caseNumber = 2;
                setState(() {});
                return false;
              },
              child: Scaffold(
                backgroundColor: Colors.green,
                body: Consumer<Authentication>(
                  builder: (context, authProvider, child) {
                    return Container(
                      width: 500,
                      child: (Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Clean Cart",
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 350,
                            height: 250,
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Form(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                        width: 250,
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              isDense: true,
                                              helperText: "Enter Email"),
                                          controller: emailController,
                                        )),
                                    SizedBox(
                                      width: 250,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            helperText: "Enter Password"),
                                        controller: passwordController,
                                        obscureText: true,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () =>
                                            authProvider.authenticate(
                                                emailController.text,
                                                passwordController.text),
                                        child: Text("Login"))
                                  ],
                                ))
                              ],
                            ),
                          )
                        ],
                      )),
                    );
                  },
                ),
              ),
            );

          case 1: // Sign Up Page
            return WillPopScope(
              onWillPop: () async {
                caseNumber = 2;
                setState(() {});
                return false;
              },
              child: Scaffold(
                body: Consumer<Authentication>(
                  builder: (context, authProvider, child) {
                    return (Column(
                      children: [
                        Text("Clean Cart"),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [],
                          ),
                        )
                      ],
                    ));
                  },
                ),
              ),
            );
          default: // Sign up or Login Select
            return (Scaffold(
                body: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      image: AssetImage("whiteCover.png"), fit: BoxFit.cover)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Clean Cart",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  const SizedBox(height: 100),
                  TextButton(
                      onPressed: () => {caseNumber = 0, setState(() {})},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          )),
                      child: const Text("Login")),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => {caseNumber = 1, setState(() {})},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.green,
                        )),
                    child: const Text("Sign Up"),
                  )
                ],
              ),
            )));
        }
      },
    );
  }
}
