import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/src/domain/repositories/firebase/firebase_repo.dart';
import 'package:machine_test/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:machine_test/src/presentation/pages/register_view/register_screen.dart';
import 'package:machine_test/src/presentation/pages/set_up_pin_view/pin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFB900),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Text(
                  "Sign In",
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
                      BlocListener<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is UserLoaded) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PinScreen(true),
                            ));
                          } else if (state is UserError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return const CircularProgressIndicator();
                            } else {
                              return InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();

                                  if (emailController.text == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Enter email"),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else if (passwordController.text == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Enter password"),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    userBloc.add(SetUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        pin: ""));
                                  }
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
                                        "Sign In",
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
