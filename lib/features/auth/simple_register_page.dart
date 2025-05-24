import 'package:flutter/material.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';

class SimpleRegisterPage extends StatefulWidget {
  const SimpleRegisterPage({super.key});

  @override
  State<SimpleRegisterPage> createState() => _SimpleRegisterPageState();
}

class _SimpleRegisterPageState extends State<SimpleRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;
  bool _isLoading = false;
  String? _errorMessage;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_acceptTerms) {
      setState(() {
        _errorMessage =
            'Você precisa aceitar os Termos de Uso e Política de Privacidade.';
      });
      return;
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _authService.signUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          userMetadata: {
            'name': _nameController.text.trim(),
          },
        );
        if (!mounted) return;
        context.go(AppRouter.dashboard);
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
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AyaColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bem-vindo ao App Aya! Crie sua conta para começar sua jornada.',
                style: TextStyle(
                  color: AyaColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: AyaColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle:
                      TextStyle(color: AyaColors.textPrimary.withAlpha(204)),
                  prefixIcon: Icon(Icons.person, color: AyaColors.turquoise),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AyaColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle:
                      TextStyle(color: AyaColors.textPrimary.withAlpha(204)),
                  prefixIcon: Icon(Icons.email, color: AyaColors.turquoise),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu e-mail';
                  }
                  if (!value.contains('@')) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: AyaColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle:
                      TextStyle(color: AyaColors.textPrimary.withAlpha(204)),
                  prefixIcon: Icon(Icons.lock, color: AyaColors.turquoise),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite uma senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: const TextStyle(color: AyaColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Confirme a senha',
                  labelStyle:
                      TextStyle(color: AyaColors.textPrimary.withAlpha(204)),
                  prefixIcon:
                      Icon(Icons.lock_outline, color: AyaColors.turquoise),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                    activeColor: AyaColors.turquoise,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _acceptTerms = !_acceptTerms),
                      child: Text(
                        'Aceito os Termos de Uso e Política de Privacidade',
                        style: TextStyle(
                          color: AyaColors.textPrimary.withAlpha(217),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _errorMessage!,
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 16),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AyaColors.textPrimary))
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AyaColors.turquoise,
                        foregroundColor: AyaColors.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Criar Conta'),
                    ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                          color: AyaColors.lavenderVibrant.withAlpha(102))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('ou',
                        style: TextStyle(
                            color: AyaColors.textPrimary.withAlpha(153))),
                  ),
                  Expanded(
                      child: Divider(
                          color: AyaColors.lavenderVibrant.withAlpha(102))),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.g_mobiledata,
                        color: AyaColors.turquoise, size: 36),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                              _errorMessage = null;
                            });
                            try {
                              await _authService.signInWithGoogle();
                              // O redirecionamento será tratado pelo Supabase
                            } catch (e) {
                              if (mounted) {
                                setState(() {
                                  _errorMessage = e
                                      .toString()
                                      .replaceFirst('Exception: ', '');
                                });
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon:
                        Icon(Icons.apple, color: AyaColors.turquoise, size: 32),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                              _errorMessage = null;
                            });
                            try {
                              await _authService.signInWithApple();
                              // O redirecionamento será tratado pelo Supabase
                            } catch (e) {
                              if (mounted) {
                                setState(() {
                                  _errorMessage = e
                                      .toString()
                                      .replaceFirst('Exception: ', '');
                                });
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
