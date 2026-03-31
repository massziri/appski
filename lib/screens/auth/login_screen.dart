import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  String? _error;
  String _loadingProvider = '';

  // Email form controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isRegistering = false;
  bool _showEmailForm = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _checkRedirectResult();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _checkRedirectResult() async {
    try {
      final result = await FirebaseAuth.instance.getRedirectResult();
      if (result.user != null && mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Sign-in redirect failed. Please try again.');
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _loading = true;
      _loadingProvider = 'google';
      _error = null;
    });

    try {
      final provider = GoogleAuthProvider()
        ..setCustomParameters({'prompt': 'select_account'});

      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithRedirect(provider);
      } else {
        await FirebaseAuth.instance.signInWithPopup(provider);
        if (mounted) context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() => _error = e.message ?? 'Google sign-in failed.');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Google sign-in could not be completed.');
      }
    } finally {
      if (mounted) setState(() { _loading = false; _loadingProvider = ''; });
    }
  }

  Future<void> _signInWithFacebook() async {
    setState(() {
      _loading = true;
      _loadingProvider = 'facebook';
      _error = null;
    });

    try {
      final provider = FacebookAuthProvider();
      provider.addScope('email');
      provider.addScope('public_profile');

      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithRedirect(provider);
      } else {
        await FirebaseAuth.instance.signInWithPopup(provider);
        if (mounted) context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String msg = e.message ?? 'Facebook sign-in failed.';
        if (e.code == 'account-exists-with-different-credential') {
          msg = 'An account already exists with this email using a different sign-in method. Try Google or Email login.';
        }
        setState(() => _error = msg);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Facebook sign-in could not be completed.');
      }
    } finally {
      if (mounted) setState(() { _loading = false; _loadingProvider = ''; });
    }
  }

  Future<void> _signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Please enter email and password.');
      return;
    }
    if (_isRegistering && password.length < 6) {
      setState(() => _error = 'Password must be at least 6 characters.');
      return;
    }

    setState(() {
      _loading = true;
      _loadingProvider = 'email';
      _error = null;
    });

    try {
      if (_isRegistering) {
        final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (name.isNotEmpty) {
          await cred.user?.updateDisplayName(name);
        }
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      if (mounted) context.go('/home');
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'user-not-found':
          msg = 'No account found with this email. Try registering.';
          break;
        case 'wrong-password':
          msg = 'Incorrect password. Please try again.';
          break;
        case 'invalid-credential':
          msg = 'Invalid email or password. Please try again.';
          break;
        case 'email-already-in-use':
          msg = 'An account already exists with this email. Try logging in.';
          break;
        case 'weak-password':
          msg = 'Password is too weak. Use at least 6 characters.';
          break;
        case 'invalid-email':
          msg = 'Please enter a valid email address.';
          break;
        default:
          msg = e.message ?? 'Authentication failed.';
      }
      if (mounted) setState(() => _error = msg);
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Sign-in failed. Please try again.');
      }
    } finally {
      if (mounted) setState(() { _loading = false; _loadingProvider = ''; });
    }
  }

  Widget _buildSocialButton({
    required String label,
    required String icon,
    required Color bgColor,
    required Color fgColor,
    required VoidCallback? onPressed,
    required String providerId,
  }) {
    final isThisLoading = _loading && _loadingProvider == providerId;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        icon: isThisLoading
            ? SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
              )
            : Text(icon, style: TextStyle(fontSize: 20, color: fgColor)),
        label: Text(
          isThisLoading ? 'Signing in...' : label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/branding/splash_bg.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x0D000000), Color(0xCC000000)],
                stops: [0.1, 1],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom - 56,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title area
                    const Text(
                      'Welcome to Appski.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Connecting the Macedonian People',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // --- Social Login Buttons ---
                    _buildSocialButton(
                      label: 'Continue with Google',
                      icon: 'G',
                      bgColor: Colors.white,
                      fgColor: const Color(0xFF202124),
                      onPressed: _signInWithGoogle,
                      providerId: 'google',
                    ),
                    const SizedBox(height: 10),
                    _buildSocialButton(
                      label: 'Continue with Facebook',
                      icon: 'f',
                      bgColor: const Color(0xFF1877F2),
                      fgColor: Colors.white,
                      onPressed: _signInWithFacebook,
                      providerId: 'facebook',
                    ),
                    const SizedBox(height: 10),

                    // --- Email/Password Section ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _loading
                            ? null
                            : () => setState(() {
                                  _showEmailForm = !_showEmailForm;
                                  _error = null;
                                }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.email_outlined, size: 20),
                        label: Text(
                          _showEmailForm
                              ? 'Hide Email Login'
                              : 'Login/Create Appski Account',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    // Email Form (collapsible)
                    if (_showEmailForm) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            if (_isRegistering) ...[
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Full Name (optional)',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                  prefixIcon: Icon(Icons.person_outline,
                                      color: Colors.white.withOpacity(0.7)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.3)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.white.withOpacity(0.7)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.white.withOpacity(0.7)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                              ),
                              onSubmitted: (_) => _signInWithEmail(),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _signInWithEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD85F22),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: _loading && _loadingProvider == 'email'
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white),
                                      )
                                    : Text(
                                        _isRegistering
                                            ? 'Create Account'
                                            : 'Sign In',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => setState(() {
                                _isRegistering = !_isRegistering;
                                _error = null;
                              }),
                              child: Text(
                                _isRegistering
                                    ? 'Already have an account? Sign In'
                                    : "Don't have an account? Register",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 14),

                    // --- Continue without login ---
                    OutlinedButton(
                      onPressed: _loading ? null : () => context.go('/home'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: Colors.white.withOpacity(0.5), width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Continue without login',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),

                    // Error display
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0x33FF0000),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                              color: Color(0xFFFFD7D7), fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
