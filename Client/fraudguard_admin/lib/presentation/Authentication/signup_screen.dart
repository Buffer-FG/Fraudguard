// import 'package:flutter/material.dart';
// import './Services/authentication.dart';
// import './widgets/snackbar.dart';
// import './widgets/button.dart';
// import './widgets/text_field.dart';
// import '../dashboard_screen/dashboard_screen.dart';
// import './login_screen.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isLoading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//   }

//   void signupUser() async {
//     // set is loading to true.
//     setState(() {
//       isLoading = true;
//     });
//     // signup user using our authmethod
//     String res = await AuthMethod().signupUser(
//         email: emailController.text,
//         password: passwordController.text,
//         name: nameController.text);
//     // if string return is success, user has been created and navigate to next screen other witse show error.
//     if (res == "success") {
//       setState(() {
//         isLoading = false;
//       });
//       //navigate to the next screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const DashboardScreen(),
//         ),
//       );
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       // show error
//       showSnackBar(context, res);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//           child: SizedBox(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: height / 2.8,
//               child: Image.asset('assets/images/signup.jpeg'),
//             ),
//             TextFieldInput(
//                 icon: Icons.person,
//                 textEditingController: nameController,
//                 hintText: 'Enter your name',
//                 textInputType: TextInputType.text),
//             TextFieldInput(
//                 icon: Icons.email,
//                 textEditingController: emailController,
//                 hintText: 'Enter your email',
//                 textInputType: TextInputType.text),
//             TextFieldInput(
//               icon: Icons.lock,
//               textEditingController: passwordController,
//               hintText: 'Enter your password',
//               textInputType: TextInputType.text,
//               isPass: true,
//             ),
//             MyButtons(onTap: signupUser, text: "Sign Up"),
//             const SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Already have an account?"),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const LoginScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     " Login",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }


import 'package:flutter/material.dart';
import './Services/authentication.dart';
import './widgets/snackbar.dart';
import './widgets/button.dart';
import './widgets/text_field.dart';
import './login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    empIdController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void signupUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(context, "Passwords do not match!");
      return;
    }

    if (empIdController.text.isEmpty) {
      showSnackBar(context, "Employee ID is required!");
      return;
    }

    setState(() {
      isLoading = true;
    });

    String res = await AuthMethod().signupUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      empId: empIdController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (res == "success") {
      showSnackBar(context, "Account created successfully. Please log in.");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 2.8,
                  child: Image.asset('assets/images/signup.jpeg'),
                ),
                TextFieldInput(
                  icon: Icons.person,
                  textEditingController: nameController,
                  hintText: 'Enter your name',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  icon: Icons.badge,
                  textEditingController: empIdController,
                  hintText: 'Enter your employee ID',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  icon: Icons.email,
                  textEditingController: emailController,
                  hintText: 'Enter your employee email',
                  textInputType: TextInputType.emailAddress,
                ),
                TextFieldInput(
                  icon: Icons.lock,
                  textEditingController: passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                TextFieldInput(
                  icon: Icons.lock_outline,
                  textEditingController: confirmPasswordController,
                  hintText: 'Confirm your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 20),
                MyButtons(onTap: signupUser, text: "Sign Up"),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
