import 'package:carezone/ui/auth/restpasswordscreen.dart';
import 'package:carezone/ui/resourses/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resourses/values_manager.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password, String username, bool islogin,
      BuildContext ctx) submitfun;
  final bool _isloading;
  const AuthForm(this.submitfun, this._isloading, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  bool _islogin = true;
  String _email = '';
  String _password = '';
  String _username = '';

  void _submit() {
    final isvaild = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isvaild) {
      _formkey.currentState!.save();
      widget.submitfun(
          _email.trim(), _password.trim(), _username.trim(), _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'please enter a valid address';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _email = newValue!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[350],
                    hintText: 'Email',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
              const SizedBox(height: AppSize.s8),
              if (!_islogin)
                TextFormField(
                  key: const ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'please enter at least 4 characters';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _username = newValue!,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[350],
                    hintText: 'User Name',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              const SizedBox(height: AppSize.s4),
              TextFormField(
                key: const ValueKey('password'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 characters';
                  }
                  return null;
                },
                onSaved: (newValue) => _password = newValue!,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[350],
                  hintText: 'password',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 10,
              ),
              if (_islogin)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ResetPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSize.s16),
                      ),
                    )
                  ]),
                ),
              const SizedBox(
                height: 15,
              ),
              if (widget._isloading) const CircularProgressIndicator(),
              if (!widget._isloading)
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 12)),
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: _submit,
                    child: Text(
                      _islogin ? 'Log In' : 'Sign Up',
                      style: getBoldStyle(color: Colors.white, fontSize: 20),
                    )),
              const SizedBox(
                height: 5,
              ),
              if (!widget._isloading)
                TextButton(
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: Text(
                        _islogin
                            ? 'Create a new account '
                            : 'I already have an account',
                        style: getBoldStyle(color: Colors.teal, fontSize: 18)))
            ],
          )),
    );
  }
}
