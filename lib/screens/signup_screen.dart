import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }
      
    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6D2C1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/logo.jpeg', height: 80),
                ),
                SizedBox(height: 40),
                Text(
                  "Start Your Coffee Journey with us",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4B2C20)),
                ),
                SizedBox(height: 40),
                
                _buildInputField("Full Name", _fullNameController),
                _buildInputField("Username", _usernameController),
                
              
                _buildInputField(
                  "Password", 
                  _passwordController, 
                  isPassword: true, 
                  isHidden: _isPasswordHidden,
                  onToggle: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),
                
               
                _buildInputField(
                  "Confirm Password", 
                  _confirmPasswordController, 
                  isPassword: true, 
                  isHidden: _isConfirmPasswordHidden,
                  onToggle: () => setState(() => _isConfirmPasswordHidden = !_isConfirmPasswordHidden),
                ),
                
                SizedBox(height: 30),
                
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [Color(0xFFC68A5F), Color(0xFF5D3A26)]),
                  ),
                  child: ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool isPassword = false, bool isHidden = false, VoidCallback? onToggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? isHidden : false,
          validator: (value) {
            if (value == null || value.isEmpty) return "Please enter $label";
            if (isPassword && value.length < 6) return "Password too short";
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: isPassword 
                ? IconButton(
                    icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility, color: Color(0xFF5D3A26)),
                    onPressed: onToggle,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}