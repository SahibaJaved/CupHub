import 'package:flutter/material.dart';
<<<<<<< HEAD

import '../services/auth_service.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'admin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final Color primaryColor = const Color(0xFF6F4436);
  final AuthService _authService = AuthService();

  // EMAIL LOGIN
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isLoading = true);

      final user = await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed: User not found")),
        );
        return;
      }

      final isAdmin = _authService.isAdmin(user.email);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isAdmin ? const AdminScreen() : const HomeScreen(),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected error: ${e.toString()}"),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // GOOGLE LOGIN WITH EMAIL ACCOUNT PICKER
  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      // Show account picker by forcing sign out first
      final user = await _authService.signInWithGoogle(
        forceAccountPicker: true,
      );

      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Google Sign-In cancelled"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // ✅ Show selected email
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signed in as: ${user.email}"),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 2),
        ),
      );

      final isAdmin = _authService.isAdmin(user.email);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isAdmin ? const AdminScreen() : const HomeScreen(),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google Sign-In Error: ${e.toString()}"),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
    }
  }

  @override
  void dispose() {
<<<<<<< HEAD
    _emailController.dispose();
=======
    _usernameController.dispose();
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/login_bg.png', fit: BoxFit.cover),
            ),

            Container(color: Colors.black.withValues(alpha: 0.2)),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 420),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/logo.jpeg',
                          height: size.height * 0.08,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Login to continue",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),

                        const SizedBox(height: 30),

                        _buildTextField(
                          controller: _emailController,
                          label: "Email",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 18),

                        _buildTextField(
                          controller: _passwordController,
                          label: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text("OR"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: _isLoading ? null : _signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://developers.google.com/identity/images/g-logo.png',
                                  height: 24,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
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
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }

        if (label == "Email" && !_isValidEmail(value.trim())) {
          return "Enter valid email";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  bool _isValidEmail(String value) {
    final atIndex = value.indexOf('@');
    final dotIndex = value.lastIndexOf('.');
    return atIndex > 0 && dotIndex > atIndex + 1 && dotIndex < value.length - 1;
  }
}
=======
  
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
