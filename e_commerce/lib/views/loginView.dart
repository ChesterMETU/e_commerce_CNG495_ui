import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../amplifyconfiguration.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  int _isLoading = 0;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  void _handleSubmit() {
    setState(() {
      _isLoading = 1;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = 0;
      });
    });
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      initialStep: AuthenticatorStep.signIn,
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: const Scaffold(
          body: Center(
            child: Text('You are logged in!'),
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              TextFormField(
                enabled: _isLoading == 1 ? false : true,
                readOnly: _isLoading == 1 ? true : false,
                obscureText: false,
                controller: emailController,
                style: TextStyle(
                    color: _isLoading == 1 ? Colors.grey : Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(22),
                  hintText: "E-mail",
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                enabled: _isLoading == 1 ? false : true,
                readOnly: _isLoading == 1 ? true : false,
                obscureText: true,
                controller: passwordController,
                style: TextStyle(
                    color: _isLoading == 1 ? Colors.grey : Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(22),
                  hintText: "Password",
                  hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              InkWell(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                onTap: () {
                  _handleSubmit();
                },
                child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(17, 82, 253, 1),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 20),
                    width: double.infinity,
                    child: _isLoading == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: Center(
                              child: RichText(
                                  text: const TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ))
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SpinKitDualRing(
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
