import 'package:flutter/material.dart';
import 'package:my_souaq/app/services/auth_services.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/custom_button.dart';
import 'package:my_souaq/app/widgets/custom_text.dart';
enum AuthEnum
{
  signin,
  signup
}
class AuthScreen extends StatefulWidget
{
   static const String routName = '/auth-screen';
   const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
{
  AuthEnum _auth = AuthEnum.signup;
  final _signUpKey = GlobalKey<FormState>();
  final _signInKey = GlobalKey<FormState>();
  final AuthServices  authService = AuthServices();
  final TextEditingController  emailController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();
  final TextEditingController  nameController = TextEditingController();
  @override
  void dispose()
  {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser()
  {
    authService.singUpUser(context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
    );
  }

  void signInUser()
  {
    authService.singInUser(context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Declarations.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  ListTile(
                  tileColor: _auth == AuthEnum.signup ? Colors.blueGrey : Declarations.greyBackgroundColor,
                  title: GestureDetector(
                    onTap: () {
                      setState(() {
                        _auth = AuthEnum.signup;
                      });
                    },
                    child: Text("New Customer", style:
                    TextStyle(
                        color: _auth == AuthEnum.signup ? Colors.amber : Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  leading:GestureDetector(
                    onTap: () {
                      setState(() {
                        _auth = AuthEnum.signup;
                      });
                    },
                    child: Icon (
                      Icons.fiber_new_outlined,
                      color: _auth == AuthEnum.signup ? Colors.amber : Colors.black,
                    ),
                  ),
                ),
                if (_auth == AuthEnum.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Declarations.backgroundColor,
                    child: Form(
                        key: _signUpKey,
                        child: Column(
                          children:
                          [
                            CustomText(
                              formController: nameController, hintText: 'fullName', icon: Icons.person_outline,),
                            const SizedBox(height: 10,),
                            CustomText(formController: emailController, hintText: 'Email',icon: Icons.email_outlined),
                            const SizedBox(height: 10,),
                            CustomText(
                              formController: passwordController,
                              hintText: 'password',
                              icon: Icons.password_outlined,
                              isPassword: true,
                            ),
                            const SizedBox(height: 10,),
                            CustomButton(text: "Sign Up", onTap: () {
                              if (_signUpKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                            )
                          ],
                        )
                    ),
                  ),
                  ListTile(
                  tileColor: _auth == AuthEnum.signin ? Colors.blueGrey : Declarations.greyBackgroundColor,
                  title: GestureDetector(
                    onTap: () {
                      setState(() {
                        _auth = AuthEnum.signin;
                      });
                    },
                    child: Text("Have an account ?",
                      style: TextStyle(
                        color: _auth == AuthEnum.signin ? Colors.amber : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  leading:GestureDetector(
                    onTap: () {
                      setState(() {
                        _auth = AuthEnum.signin;
                      });
                    },
                    child: Icon (
                      Icons.accessibility_new_outlined,
                      color: _auth == AuthEnum.signin ? Colors.amber : Colors.black,
                    ),
                  ),
                ),
                if (_auth == AuthEnum.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Declarations.backgroundColor,
                    child: Form(
                        key: _signInKey,
                        child: Column(
                          children: [
                            CustomText(formController: emailController, hintText: 'Email', icon: Icons.email_outlined),
                            const SizedBox(height: 10,),
                            CustomText(
                              formController: passwordController,
                              hintText: 'password',
                              icon: Icons.password_outlined,
                              isPassword: true,
                            ),
                            const SizedBox(height: 10,),
                            CustomButton(text: "Sign In", onTap: () {
                              if (_signInKey.currentState!.validate()) {
                                signInUser();
                              }
                            },)
                          ],
                        )
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Image.asset(
                            "assets/buttons/google.png",
                            width: 260,
                          ),
                          onTap: () {

                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          child: Image.asset(
                            "assets/buttons/fb.png",
                            width: 260,
                          ),
                          onTap: () {

                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
