import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:machine_test/src/data/models/user_model.dart';
import 'package:machine_test/src/domain/repositories/firebase/firebase_repo.dart';
import 'package:machine_test/src/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:machine_test/src/presentation/pages/home_view/home_screen.dart';
import 'package:machine_test/src/presentation/pages/register_view/register_screen.dart';
import 'package:machine_test/src/presentation/pages/set_up_pin_view/pin_screen.dart';

class PinScreen extends StatefulWidget {
  final bool isLogin;
  const PinScreen(this.isLogin,{super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {

  TextEditingController otpController = TextEditingController();

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
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Text(
                  widget.isLogin?
                  "Set up Pin":
                  "Enter Pin",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 80),
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
                        height: 80,
                      ),
                      OtpTextField(
                        numberOfFields: 4,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        borderColor: Colors.black,
                        enabledBorderColor: Colors.black,
                        disabledBorderColor: Colors.black,
                        focusedBorderColor: Colors.yellow,
                        showFieldAsBox: true,
                        cursorColor: Colors.black,
                        textStyle: const TextStyle(
                            color: Colors.black
                        ),
                        onCodeChanged: (String code) {

                        },
                        onSubmit: (String verificationCode){
                          setState(() {
                            otpController = TextEditingController(text: verificationCode);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return InkWell(
                              onTap: () async {

                                FocusNode().requestFocus();

                                if(otpController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Enter Pin"),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                  else if (widget.isLogin) {
                                    userBloc.add(
                                        AddUserToPreferenceEvent(UserModel(
                                            userEmail: state.userModel
                                                ?.userEmail
                                                .toString(),
                                            pin: otpController.text
                                        )));

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                        const HomeScreen()));
                                  }
                                else if(otpController.text == userBloc.state.userModel?.pin){
                                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                                         builder: (context) =>
                                         const HomeScreen()));
                                   }
                                   else{
                                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                       content: Text("Invalid Pin"),
                                       duration: Duration(seconds: 2),
                                       backgroundColor: Colors.red,
                                     ));
                                   }

                              },
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black,
                                child:  Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 20),
                                    child: Text(
                                      widget.isLogin?
                                      "Set Pin":
                                      "Ok",
                                      style: const TextStyle(
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
