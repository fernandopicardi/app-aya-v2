import 'package:flutter/material.dart';
import 'package:app_aya_v2/features/auth/auth_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await AuthService().signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B2352), Color(0xFF3B3B98)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isWide
                ? Row(
                    children: [
                      // Esquerda: Vídeo e mensagem
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sua Jornada Começa Agora.',
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 32),
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(51),
                                            blurRadius: 12,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          color: Colors.grey[800],
                                          child: const Center(
                                            child: Icon(
                                              Icons.play_circle_fill,
                                              color: Colors.white,
                                              size: 64,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Transforme sua rotina com meditações, jornadas de autoconhecimento e uma comunidade acolhedora.',
                                style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Direita: Login e ações
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 48, horizontal: 32),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(230),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Logo',
                                    style: TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'Acesse sua Conta',
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              // Login form simplificado
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  filled: true,
                                  fillColor: Colors.white.withAlpha(230),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              if (_errorMessage != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  _errorMessage!,
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forgot');
                                  },
                                  child: const Text('Esqueceu sua senha?',
                                      style:
                                          TextStyle(color: Color(0xFF78C7B4))),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: _isLoading ? null : _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7B5CF6),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Entrar'),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _isLoading
                                          ? null
                                          : () async {
                                              try {
                                                setState(
                                                    () => _isLoading = true);
                                                await AuthService()
                                                    .signInWithGoogle();
                                                if (!mounted) return;
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/dashboard');
                                              } catch (e) {
                                                if (!mounted) return;
                                                setState(() {
                                                  _errorMessage = e
                                                      .toString()
                                                      .replaceFirst(
                                                          'Exception: ', '');
                                                });
                                              } finally {
                                                if (mounted)
                                                  setState(
                                                      () => _isLoading = false);
                                              }
                                            },
                                      icon: const Icon(Icons.g_mobiledata,
                                          color: Color(0xFF78C7B4)),
                                      label: const Text('Entrar com Google',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Color(0xFF78C7B4)),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _isLoading
                                          ? null
                                          : () async {
                                              try {
                                                setState(
                                                    () => _isLoading = true);
                                                await AuthService()
                                                    .signInWithApple();
                                                if (!mounted) return;
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/dashboard');
                                              } catch (e) {
                                                if (!mounted) return;
                                                setState(() {
                                                  _errorMessage = e
                                                      .toString()
                                                      .replaceFirst(
                                                          'Exception: ', '');
                                                });
                                              } finally {
                                                if (mounted)
                                                  setState(
                                                      () => _isLoading = false);
                                              }
                                            },
                                      icon: const Icon(Icons.apple,
                                          color: Colors.white),
                                      label: const Text('Apple',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Divider(
                                  color: Colors.black.withAlpha(51),
                                  thickness: 1),
                              const SizedBox(height: 16),
                              const Text(
                                'Novo por aqui?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/plans');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF78C7B4),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Criar Conta Gratuita'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 32),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Logo',
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Sua Jornada Começa Agora.',
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(51),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      color: Colors.grey[800],
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 64,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Transforme sua rotina com meditações, jornadas de autoconhecimento e uma comunidade acolhedora.',
                            style: TextStyle(
                              fontFamily: 'Sans',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          // Login form simplificado
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              fillColor: Colors.white.withAlpha(230),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              filled: true,
                              fillColor: Colors.white.withAlpha(230),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 16),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.redAccent),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgot');
                              },
                              child: const Text('Esqueceu sua senha?',
                                  style: TextStyle(color: Color(0xFF78C7B4))),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _login,
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
                                : const Text('Entrar'),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          try {
                                            setState(() => _isLoading = true);
                                            await AuthService()
                                                .signInWithGoogle();
                                            if (!mounted) return;
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/dashboard');
                                          } catch (e) {
                                            if (!mounted) return;
                                            setState(() {
                                              _errorMessage = e
                                                  .toString()
                                                  .replaceFirst(
                                                      'Exception: ', '');
                                            });
                                          } finally {
                                            if (mounted)
                                              setState(
                                                  () => _isLoading = false);
                                          }
                                        },
                                  icon: const Icon(Icons.g_mobiledata,
                                      color: Color(0xFF78C7B4)),
                                  label: const Text('Entrar com Google',
                                      style: TextStyle(color: Colors.white)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF78C7B4)),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          try {
                                            setState(() => _isLoading = true);
                                            await AuthService()
                                                .signInWithApple();
                                            if (!mounted) return;
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/dashboard');
                                          } catch (e) {
                                            if (!mounted) return;
                                            setState(() {
                                              _errorMessage = e
                                                  .toString()
                                                  .replaceFirst(
                                                      'Exception: ', '');
                                            });
                                          } finally {
                                            if (mounted)
                                              setState(
                                                  () => _isLoading = false);
                                          }
                                        },
                                  icon: const Icon(Icons.apple,
                                      color: Colors.white),
                                  label: const Text('Apple',
                                      style: TextStyle(color: Colors.white)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.white),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Divider(
                              color: Colors.black.withAlpha(51), thickness: 1),
                          const SizedBox(height: 16),
                          const Text(
                            'Novo por aqui?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/plans');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78C7B4),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Criar Conta Gratuita'),
                          ),
                          const SizedBox(height: 32),
                          Divider(
                              color: Colors.black.withAlpha(51), thickness: 1),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('Termos de Uso',
                                    style: TextStyle(color: Colors.white70)),
                              ),
                              const Text(' | ',
                                  style: TextStyle(color: Colors.white38)),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Política de Privacidade',
                                    style: TextStyle(color: Colors.white70)),
                              ),
                              const Text(' | ',
                                  style: TextStyle(color: Colors.white38)),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Ajuda/FAQ',
                                    style: TextStyle(color: Colors.white70)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('© 2024 Caminho Aya',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 13),
                              textAlign: TextAlign.center),
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
