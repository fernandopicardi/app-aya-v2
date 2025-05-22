import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';
import 'package:app_aya_v2/config/routes.dart';
import 'package:app_aya_v2/shared/widgets/gradient_button.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _message;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _message = null;
      });
      try {
        await _authService.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        setState(() {
          _message =
              'Um e-mail de redefinição de senha foi enviado para ${_emailController.text.trim()}. Verifique sua caixa de entrada.';
          _isSuccess = true;
        });
      } catch (e) {
        setState(() {
          _message = e.toString().replaceFirst('Exception: ', '');
          _isSuccess = false;
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AyaColors.textPrimary),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text('Recuperar Senha',
            style: TextStyle(color: AyaColors.textPrimary)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AyaColors.cardGradientStart,
              AyaColors.cardGradientEnd,
            ],
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
                      'Esqueceu sua senha?',
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
                      'Insira seu e-mail para enviarmos um link de redefinição.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AyaColors.textPrimary.withAlpha(204)),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AyaColors.lavenderVibrant),
                      decoration: InputDecoration(
                        hintText: 'Seu e-mail',
                        hintStyle: TextStyle(
                            color: AyaColors.textPrimary.withAlpha(153)),
                        filled: true,
                        fillColor: AyaColors.lavenderSoft30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: AyaColors.textPrimary.withAlpha(179)),
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
                    const SizedBox(height: 24),
                    if (_message != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          _message!,
                          style: TextStyle(
                              color:
                                  _isSuccess ? Colors.green : Colors.redAccent,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 8),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AyaColors.textPrimary))
                        : GradientButton(
                            text: 'Enviar Link',
                            onPressed: _sendPasswordResetEmail,
                          ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.login);
                      },
                      child: Text(
                        'Voltar para o Login',
                        style: TextStyle(color: AyaColors.buttonSecondary),
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
