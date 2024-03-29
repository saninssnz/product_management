import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/src/domain/repositories/firebase/firebase_repo.dart';
import 'package:machine_test/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:machine_test/src/presentation/pages/login_view/login_screen.dart';
import 'package:machine_test/src/presentation/pages/set_up_pin_view/pin_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFB900),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        cursorColor: Colors.grey[350],
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        cursorColor: Colors.grey[350],
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if(state is UserLoading ){
                            return const CircularProgressIndicator();
                          }
                          else {
                            return InkWell(
                              onTap: () async {
                                if(emailController.text == ""){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Enter email"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                else if(passwordController.text == ""){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Enter password"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                else{
                                  userBloc.add(CreateUserData(email: emailController.text, password: passwordController.text));

                                  if(state is UserLoaded) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (
                                                context) => const LoginScreen()));
                                  }
                                }
                                // User? user = await createAccount(
                                //     emailController.text, passwordController.text);
                                // if (user != null) {
                                //   Navigator.of(context).pushReplacement(
                                //       MaterialPageRoute(
                                //       builder: (context) =>
                                //           const LoginScreen()));
                                //   if (kDebugMode) {
                                //     print("Signup successful");
                                //   }
                                //
                                // } else {
                                //   if (kDebugMode) {
                                //     print("Signup failed");
                                //   }
                                // }
                              },
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black,
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 20),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
