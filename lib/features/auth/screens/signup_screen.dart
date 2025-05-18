import 'package:flutter/material.dart';
import 'package:app_aya_v2/features/auth/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_acceptTerms) {
      setState(() {
        _errorMessage =
            'Você precisa aceitar os Termos de Uso e Política de Privacidade.';
      });
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await AuthService().signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {'name': _nameController.text.trim()},
      );
      if (!mounted) return;
      _showSignupSuccessAndNavigate();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSignupSuccessAndNavigate() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
              'Cadastro realizado! Verifique seu e-mail para ativar a conta.')),
    );
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _handleGoogleSignIn() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await AuthService().signInWithGoogle();
      if (!mounted) return;
      _navigateToDashboard();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAppleSignIn() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await AuthService().signInWithApple();
      if (!mounted) return;
      _navigateToDashboard();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2352),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/logo.png', height: 64),
                const SizedBox(height: 32),
                const Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Digite seu nome' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Digite seu email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Senha muito curta' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  validator: (v) => v != _passwordController.text
                      ? 'Senhas não conferem'
                      : null,
                ),
                CheckboxListTile(
                  value: _acceptTerms,
                  onChanged: (v) {
                    setState(() => _acceptTerms = v ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Wrap(
                    children: [
                      const Text('Eu li e aceito os '),
                      GestureDetector(
                        onTap: () {
                          // Abrir Termos de Uso
                        },
                        child: const Text('Termos de Uso',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF78C7B4))),
                      ),
                      const Text(' e a '),
                      GestureDetector(
                        onTap: () {
                          // Abrir Política de Privacidade
                        },
                        child: const Text('Política de Privacidade',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF78C7B4))),
                      ),
                      const Text('.'),
                    ],
                  ),
                  activeColor: const Color(0xFF78C7B4),
                  checkColor: Colors.white,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(_errorMessage!,
                      style: const TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B5CF6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Criar Conta'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_mobiledata,
                          color: Colors.blue, size: 36),
                      onPressed: _isLoading ? null : _handleGoogleSignIn,
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.apple,
                          color: Colors.black, size: 32),
                      onPressed: _isLoading ? null : _handleAppleSignIn,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Já tem conta? Entrar',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDashboard() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
