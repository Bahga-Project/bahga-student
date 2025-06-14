import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bahga_student/routes/route_names.dart';

import '../service/AuthService.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    _resetUser();
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('student_rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('student_email') ?? '';
        _passwordController.text = prefs.getString('student_password') ?? '';
      }
    });
  }

  Future<void> _resetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('level');
    await prefs.remove('class');
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setBool('student_rememberMe', _rememberMe);
      await prefs.setString('student_email', _emailController.text.trim());
      await prefs.setString(
          'student_password', _passwordController.text.trim());
    } else {
      await prefs.remove('student_rememberMe');
      await prefs.remove('student_email');
      await prefs.remove('student_password');
    }
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // تسجيل الدخول باستخدام Firebase Auth
        /* UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );


        // التحقق من الطالب في Collection Students
        String uid = userCredential.user!.uid;
        QuerySnapshot studentDoc = await FirebaseFirestore.instance
            .collection('Students')
            .where('AuthUID', isEqualTo: uid) // البحث باستخدام حقل AuthUID
            .limit(1)
            .get();

        if (studentDoc.docs.isNotEmpty) {
          // المستخدم طالب
          Navigator.pushReplacementNamed(context, RouteNames.home);
        } else {
          // لو مش طالب
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not recognized as a Student!')),
          );
          await FirebaseAuth.instance.signOut();
        }*/

        Map<String, dynamic> res = await _authService.login(
            _emailController.text.trim(), _passwordController.text.trim());

        if (!res['isAuth']) {
          throw 'Fail';
        }

        // ✅ Instead, just navigate to the home screen directly
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('student_password', _passwordController.text.trim());
        prefs.setString('name', res['name']);
        prefs.setString('level', res['level']);
        prefs.setString('class', res['class']);

        await _saveData(); // still save data if "remember me" is active
        Navigator.pushReplacementNamed(context,
            RouteNames.mainScreen); // حفظ البيانات لو الـ Remember Me مفعل
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xBF3395BD),
              // يمكن تغيري الصورة هنا لصورة مناسبة للطالب
              image: DecorationImage(
                image: AssetImage('assets/images/student_login.gif'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                opacity: 0.9,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 135),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: double.infinity),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Student Login',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3395BD),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA0A0A0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: const TextStyle(
                                  fontSize: 15, color: Color(0x666B6969)),
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 0.0, color: Color(0xFFD7D5D5)),
                              ),
                              filled: true,
                              fillColor: const Color(0xBFFFFFFF),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA0A0A0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Flexible(
                                flex: 8,
                                // 80% of the space for the TextFormField
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(
                                        fontSize: 15, color: Color(0x666B6969)),
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          width: 0, color: Color(0xFFD7D5D5)),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xBFFFFFFF),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Enter a valid password (at least 6 characters)';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Space between field and icon
                              Flexible(
                                flex: 2, // 20% of the space for the camera icon
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFF3395BD),
                                    size: 35, // Increased icon size
                                  ),
                                  onPressed: () async {
                                    try {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? image =
                                          await picker.pickImage(
                                              source: ImageSource.camera);
                                      if (image != null) {
                                        Map<String, dynamic> res =
                                            await _authService.compareFaces(_emailController.text.trim(), image);
                                        // Handle the captured image here
                                        if (res['isAuth']) {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          prefs.setString('name', res['name']);
                                          prefs.setString('level', res['level']);
                                          prefs.setString('class', res['class']);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Logged in successfully!')),
                                          );
                                          Navigator.pushReplacementNamed(
                                              context, RouteNames.mainScreen);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Email and face do not match!')),
                                          );
                                        }
                                      } else {
                                        // User canceled the camera
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('No image captured')),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error opening camera: $e')),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text('Remember me'),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // يمكن تضيفي هنا منطق إعادة تعيين كلمة السر لاحقًا
                                },
                                child: const Text(
                                  'Forgot Password? Reset',
                                  style: TextStyle(color: Color(0xFF3395BD)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: ElevatedButton(
                                  onPressed: _signIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF3395BD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70, vertical: 8),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
