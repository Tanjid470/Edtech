import 'package:edtech/constants/app_colors.dart';
import 'package:edtech/screen/Authentication/auth_services.dart';
import 'package:edtech/constants/app_textStyle.dart';
import 'package:edtech/screen/Authentication/animated_Text.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppColors.bgGradient, // Set your gradient here
          ),
        ),
        elevation: 0,
        title: const Center(child: Text('Authentication')),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: customSize(25, const Color.fromARGB(255, 74, 39, 155)),
              ),
              Text(
                "to",
                style: customSize(
                  20,
                  const Color.fromARGB(255, 40, 64, 143),
                ),
              ),
              animationText(),
              SizedBox(
                height: 30,
              ),
              // ======== Full Name ========
              login
                  ? Container()
                  : TextFormField(
                      key: const ValueKey('fullname'),
                      decoration: const InputDecoration(
                        hintText: 'Enter Full Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Full Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          fullname = value!;
                        });
                      },
                    ),

              // ======== Email ========
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              // ======== Password ========

              TextFormField(
                key: const ValueKey('password'),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Please Enter Password of min length 6';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 2,
              ),
              !login
                  ? Container()
                  :
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color.fromARGB(255, 241, 238, 238),
                            title: const Text(''),
                            content: Text('This feature not added yet.',style: customSize(18, Colors.black),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Perform an action when the user taps the button
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child:const Text('Close'),
                              ),
                              // Add more buttons or actions as needed
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Forget password?",
                      style: customSize(
                          15, const Color.fromARGB(255, 74, 39, 155)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: AppColors.bgGradient,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        login
                            ? AuthServices.signinUser(email, password, context)
                            : AuthServices.signupUser(
                                email, password, fullname, context);
                      }
                    },
                    child: Text(
                      login ? 'Login' : 'Signup',
                      style: customSize(20, Colors.white),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text(
                    login
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login",
                    style: customSize(16, Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
