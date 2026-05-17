import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../services/auth_service.dart';
=======
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
import 'login_screen.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
<<<<<<< HEAD
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
=======
  @override
  _SignupScreenState createState() => _SignupScreenState();
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
<<<<<<< HEAD
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      final user = await _authService.signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        displayName: _fullNameController.text.trim(),
      );

      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signup failed: Could not create user"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created for ${user.email}"),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to home after brief delay
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
          content: Text("Signup error: ${e.toString()}"),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
=======
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
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
<<<<<<< HEAD
    _emailController.dispose();
=======
    _usernameController.dispose();
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFFD8BBA9),
=======
      backgroundColor: Color(0xFFE6D2C1),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
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
<<<<<<< HEAD
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B2C20),
                  ),
                ),
                SizedBox(height: 40),

                _buildInputField("Full Name", _fullNameController),
                _buildInputField("Email", _emailController, isEmail: true),

                _buildInputField(
                  "Password",
                  _passwordController,
                  isPassword: true,
                  isHidden: _isPasswordHidden,
                  onToggle: () =>
                      setState(() => _isPasswordHidden = !_isPasswordHidden),
                ),

                _buildInputField(
                  "Confirm Password",
                  _confirmPasswordController,
                  isPassword: true,
                  isHidden: _isConfirmPasswordHidden,
                  onToggle: () => setState(
                    () => _isConfirmPasswordHidden = !_isConfirmPasswordHidden,
                  ),
                ),

                SizedBox(height: 30),

=======
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
                
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
<<<<<<< HEAD
                    gradient: LinearGradient(
                      colors: [Color(0xFFC68A5F), Color(0xFF5D3A26)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            "Signup",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

=======
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
                
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
<<<<<<< HEAD
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
=======
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
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

<<<<<<< HEAD
  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool isEmail = false,
    bool isHidden = false,
    VoidCallback? onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
=======
  Widget _buildInputField(String label, TextEditingController controller, {bool isPassword = false, bool isHidden = false, VoidCallback? onToggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? isHidden : false,
          validator: (value) {
            if (value == null || value.isEmpty) return "Please enter $label";
<<<<<<< HEAD
            if (isEmail && !_isValidEmail(value)) {
              return "Please enter a valid email";
            }
=======
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
            if (isPassword && value.length < 6) return "Password too short";
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
<<<<<<< HEAD
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xFF5D3A26),
                    ),
                    onPressed: onToggle,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
=======
            suffixIcon: isPassword 
                ? IconButton(
                    icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility, color: Color(0xFF5D3A26)),
                    onPressed: onToggle,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
<<<<<<< HEAD

  bool _isValidEmail(String value) {
    final atIndex = value.indexOf('@');
    final dotIndex = value.lastIndexOf('.');
    return atIndex > 0 && dotIndex > atIndex + 1 && dotIndex < value.length - 1;
  }
}
=======
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
