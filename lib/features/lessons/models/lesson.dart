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
      // Vídeos
      Lesson(
        id: '1',
        title: 'Introdução à Astrologia',
        description:
            'Nesta aula introdutória, você aprenderá os conceitos fundamentais da astrologia e como ela pode ser uma ferramenta poderosa para autoconhecimento e desenvolvimento pessoal.',
        contentUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
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
          contentUrl:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          thumbnailUrl: 'https://picsum.photos/800/451',
          duration: '30 min',
          contentType: ContentType.video,
          difficulty: 'Iniciante',
        ),
      ),

      // Áudios
      Lesson(
        id: '3',
        title: 'Meditação Guiada para Iniciantes',
        description:
            'Uma meditação guiada suave e relaxante, perfeita para quem está começando sua jornada de mindfulness.',
        contentUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
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
        title: 'Sons da Natureza para Relaxamento',
        description:
            'Uma coleção de sons naturais para ajudar na concentração e relaxamento durante suas práticas de meditação.',
        contentUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        thumbnailUrl: 'https://picsum.photos/800/453',
        duration: '20 min',
        contentType: ContentType.audio,
        difficulty: 'Iniciante',
      ),

      // Textos Ricos
      Lesson(
        id: '5',
        title: 'Entendendo seu Mapa Astral',
        description:
            'Um guia detalhado sobre como interpretar seu mapa astral natal, incluindo a posição dos planetas, casas e aspectos.',
        contentUrl: '''
# Entendendo seu Mapa Astral

O mapa astral é um retrato do céu no momento exato do seu nascimento. Ele revela informações importantes sobre sua personalidade, talentos, desafios e propósito de vida.

## Elementos do Mapa Astral

### Planetas
- **Sol**: Representa sua essência e propósito de vida
- **Lua**: Rege suas emoções e necessidades internas
- **Mercúrio**: Controla sua comunicação e forma de pensar
- **Vênus**: Influencia seus relacionamentos e valores
- **Marte**: Representa sua energia e forma de agir

### Signos
Os 12 signos do zodíaco representam diferentes qualidades e características:

1. Áries: Iniciativa e coragem
2. Touro: Estabilidade e sensualidade
3. Gêmeos: Comunicação e adaptabilidade
4. Câncer: Emoção e proteção
5. Leão: Criatividade e liderança
6. Virgem: Análise e serviço

### Casas
As 12 casas astrológicas representam diferentes áreas da vida:

> A primeira casa representa sua personalidade e aparência física
> A sétima casa representa seus relacionamentos e parcerias
> A décima casa representa sua carreira e propósito profissional

### Aspectos
Os aspectos são os ângulos formados entre os planetas:

| Aspecto | Ângulo | Influência |
|---------|--------|------------|
| Conjunção | 0° | Fusão de energias |
| Oposição | 180° | Tensão e polaridade |
| Trígono | 120° | Harmonia e fluidez |
| Quadratura | 90° | Desafio e crescimento |

## Como Interpretar seu Mapa

1. Identifique os planetas em seus signos
2. Observe as casas onde os planetas estão
3. Analise os aspectos entre os planetas
4. Considere o contexto geral do mapa

> **Dica**: Mantenha um diário astrológico para registrar suas observações e insights.

## Recursos Adicionais

- [Calculadora de Mapa Astral](https://example.com/calculator)
- [Glossário Astrológico](https://example.com/glossary)
- [Biblioteca de Aspectos](https://example.com/aspects)
''',
        thumbnailUrl: 'https://picsum.photos/800/454',
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

      // PDFs
      Lesson(
        id: '6',
        title: 'Guia Completo de Meditação',
        description:
            'Um guia abrangente sobre diferentes técnicas de meditação e como incorporá-las em sua rotina diária.',
        contentUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl: 'https://picsum.photos/800/455',
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
      Lesson(
        id: '7',
        title: 'Manual de Práticas Espirituais',
        description:
            'Um manual detalhado com práticas espirituais para diferentes níveis de experiência.',
        contentUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        thumbnailUrl: 'https://picsum.photos/800/456',
        duration: '90 min',
        contentType: ContentType.pdf,
        difficulty: 'Avançado',
        complementaryMaterials: [
          ComplementaryMaterial(
            name: 'Guia de Mantras',
            fileType: 'pdf',
            size: '4.2 MB',
            downloadUrl: 'https://example.com/mantras.pdf',
          ),
        ],
      ),
    ];
  }
}
