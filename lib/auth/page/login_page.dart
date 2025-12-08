import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/glitter_particles.dart';
import '../../shared/widgets/kawaii_planet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSignUpMode = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email 📧';
    }
    if (!value.contains('@')) {
      return 'Email must contain @ symbol ✉️';
    }
    if (!value.contains('.') || value.split('@').length != 2) {
      return 'Please enter a valid email format 📮';
    }
    final emailParts = value.split('@');
    if (emailParts[0].isEmpty || emailParts[1].isEmpty) {
      return 'Please enter a valid email format 💌';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password 🔒';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters 🔐';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (!_isSignUpMode) return null;
    if (value == null || value.isEmpty) {
      return 'Please confirm your password 🔑';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match! ✨ Please try again 💫';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.message} 💫'),
                backgroundColor: AppTheme.spacePink,
              ),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.spaceDark,
                    AppTheme.spaceDark.withOpacity(0.8),
                    AppTheme.spacePurple.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            GlitterParticles(
              particleCount: 30,
              color: AppTheme.spacePink.withOpacity(0.8),
              speed: 0.8,
            ),
            FloatingPlanets(
              planetCount: 3,
              emojis: ['🌍', '🪐', '⭐'],
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KawaiiPlanet(
                                size: 80,
                                planetColor: AppTheme.spacePurple,
                                emoji: '🚀',
                                hasFace: true,
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                '✨',
                                style: TextStyle(fontSize: 40),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Pixel Space 🌌',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              shadows: [
                                Shadow(
                                  color: AppTheme.spacePink.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Welcome to the cosmos! ⭐✨💫',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 48),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email 📧',
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    suffixIcon: const Text('✨', style: TextStyle(fontSize: 20)),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _validateEmail,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password 🔒',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: const Text('💫', style: TextStyle(fontSize: 20)),
                                  ),
                                  obscureText: true,
                                  validator: _validatePassword,
                                  onChanged: (_) {
                                    if (_isSignUpMode) {
                                      _formKey.currentState?.validate();
                                    }
                                  },
                                ),
                                if (_isSignUpMode) ...[
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password 🔐',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      suffixIcon: const Text('✨', style: TextStyle(fontSize: 20)),
                                    ),
                                    obscureText: true,
                                    validator: _validateConfirmPassword,
                                  ),
                                ],
                                const SizedBox(height: 24),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isSignUpMode = !_isSignUpMode;
                                      _confirmPasswordController.clear();
                                      _formKey.currentState?.reset();
                                    });
                                  },
                                  child: Text(
                                    _isSignUpMode
                                        ? 'Already have an account? Login here! 🌟'
                                        : 'New here? Sign up! ✨',
                                    style: TextStyle(
                                      color: AppTheme.spacePink,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: state is AuthLoading
                                            ? null
                                            : () {
                                                if (_formKey.currentState!.validate()) {
                                                  if (_isSignUpMode && 
                                                      _passwordController.text != 
                                                      _confirmPasswordController.text) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: const Text(
                                                          'Passwords do not match! ✨ Please try again 💫',
                                                        ),
                                                        backgroundColor: AppTheme.spacePink,
                                                      ),
                                                    );
                                                    return;
                                                  }
                                                  context.read<AuthBloc>().add(
                                                        AuthLoginRequested(
                                                          email: _emailController.text.trim(),
                                                          password: _passwordController.text,
                                                        ),
                                                      );
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.spacePink,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: state is AuthLoading
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                _isSignUpMode 
                                                    ? 'Sign Up & Launch! 🚀✨' 
                                                    : 'Launch! 🚀✨',
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  ['🌍', '🪐', '⭐', '🌟', '💫'][index],
                                  style: const TextStyle(fontSize: 24),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

