import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/shared/widgets/gradient_button.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';
import 'package:app_aya_v2/theme/aya_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _authService.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Redirecionar para o dashboard após login bem-sucedido
        if (mounted) {
          context.go(AppRouter.dashboard);
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString().replaceFirst('Exception: ', '');
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AyaColors.background,
              AyaColors.backgroundGradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                // Wrap with Form widget
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Placeholder for App Logo or welcome illustration
                    // Example: Icon(Icons.spa_outlined, size: 80, color: AyaColors.textPrimary80),
                    const SizedBox(height: 20),
                    Text(
                      'Bem-vindo de volta!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AyaColors.textPrimary,
                              fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Faça login para continuar sua jornada.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AyaColors.textPrimary60),
                    ),
                    const SizedBox(height: 32),
                    // Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AyaColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Seu e-mail',
                        hintStyle:
                            const TextStyle(color: AyaColors.textPrimary60),
                        filled: true,
                        fillColor: AyaColors.lavenderSoft30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: AyaColors.textPrimary60),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu e-mail.';
                        }
                        if (!value.contains('@')) {
                          // Simple email validation
                          return 'Por favor, insira um e-mail válido.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: AyaColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Sua senha',
                        hintStyle:
                            const TextStyle(color: AyaColors.textPrimary60),
                        filled: true,
                        fillColor: AyaColors.lavenderSoft30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined,
                            color: AyaColors.textPrimary60),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha.';
                        }
                        if (value.length < 6) {
                          // Example: password min length
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 8),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AyaColors.textPrimary))
                        : GradientButton(
                            text: 'Entrar',
                            onPressed: _signIn,
                          ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.register);
                      },
                      child: Text(
                        'Não tem uma conta? Registre-se',
                        style: TextStyle(color: AyaColors.turquoise),
                      ),
                    ),
                    // TODO: Add "Forgot Password?" option
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.forgotPassword);
                      },
                      child: Text('Esqueceu a senha?',
                          style: TextStyle(color: AyaColors.turquoise)),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
