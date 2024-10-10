import 'package:flutter/material.dart';
import 'register.dart';
import 'package:plantpursuit/main.dart'; // Import the main page for navigation back

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background (4).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ปุ่มย้อนกลับ
                    Align(
                      alignment: Alignment.topLeft, // จัดตำแหน่งไอคอนให้อยู่มุมบนซ้าย
                      child: IconButton(
                        icon: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // กำหนดรูปทรงของพื้นหลังเป็นวงกลม
                            color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                          ),
                          padding: const EdgeInsets.all(8.0), // เพิ่มระยะห่างรอบ ๆ ไอคอน
                          child: const Icon(Icons.arrow_back,
                              color: Colors.green), // ไอคอนลูกศรสีเขียว
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MyApp()), // นำทางกลับไปที่หน้า MyApp
                            (route) => false, // ลบเส้นทางทั้งหมดที่ค้างไว้
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Sign In Form
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Email/Phone number', _emailController),
                          const SizedBox(height: 10),
                          _buildTextField('Password', _passwordController, isPassword: true),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            child: const Text('Sign In'),
                            onPressed: () {
                              _handleSignIn();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            child: const Text('Register',
                                style: TextStyle(color: Colors.green)),
                            onPressed: () => _navigateToRegisterPage(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void _handleSignIn() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('กรุณากรอกอีเมล/เบอร์โทรศัพท์และรหัสผ่าน');
    } else {
      // สมมติว่าการลงชื่อเข้าใช้สำเร็จ
      _showSnackBar('ลงชื่อเข้าใช้สำเร็จ!');

      // นำทางไปที่หน้า MyApp หลังจากลงชื่อเข้าใช้สำเร็จ
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false, // ลบเส้นทางทั้งหมดที่ค้างไว้
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
