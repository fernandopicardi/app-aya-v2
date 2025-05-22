enum ContentType {
  video,
  audio,
  richText,
  pdf,
}

class ComplementaryMaterial {
  final String name;
  final String fileType;
  final String? size;
  final String downloadUrl;

  const ComplementaryMaterial({
    required this.name,
    required this.fileType,
    this.size,
    required this.downloadUrl,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String contentUrl;
  final String thumbnailUrl;
  final String duration;
  final ContentType contentType;
  final String? difficulty;
  final List<ComplementaryMaterial> complementaryMaterials;
  final Lesson? nextLesson;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.contentUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.contentType,
    this.difficulty,
    this.complementaryMaterials = const [],
    this.nextLesson,
  });

  // Mock data for development
  static List<Lesson> getMockLessons() {
    return [
      Lesson(
        id: '1',
        title: 'Introdução à Astrologia',
        description:
            'Nesta aula introdutória, você aprenderá os conceitos fundamentais da astrologia e como ela pode ser uma ferramenta poderosa para autoconhecimento e desenvolvimento pessoal.',
        contentUrl: 'https://example.com/video1.mp4',
        thumbnailUrl: 'https://picsum.photos/800/450',
        duration: '25 min',
        contentType: ContentType.video,
        difficulty: 'Iniciante',
        complementaryMaterials: [
          ComplementaryMaterial(
            name: 'Guia de Estudo - Introdução',
            fileType: 'pdf',
            size: '2.5 MB',
            downloadUrl: 'https://example.com/guide1.pdf',
          ),
        ],
        nextLesson: Lesson(
          id: '2',
          title: 'Os 12 Signos do Zodíaco',
          description:
              'Explore as características e significados dos 12 signos do zodíaco, entendendo como eles influenciam nossa personalidade e comportamento.',
          contentUrl: 'https://example.com/video2.mp4',
          thumbnailUrl: 'https://picsum.photos/800/451',
          duration: '30 min',
          contentType: ContentType.video,
          difficulty: 'Iniciante',
        ),
      ),
      Lesson(
        id: '3',
        title: 'Meditação Guiada para Iniciantes',
        description:
            'Uma meditação guiada suave e relaxante, perfeita para quem está começando sua jornada de mindfulness.',
        contentUrl: 'https://example.com/audio1.mp3',
        thumbnailUrl: 'https://picsum.photos/800/452',
        duration: '15 min',
        contentType: ContentType.audio,
        difficulty: 'Iniciante',
        complementaryMaterials: [
          ComplementaryMaterial(
            name: 'Transcrição da Meditação',
            fileType: 'pdf',
            size: '1.2 MB',
            downloadUrl: 'https://example.com/transcript1.pdf',
          ),
        ],
      ),
      Lesson(
        id: '4',
        title: 'Entendendo seu Mapa Astral',
        description:
            'Um guia detalhado sobre como interpretar seu mapa astral natal, incluindo a posição dos planetas, casas e aspectos.',
        contentUrl: '''
          <h1>Entendendo seu Mapa Astral</h1>
          <p>O mapa astral é um retrato do céu no momento exato do seu nascimento...</p>
          <h2>Elementos do Mapa Astral</h2>
          <ul>
            <li>Planetas</li>
            <li>Signos</li>
            <li>Casas</li>
            <li>Aspectos</li>
          </ul>
        ''',
        thumbnailUrl: 'https://picsum.photos/800/453',
        duration: '45 min',
        contentType: ContentType.richText,
        difficulty: 'Intermediário',
        complementaryMaterials: [
          ComplementaryMaterial(
            name: 'Planilha de Análise',
            fileType: 'xlsx',
            size: '3.1 MB',
            downloadUrl: 'https://example.com/analysis.xlsx',
          ),
        ],
      ),
      Lesson(
        id: '5',
        title: 'Guia Completo de Meditação',
        description:
            'Um guia abrangente sobre diferentes técnicas de meditação e como incorporá-las em sua rotina diária.',
        contentUrl: 'https://example.com/guide.pdf',
        thumbnailUrl: 'https://picsum.photos/800/454',
        duration: '60 min',
        contentType: ContentType.pdf,
        difficulty: 'Intermediário',
        complementaryMaterials: [
          ComplementaryMaterial(
            name: 'Áudio de Meditação',
            fileType: 'mp3',
            size: '15 MB',
            downloadUrl: 'https://example.com/meditation.mp3',
          ),
        ],
      ),
    ];
  }
}
