// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:instragram_application/insragram_application/views/profile/profile_screen.dart';
//
// class RegisterScreen extends StatelessWidget {
//   final String email;
//   final String password;
//
//   RegisterScreen({super.key, this.email = '', this.password = ''});
//
//   @override
//   Widget build(BuildContext context) {
//     final RegisterControllerScreen controller = Get.put(RegisterControllerScreen());
//
//     // Initialize values if not already set
//     controller.email.value = email;
//     controller.password.value = password;
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey,
//           child: ListView(
//             children: [
//               const SizedBox(height: 70),
//               GestureDetector(
//                 onTap: () async {
//                   await controller.pickImage();
//                 },
//                 child: Obx(() => CircleAvatar(
//                   radius: 55,
//                   backgroundColor: const Color(0xFF104491),
//                   child: controller.imageFile.value != null
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.file(
//                       controller.imageFile.value!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                       : Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     width: 100,
//                     height: 100,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 )),
//               ),
//               const SizedBox(height: 70),
//               _viewTextField(
//                 label: 'Name',
//                 onChanged: (value) => controller.name.value = value,
//                 icon: Icons.person,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12.0),
//               _viewTextField(
//                 label: 'Email',
//                 onChanged: (value) => controller.email.value = value,
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
//                 onChanged: (value) => controller.password.value = value,
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
//               const SizedBox(height: 12.0),
//               _viewTextField(
//                 label: 'Phone',
//                 onChanged: (value) => controller.phoneNumber.value = value,
//                 icon: Icons.phone,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 100),
//               Padding(
//                 padding: const EdgeInsets.all(60.0),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(const Color(0xFF104491)),
//                   ),
//                   onPressed: () {
//                     if (controller.formKey.currentState?.validate() ?? false) {
//                       controller.registerUser();
//                     }
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
//                   },
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
//                   ),
//                 ),
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
//
//
// class RegisterControllerScreen extends GetxController {
//   var name = ''.obs;
//   var email = ''.obs;
//   var password = ''.obs;
//   var phoneNumber = ''.obs;
//   final formKey = GlobalKey<FormState>();
//   var imageFile = Rxn<File>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> registerUser() async {
//     if (!formKey.currentState!.validate()) return;
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email.value,
//         password: password.value,
//       );
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': email.value,
//         'name': name.value,
//         'phoneNumber': phoneNumber.value,
//         'profilePicture': imageFile.value != null ? await _uploadImage(imageFile.value!) : null,
//       });
//       Get.snackbar('Success', 'Registered successfully');
//       Get.offAllNamed('/home'); // Navigate to your home screen
//     } catch (e) {
//       Get.snackbar('Error', 'Registration failed: ${e.toString()}');
//     }
//   }
//
//   Future<String?> _uploadImage(File file) async {
//     try {
//       String fileName = 'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.png';
//       var ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(file);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
//       return null;
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         imageFile.value = File(pickedFile.path);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
//     }
//   }
// }





//
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class RegisterScreen extends StatelessWidget {
//   final String email;
//   final String password;
//
//   RegisterScreen({super.key, this.email = '', this.password = ''});
//
//   @override
//   Widget build(BuildContext context) {
//     final RegisterControllerScreen controller = Get.put(RegisterControllerScreen());
//
//     controller.email.value = email;
//     controller.password.value = password;
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: controller.formKey,
//           child: ListView(
//             children: [
//               const SizedBox(height: 70),
//               GestureDetector(
//                 onTap: () async {
//                   await controller.pickImage();
//                 },
//                 child: Obx(() => CircleAvatar(
//                   radius: 55,
//                   backgroundColor: const Color(0xFF104491),
//                   child: controller.imageFile.value != null
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.file(
//                       controller.imageFile.value!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                       : Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     width: 100,
//                     height: 100,
//                     child: Icon(
//                       Icons.camera_alt,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 )),
//               ),
//               const SizedBox(height: 70),
//               _viewTextField(
//                 label: 'Name',
//                 onChanged: (value) => controller.name.value = value,
//                 icon: Icons.person,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 12.0),
//               _viewTextField(
//                 label: 'Email',
//                 onChanged: (value) => controller.email.value = value,
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
//                 onChanged: (value) => controller.password.value = value,
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
//               const SizedBox(height: 12.0),
//               _viewTextField(
//                 label: 'Phone',
//                 onChanged: (value) => controller.phoneNumber.value = value,
//                 icon: Icons.phone,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 100),
//               Padding(
//                 padding: const EdgeInsets.all(60.0),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(const Color(0xFF104491)),
//                   ),
//                   onPressed: () {
//                     if (controller.formKey.currentState?.validate() ?? false) {
//                       controller.registerUser();
//                     }
//                   },
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
//                   ),
//                 ),
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
//
// class RegisterControllerScreen extends GetxController {
//   var name = ''.obs;
//   var email = ''.obs;
//   var password = ''.obs;
//   var phoneNumber = ''.obs;
//   final formKey = GlobalKey<FormState>();
//   var imageFile = Rxn<File>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> registerUser() async {
//     if (!formKey.currentState!.validate()) return;
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email.value,
//         password: password.value,
//       );
//
//       // Upload image if available
//       String? profileImageUrl;
//       if (imageFile.value != null) {
//         profileImageUrl = await _uploadImage(imageFile.value!);
//       }
//
//       // Store user data
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': email.value,
//         'name': name.value,
//         'phoneNumber': phoneNumber.value,
//         'profilePicture': profileImageUrl,
//       });
//
//       Get.snackbar('Success', 'Registered successfully');
//       Get.offAllNamed('/home'); // Navigate to home screen
//     } catch (e) {
//       Get.snackbar('Error', 'Registration failed: ${e.toString()}');
//     }
//   }
//
//   Future<String?> _uploadImage(File file) async {
//     try {
//       String fileName = 'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.png';
//       var ref = FirebaseStorage.instance.ref().child(fileName);
//       await ref.putFile(file);
//       return await ref.getDownloadURL();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
//       return null;
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         imageFile.value = File(pickedFile.path);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
//     }
//   }
// }





import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import '../../../controllers/instra_controller/instra_class/auth_servies.dart';
import '../../../controllers/instra_controller/instra_class/widget_customization.dart';
import '../../../controllers/instra_controller/video_upload_controller.dart';
import '../../login/instra/instra_screen.dart';
import '../../login/instra_login/login_screen.dart';

class InstaRegisterScreen extends StatefulWidget {
  const InstaRegisterScreen({Key? key}) : super(key: key);

  @override
  State<InstaRegisterScreen> createState() => _InstaRegisterScreenState();
}

class _InstaRegisterScreenState extends State<InstaRegisterScreen> with WidgetCustomization {
  final AuthService authController = Get.find<AuthService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  File? _profileImage;
  RxBool isPasswordVisible = false.obs;
  final _formKey = GlobalKey<FormState>();
  final VideoUploadController _videoController = Get.find<VideoUploadController>();

  // Function to pick an image using image_picker
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Set the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage, // Call the function to pick image
                        child: _profileImage == null
                            ? CircleAvatar(
                          foregroundColor: Colors.grey,
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.camera_alt, color: Colors.grey[600]),
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          backgroundImage: FileImage(_profileImage!), // Display the selected image
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    viewTextField(
                      'Name',
                      nameController,
                      prefixIcon: Icon(Icons.edit),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    viewTextField(
                      'Email',
                      emailController,
                      prefixIcon: Icon(Icons.email),
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
                    SizedBox(height: 10),
                    // Password TextField with visibility toggle
                    Obx(() {
                      return viewTextField(
                        'Password',
                        passwordController,
                        prefixIcon: Icon(Icons.lock),
                        obscureText: !isPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
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
                    SizedBox(height: 10),
                    // Phone TextField with validator
                    viewTextField(
                      'Phone',
                      phoneNumberController,
                      prefixIcon: Icon(Icons.phone),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      return authController.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : viewButton(
                        'Register',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            authController
                                .registerWithEmailPassword(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phoneNumber: phoneNumberController.text,
                              profileImage: _profileImage,
                            )
                                .then((_) {
                              Get.to(InstaHomeScreen());
                            }).catchError((error) {
                              Get.snackbar('Registration Successfull',toString());
                            });
                          }
                        },
                      );
                    }),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              TextSpan(
                                text: 'Login here',
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(InstaCloneLogin());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
