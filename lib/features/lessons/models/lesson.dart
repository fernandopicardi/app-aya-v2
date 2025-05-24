import 'package:flutter/material.dart';

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
  final bool isPremium;
  final int studentsCount;
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
    this.isPremium = false,
    this.studentsCount = 0,
    this.complementaryMaterials = const [],
    this.nextLesson,
  });

  // Mock data for development
  static List<Lesson> getMockLessons() {
    return [
      // Vídeos
      Lesson(
        id: '1',
        title: 'Introdução ao Flutter',
        description:
            'Aprenda os conceitos básicos do Flutter e como criar seu primeiro aplicativo.',
        contentUrl: 'https://example.com/video1.mp4',
        thumbnailUrl: 'https://picsum.photos/800/400',
        contentType: ContentType.video,
        duration: '45 min',
        difficulty: 'Iniciante',
        isPremium: false,
        studentsCount: 1234,
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
          isPremium: false,
          studentsCount: 0,
        ),
      ),

      // Áudios
      Lesson(
        id: '3',
        title: 'Gerenciamento de Estado',
        description:
            'Entenda diferentes abordagens para gerenciar o estado em aplicativos Flutter.',
        contentUrl: 'https://example.com/audio1.mp3',
        thumbnailUrl: 'https://picsum.photos/800/402',
        contentType: ContentType.audio,
        duration: '30 min',
        difficulty: 'Avançado',
        isPremium: true,
        studentsCount: 567,
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
        isPremium: false,
        studentsCount: 0,
      ),

      // Textos Ricos
      Lesson(
        id: '5',
        title: 'Arquitetura de Aplicativos',
        description:
            'Aprenda sobre padrões de arquitetura e boas práticas em Flutter.',
        contentUrl: 'https://example.com/article1.html',
        thumbnailUrl: 'https://picsum.photos/800/403',
        contentType: ContentType.richText,
        duration: '20 min',
        difficulty: 'Intermediário',
        isPremium: false,
        studentsCount: 432,
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
        title: 'Testes em Flutter',
        description:
            'Aprenda a escrever testes unitários, de widget e de integração.',
        contentUrl: 'https://example.com/pdf1.pdf',
        thumbnailUrl: 'https://picsum.photos/800/404',
        contentType: ContentType.pdf,
        duration: '40 min',
        difficulty: 'Avançado',
        isPremium: true,
        studentsCount: 321,
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
        isPremium: false,
        studentsCount: 0,
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
