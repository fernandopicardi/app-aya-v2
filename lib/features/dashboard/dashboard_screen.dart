import 'package:flutter/material.dart';
import 'package:app_aya_v2/features/auth/services/auth_service.dart';
import 'package:app_aya_v2/features/dashboard/services/dashboard_service.dart';
import 'package:app_aya_v2/features/dashboard/widgets/dashboard_widgets.dart';
import 'package:app_aya_v2/features/dashboard/models/dashboard_models.dart';
import 'package:app_aya_v2/features/admin/screens/admin_dashboard_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardService = DashboardService();
  final _authService = AuthService();
  bool _isLoading = true;
  late DashboardData _data;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final userProfile = await _authService.getCurrentUserProfile();
      _isAdmin = userProfile?['role'] == 'admin';
      _data = await _dashboardService.getDashboardData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar dados: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AYA'),
        actions: [
          if (_isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminDashboardScreen(),
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  WelcomeCard(
                    userName: _data.userName,
                    tipOfTheDay: _data.tipOfTheDay,
                  ),
                  const SizedBox(height: 24),
                  ContinueJourneyCard(
                    lastLesson: _data.lastLesson,
                  ),
                  const SizedBox(height: 24),
                  RecommendedLessonsCard(
                    lessons: _data.recommendedLessons,
                  ),
                  const SizedBox(height: 24),
                  ExploreModulesCard(
                    modules: _data.exploreModules,
                  ),
                  const SizedBox(height: 24),
                  if (_data.favoriteLessons.isNotEmpty) ...[
                    FavoriteLessonsCard(
                      lessons: _data.favoriteLessons,
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (_data.activeChallenge != null) ...[
                    ActiveChallengeCard(
                      challenge: _data.activeChallenge!,
                    ),
                    const SizedBox(height: 24),
                  ],
                  ConnectWithAyaCard(),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
