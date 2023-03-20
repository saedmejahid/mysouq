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
  AuthEnum auth = AuthEnum.signup;
  final signupKey = GlobalKey<FormState>();
  final signinKey = GlobalKey<FormState>();
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

  void singUpUser()
  {
    authService.singUpUser(context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
    );
  }

  void singInUser()
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
             children:
             [
               const Text(
                 'Welcome',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),
              ),
              ListTile(
                tileColor: auth == AuthEnum.signup ? Declarations.backgroundColor : Declarations.greyBackgroundColor,
                title: const Text(
                    'New Customer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                leading: Radio(
                  activeColor: Declarations.secondaryColor,
                    value:AuthEnum.signup ,
                    groupValue: auth,
                    onChanged: (AuthEnum ? value)
                    {
                      setState(()
                      {
                        auth = value ?? AuthEnum.signup;
                      });
                    },
                ),
              ),
              if(auth == AuthEnum.signup)
              Container(
                decoration: const BoxDecoration(
                  color: Declarations.backgroundColor,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signupKey,
                    child: Column(
                      children:
                      [
                        CustomText(
                          formController: nameController,
                          hintText: 'Please Enter Your FullName',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                            formController: emailController,
                          hintText: 'Please Enter Your Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          formController: passwordController,
                          hintText: 'Please Enter Your Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: 'Sign Up',
                            onTap: ()
                            {
                              if(signupKey.currentState!.validate())
                              {
                                singUpUser();
                              }
                            }
                        ),
                      ],
                    )
                ),
              ),
              ListTile(
                tileColor: auth == AuthEnum.signin ? Declarations.backgroundColor : Declarations.greyBackgroundColor,
                title: const Text(
                  'Have an account ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                leading: Radio(
                  activeColor: Declarations.secondaryColor,
                  value:AuthEnum.signin ,
                  groupValue: auth,
                  onChanged: (AuthEnum ? value)
                  {
                    setState(()
                    {
                      auth = value ?? AuthEnum.signin;
                    });
                  },
                ),
              ),
               if(auth == AuthEnum.signin)
                 Container(
                   decoration: const BoxDecoration(
                     color: Declarations.backgroundColor,
                   ),
                   padding: const EdgeInsets.all(8.0),
                   child: Form(
                       key: signinKey,
                       child: Column(
                         children:
                         [
                           CustomText(
                             formController: emailController,
                             hintText: 'Please Enter Your Email',
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           CustomText(
                             formController: passwordController,
                             hintText: 'Please Enter Your Password',
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           CustomButton(
                               text: 'Sign In',
                               onTap: ()
                               {
                                 if(signinKey.currentState!.validate())
                                 {
                                   singInUser();
                                 }
                               }
                           ),
                         ],
                       )
                   ),
                 ),
            ],
          ),
         )),
      ),
    );
  }
}
