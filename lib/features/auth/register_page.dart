import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/shared/widgets/gradient_button.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _authService.register(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (!mounted) return;
        GoRouter.of(context).go(AppRouter.login);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registro realizado com sucesso! Faça o login.')),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _errorMessage = e.toString().replaceFirst('Exception: ', '');
        });
      } finally {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Crie sua conta',
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
                      'Comece sua jornada de autoconhecimento.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AyaColors.textPrimary60),
                    ),
                    const SizedBox(height: 32),
                    // Name field (Optional, can be added)
                    // TextField(
                    //   style: const TextStyle(color: AyaColors.textPrimary),
                    //   decoration: InputDecoration(
                    //     hintText: 'Seu nome',
                    //     hintStyle: TextStyle(color: AyaColors.textPrimary60),
                    //     filled: true,
                    //     fillColor: AyaColors.lavenderSoft30,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //     prefixIcon: Icon(Icons.person_outline, color: AyaColors.textPrimary60),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
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
                        hintText: 'Crie uma senha',
                        hintStyle:
                            const TextStyle(color: AyaColors.textPrimary60),
                        filled: true,
                        fillColor: AyaColors.lavenderSoft30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AyaColors.textPrimary60),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, crie uma senha.';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      style: const TextStyle(color: AyaColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Confirme sua senha',
                        hintStyle:
                            const TextStyle(color: AyaColors.textPrimary60),
                        filled: true,
                        fillColor: AyaColors.lavenderSoft30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AyaColors.textPrimary60),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, confirme sua senha.';
                        }
                        if (value != _passwordController.text) {
                          return 'As senhas não coincidem.';
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
                            text: 'Registrar',
                            onPressed: _signUp,
                          ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.login);
                      },
                      child: Text(
                        'Já tem uma conta? Faça login',
                        style: TextStyle(color: AyaColors.turquoise),
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
}
