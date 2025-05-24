class MockModule {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final List<MockFolder>? folders;
  final List<MockLesson>? lessons;

  MockModule({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    this.folders,
    this.lessons,
  });
}

class MockFolder {
  final String id;
  final String title;
  final String thumbnailUrl;
  final List<MockLesson>? lessons;
  final List<MockSubFolder>? subFolders;

  MockFolder({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.lessons,
    this.subFolders,
  });
}

class MockSubFolder {
  final String id;
  final String title;
  final String thumbnailUrl;
  final List<MockLesson> lessons;

  MockSubFolder({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.lessons,
  });
}

class MockLesson {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int durationMinutes;
  final bool isPremium;

  MockLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.durationMinutes,
    this.isPremium = false,
  });
}

// Mock data
final List<MockModule> mockModules = [
  MockModule(
    id: '1',
    title: 'Meditação para Iniciantes',
    description:
        'Aprenda técnicas básicas de meditação para começar sua jornada',
    thumbnailUrl: 'https://picsum.photos/seed/meditation1/800/400',
    folders: [
      MockFolder(
        id: '1-1',
        title: 'Fundamentos da Meditação',
        thumbnailUrl: 'https://picsum.photos/seed/meditation2/400/300',
        lessons: [
          MockLesson(
            id: '1-1-1',
            title: 'Introdução à Meditação',
            description: 'Conheça os princípios básicos da meditação',
            thumbnailUrl: 'https://picsum.photos/seed/meditation3/400/300',
            durationMinutes: 15,
          ),
          MockLesson(
            id: '1-1-2',
            title: 'Técnicas de Respiração',
            description: 'Aprenda a respirar corretamente durante a meditação',
            thumbnailUrl: 'https://picsum.photos/seed/meditation4/400/300',
            durationMinutes: 20,
          ),
        ],
      ),
      MockFolder(
        id: '1-2',
        title: 'Meditações Guiadas',
        thumbnailUrl: 'https://picsum.photos/seed/meditation5/400/300',
        lessons: [
          MockLesson(
            id: '1-2-1',
            title: 'Meditação para Ansiedade',
            description: 'Técnicas específicas para reduzir a ansiedade',
            thumbnailUrl: 'https://picsum.photos/seed/meditation6/400/300',
            durationMinutes: 25,
            isPremium: true,
          ),
        ],
      ),
    ],
  ),
  MockModule(
    id: '2',
    title: 'Yoga para o Dia a Dia',
    description: 'Pratique yoga em casa com aulas para todos os níveis',
    thumbnailUrl: 'https://picsum.photos/seed/yoga1/800/400',
    lessons: [
      MockLesson(
        id: '2-1',
        title: 'Yoga Matinal',
        description: 'Sequência de poses para começar o dia com energia',
        thumbnailUrl: 'https://picsum.photos/seed/yoga2/400/300',
        durationMinutes: 30,
      ),
      MockLesson(
        id: '2-2',
        title: 'Yoga para Relaxamento',
        description: 'Poses suaves para relaxar no final do dia',
        thumbnailUrl: 'https://picsum.photos/seed/yoga3/400/300',
        durationMinutes: 45,
        isPremium: true,
      ),
    ],
  ),
  MockModule(
    id: '3',
    title: 'Mindfulness no Trabalho',
    description:
        'Aprenda a praticar mindfulness durante sua jornada de trabalho',
    thumbnailUrl: 'https://picsum.photos/seed/mindfulness1/800/400',
    folders: [
      MockFolder(
        id: '3-1',
        title: 'Exercícios Rápidos',
        thumbnailUrl: 'https://picsum.photos/seed/mindfulness2/400/300',
        lessons: [
          MockLesson(
            id: '3-1-1',
            title: 'Respiração Consciente',
            description: 'Técnica de 2 minutos para acalmar a mente',
            thumbnailUrl: 'https://picsum.photos/seed/mindfulness3/400/300',
            durationMinutes: 5,
          ),
        ],
      ),
    ],
  ),
];
