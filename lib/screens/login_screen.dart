import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
   
      String username = _usernameController.text.trim();
      debugPrint("Attempting login for: $username");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
        
          Positioned.fill(
            child: Image.asset(
              'assets/login_bg.png',
              fit: BoxFit.cover, 
              errorBuilder: (context, error, stackTrace) {
              
                return Container(color: Colors.brown.shade100); 
              },
            ),
          ),

          
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),

         
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, 
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95), 
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/logo.jpeg', 
                              height: 60,
                              errorBuilder: (ctx, err, st) => Icon(Icons.coffee, size: 50, color: Color(0xFF6F4436)),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D2226),
                            ),
                          ),
                          Text(
                            "Please sign in to continue",
                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      
                  
                      _buildTextField(
                        controller: _usernameController,
                        label: "Username",
                        hint: "Enter your username",
                        icon: Icons.person_outline,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController,
                        label: "Password",
                        hint: "Enter your password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      
                      SizedBox(height: 35),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6F4436),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New user? ", style: TextStyle(color: Colors.grey[700])),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
                              );
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(
                                color: Color(0xFF6F4436),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
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
        ],
      ),
    );
  }

  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? !_isPasswordVisible : false,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Field cannot be empty';
            if (isPassword && value.length < 6) return 'Minimum 6 characters required';
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Color(0xFF6F4436)),
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                )
              : null,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }
}