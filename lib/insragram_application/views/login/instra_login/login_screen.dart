// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../controllers/login_controller_screen.dart';
// import '../../register/instra_register/instra_register_screen.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   // Using GetX to find the existing instance of InstraControllerScreen
//   final LoginControllerScreen controller = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey, // Accessing the formKey from the controller
//           child: ListView(
//             children: [
//               const SizedBox(height: 70),
//               Image.network(
//                 "https://st4.depositphotos.com/1050070/21934/i/450/depositphotos_219349048-stock-illustration-chisinau-moldova-september-2018-instagram.jpg",
//                 width: 110,
//                 height: 110,
//               ),
//               const SizedBox(height: 90),
//               _viewTextField(
//                 label: 'Email',
//                 onChanged: (value) => controller.email.value = value, // Update the email in the controller
//                 icon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
//                   if (!emailRegExp.hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12.0),
//               _viewTextField(
//                 label: 'Password',
//                 onChanged: (value) => controller.password.value = value, // Update the password in the controller
//                 icon: Icons.lock,
//                 minLength: 8,
//                 keyboardType: TextInputType.text,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password must be at least 8 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 200),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 60),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(const Color(0xFF104491)),
//                   ),
//                   onPressed: () {
//                     if (controller.formKey.currentState?.validate() ?? false) {
//                       controller.loginUser(); // Call loginUser method from the controller
//                     }
//                   },
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account? "),
//                   GestureDetector(
//                     onTap: () => Get.to(() => RegisterScreen(
//                       email: controller.email.value, // Pass the email and password to the RegisterScreen
//                       password: controller.password.value,
//                     )),
//                     child: const Text(
//                       "Signup Here",
//                       style: TextStyle(
//                         color: Color(0xFF104491),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _viewTextField({
//     required String label,
//     required ValueChanged<String> onChanged,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     int minLength = 1,
//     required String? Function(String?) validator,
//   }) {
//     return TextFormField(
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon),
//         border: const OutlineInputBorder(),
//       ),
//       validator: validator,
//     );
//   }
// }











import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/instra_controller/instra_class/auth_servies.dart';
import '../../../controllers/instra_controller/instra_class/widget_customization.dart';
import '../../register/instra_register/instra_register_screen.dart';
import '../instra/instra_screen.dart';


class InstaCloneLogin extends StatefulWidget {
  const InstaCloneLogin({super.key});

  @override
  State<InstaCloneLogin> createState() => _InstaCloneLoginState();
}

class _InstaCloneLoginState extends State<InstaCloneLogin> with WidgetCustomization {
  final authController = Get.put(AuthService());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey, // Form key for validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Instagram",
                      style: GoogleFonts.aclonica(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                viewTextField(
                  'Email',
                  emailController,
                  prefixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return viewTextField(
                    'Password',
                    passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: !isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  );
                }),
                const SizedBox(height: 30),
                Obx(() {
                  return authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : viewButton(
                    'Login',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        bool loginSuccess = await authController.loginWithEmailPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );if (loginSuccess) {
                          Get.to(() =>InstaHomeScreen());
                        } else {
                          Get.to(() => const InstaRegisterScreen());
                        }
                      }
                    },
                  );
                }),
                const SizedBox(height: 80),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextSpan(
                        text: 'Sign up here',
                        style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const InstaRegisterScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        );
    }
}
