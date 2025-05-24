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
        thumbnailUrl: 'https://picsum.photos/seed/lesson1/800/450',
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
          thumbnailUrl: 'https://picsum.photos/seed/lesson2/800/450',
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
        thumbnailUrl: 'https://picsum.photos/seed/lesson3/800/450',
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
        thumbnailUrl: 'https://picsum.photos/seed/lesson4/800/450',
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
<h1>Entendendo seu Mapa Astral</h1>

<p>O mapa astral é um retrato do céu no momento exato do seu nascimento. Ele revela informações importantes sobre sua personalidade, talentos, desafios e propósito de vida.</p>

<h2>Elementos do Mapa Astral</h2>

<h3>Planetas</h3>
<ul>
  <li><strong>Sol</strong>: Representa sua essência e propósito de vida</li>
  <li><strong>Lua</strong>: Rege suas emoções e necessidades internas</li>
  <li><strong>Mercúrio</strong>: Governa sua comunicação e forma de pensar</li>
  <li><strong>Vênus</strong>: Influencia seus relacionamentos e valores</li>
  <li><strong>Marte</strong>: Representa sua energia e forma de agir</li>
  <li><strong>Júpiter</strong>: Expande suas oportunidades e crescimento</li>
  <li><strong>Saturno</strong>: Define seus limites e responsabilidades</li>
</ul>

<h3>Casas Astrológicas</h3>
<p>As 12 casas representam diferentes áreas da vida:</p>
<ol>
  <li>Personalidade e aparência</li>
  <li>Valores e recursos materiais</li>
  <li>Comunicação e ambiente próximo</li>
  <li>Família e raízes</li>
  <li>Criatividade e expressão</li>
  <li>Saúde e rotinas</li>
  <li>Relacionamentos e parcerias</li>
  <li>Transformação e recursos compartilhados</li>
  <li>Expansão e sabedoria</li>
  <li>Carreira e propósito</li>
  <li>Amigos e grupos</li>
  <li>Espiritualidade e inconsciente</li>
</ol>

<blockquote>
  "O mapa astral é como um manual de instruções da sua alma, mostrando seus talentos naturais e desafios a serem superados."
</blockquote>

<h2>Como Interpretar seu Mapa</h2>
<p>Para começar a interpretar seu mapa astral, observe:</p>
<ul>
  <li>Os signos em que os planetas estão posicionados</li>
  <li>Os aspectos (ângulos) entre os planetas</li>
  <li>As casas em que os planetas estão localizados</li>
  <li>Os elementos predominantes (fogo, terra, ar, água)</li>
</ul>

<p>Lembre-se que a astrologia é uma ferramenta de autoconhecimento, não um destino imutável. Use essas informações para se entender melhor e crescer como pessoa.</p>
''',
        thumbnailUrl: 'https://picsum.photos/seed/lesson5/800/450',
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
        thumbnailUrl: 'https://picsum.photos/seed/lesson6/800/450',
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
        thumbnailUrl: 'https://picsum.photos/seed/lesson7/800/450',
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
