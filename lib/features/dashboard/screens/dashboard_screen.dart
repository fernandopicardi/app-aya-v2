import 'package:flutter/material.dart';
import '../../../features/auth/services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _authService = AuthService();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildLessonsTab(),
          _buildChallengesTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle),
            label: 'Aulas',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Desafios',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildWelcomeCard(),
        const SizedBox(height: 16),
        _buildProgressCard(),
        const SizedBox(height: 16),
        _buildNextLessonsCard(),
        const SizedBox(height: 16),
        _buildChallengesCard(),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo(a)!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Continue sua jornada de aprendizado',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seu Progresso',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '70% completo',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextLessonsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Próximas Aulas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.play_circle),
                  ),
                  title: Text('Aula ${index + 1}'),
                  subtitle: Text('Descrição da aula ${index + 1}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navegar para a aula
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desafios Disponíveis',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.emoji_events),
                  ),
                  title: Text('Desafio ${index + 1}'),
                  subtitle: Text('Descrição do desafio ${index + 1}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navegar para o desafio
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildModuleCard(
          'Módulo 1: Introdução',
          'Aprenda os conceitos básicos',
          [
            _buildLessonItem('Aula 1: Introdução', '15 min'),
            _buildLessonItem('Aula 2: Fundamentos', '20 min'),
            _buildLessonItem('Aula 3: Prática', '25 min'),
          ],
        ),
        const SizedBox(height: 16),
        _buildModuleCard(
          'Módulo 2: Intermediário',
          'Avançe seus conhecimentos',
          [
            _buildLessonItem('Aula 1: Conceitos Avançados', '30 min'),
            _buildLessonItem('Aula 2: Técnicas', '35 min'),
            _buildLessonItem('Aula 3: Projeto', '40 min'),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(
    String title,
    String description,
    List<Widget> lessons,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ...lessons,
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(String title, String duration) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.play_circle),
      ),
      title: Text(title),
      subtitle: Text(duration),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Navegar para a aula
      },
    );
  }

  Widget _buildChallengesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildChallengeCard(
          'Desafio 1: Básico',
          'Complete este desafio para testar seus conhecimentos básicos',
          'Fácil',
          Colors.green,
        ),
        const SizedBox(height: 16),
        _buildChallengeCard(
          'Desafio 2: Intermediário',
          'Avançe para o próximo nível com este desafio',
          'Médio',
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildChallengeCard(
          'Desafio 3: Avançado',
          'Teste seus conhecimentos avançados',
          'Difícil',
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
    String title,
    String description,
    String difficulty,
    Color difficultyColor,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      difficultyColor.red,
                      difficultyColor.green,
                      difficultyColor.blue,
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      color: difficultyColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Iniciar desafio
              },
              child: const Text('Iniciar Desafio'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 16),
        _buildProfileSection(
          'Informações Pessoais',
          [
            _buildProfileItem(Icons.person, 'Nome', 'Usuário'),
            _buildProfileItem(Icons.email, 'Email', 'usuario@email.com'),
            _buildProfileItem(
                Icons.calendar_today, 'Membro desde', '01/01/2024'),
          ],
        ),
        const SizedBox(height: 16),
        _buildProfileSection(
          'Estatísticas',
          [
            _buildProfileItem(Icons.play_circle, 'Aulas Completadas', '15'),
            _buildProfileItem(Icons.emoji_events, 'Desafios Concluídos', '8'),
            _buildProfileItem(Icons.star, 'Badges', '5'),
          ],
        ),
        const SizedBox(height: 16),
        _buildProfileSection(
          'Configurações',
          [
            _buildProfileItem(Icons.notifications, 'Notificações', ''),
            _buildProfileItem(Icons.language, 'Idioma', 'Português'),
            _buildProfileItem(Icons.help, 'Ajuda', ''),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              'Usuário',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'usuario@email.com',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: value.isNotEmpty
          ? Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Navegar para a configuração
      },
    );
  }
}
