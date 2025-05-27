# Guia de Estilo e Design Técnico - App Aya

## Índice
1. [Introdução](#1-introdução)
2. [Identidade Visual "AYA"](#2-identidade-visual-aya)
3. [Layout e Espaçamento](#3-layout-e-espaçamento)
4. [Componentes de UI (Core)](#4-componentes-de-ui-core)
5. [Responsividade](#5-responsividade)
6. [Animação e Transições](#6-animação-e-transições)
7. [Acessibilidade (WCAG)](#7-acessibilidade-wcag)
8. [Tom de Voz e Estilo de Escrita](#8-tom-de-voz-e-estilo-de-escrita)
9. [Convenções de Código Flutter & Dart](#9-convenções-de-código-flutter--dart)
10. [Estrutura de Arquivos e Pastas](#10-estrutura-de-arquivos-e-pastas)
11. [Testes](#11-testes)
12. [Apêndice](#12-apêndice)

## 1. Introdução

### 1.1. Propósito deste Guia
Este guia estabelece os padrões de design e desenvolvimento para o App Aya, garantindo consistência visual e comportamental em toda a aplicação. Ele serve como referência central para designers e desenvolvedores.

### 1.2. Princípios Fundamentais de Design
- **Serenidade**: Design calmo e acolhedor que promove bem-estar
- **Intuitividade**: Interface clara e fácil de navegar
- **Acessibilidade**: Experiência inclusiva para todos os usuários
- **Performance**: Otimização para uma experiência fluida

### 1.3. Como Usar Este Guia
Este guia deve ser consultado durante todo o processo de desenvolvimento, desde o design inicial até a implementação. Mantenha-o atualizado conforme o projeto evolui.

### 1.4. Referências
Para uma visão geral do projeto, consulte o [README.md](README.md).

## 2. Identidade Visual "AYA"

### 2.1. Conceito Central
O App Aya é caracterizado por uma estética feminina, moderna e serena, com foco em bem-estar e autoconhecimento. O design busca transmitir calma e acolhimento através de elementos visuais suaves e harmoniosos.

### 2.2. Logo
(Se aplicável: versões, uso correto, espaçamento)

### 2.3. Paleta de Cores

#### 2.3.1. Cores Primárias
```dart
static const Color deepPurple = Color(0xFF2A2939);  // Roxo profundo
static const Color lavender = Color(0xFFACA1EF);    // Lavanda
```

#### 2.3.2. Cores Secundárias e de Acento
```dart
static const Color turquoise = Color(0xFF78C7B4);   // Verde água
static const Color softLavender = Color(0xFF575C84); // Lavanda suave
```

#### 2.3.3. Cores Neutras
```dart
static const Color surface = Color(0xFFF8F8FF);     // Fundo claro
static const Color textPrimary = Color(0xFF2A2939); // Texto principal
static const Color textSecondary = Color(0xFF575C84); // Texto secundário
```

#### 2.3.4. Cores de Estado
```dart
static const Color success = Color(0xFF4CAF50);     // Verde sucesso
static const Color error = Color(0xFFE53935);       // Vermelho erro
static const Color warning = Color(0xFFFFB300);     // Amarelo aviso
static const Color info = Color(0xFF2196F3);        // Azul informação
```

#### 2.3.5. Exemplos de Uso e Harmonia de Cores
- Fundos escuros com acentos em lavanda
- Textos claros sobre fundos escuros
- Elementos interativos em turquoise
- Estados e feedback em cores semânticas

### 2.4. Tipografia

#### 2.4.1. Fonte Principal para Títulos
```dart
static const String titleFontFamily = 'Open Sans';
static const FontWeight titleFontWeight = FontWeight.w600;
```

#### 2.4.2. Fonte Principal para Corpo de Texto
```dart
static const String bodyFontFamily = 'Inter';
static const FontWeight bodyFontWeight = FontWeight.w400;
```

#### 2.4.3. Fonte de Fallback
```dart
static const String fallbackFontFamily = 'Roboto';
```

#### 2.4.4. Hierarquia de Texto
```dart
// Títulos
static const double fontSizeH1 = 32.0;
static const double fontSizeH2 = 24.0;
static const double fontSizeH3 = 20.0;

// Corpo
static const double fontSizeBody = 16.0;
static const double fontSizeSmall = 14.0;
static const double fontSizeCaption = 12.0;
```

#### 2.4.5. Estilos de Parágrafo
```dart
static const double lineHeightBody = 1.5;
static const double lineHeightTitle = 1.2;
static const double paragraphSpacing = 16.0;
```

### 2.5. Iconografia
- Biblioteca: Iconoir Flutter
- Estilo: Linear, minimalista
- Tamanhos padrão: 16px, 24px, 32px
- Cores: Seguir paleta principal

#### 2.5.1. Estados dos Ícones
```dart
// Estado Normal
static const Color iconNormal = Color(0xFF575C84);  // softLavender

// Estado Ativo
static const Color iconActive = Color(0xFFACA1EF);  // lavender

// Estado Desabilitado
static const Color iconDisabled = Color(0xFF575C84).withOpacity(0.5);

// Estado Hover
static const Color iconHover = Color(0xFF78C7B4);   // turquoise
```

#### 2.5.2. Efeitos e Transições
```dart
// Animação de Hover
static const Duration iconHoverDuration = Duration(milliseconds: 200);
static const Curve iconHoverCurve = Curves.easeInOut;

// Efeito de Brilho (Glow)
static const List<BoxShadow> iconGlow = [
  BoxShadow(
    color: Color(0xFFACA1EF),
    blurRadius: 8,
    spreadRadius: 2,
  ),
];
```

#### 2.5.3. Implementação de Ícones
```dart
class AyaIcon extends StatelessWidget {
  final Iconoir icon;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback? onTap;

  const AyaIcon({
    required this.icon,
    this.isActive = false,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: iconHoverDuration,
          curve: iconHoverCurve,
          child: Iconoir(
            icon: icon,
            color: isDisabled 
                ? iconDisabled 
                : isActive 
                    ? iconActive 
                    : iconNormal,
            size: 24,
          ),
        ),
      ),
    );
  }
}
```

### 2.6. Imagens e Ilustrações
- Estilo: Suave, orgânico
- Tom: Calmo, acolhedor
- Foco em natureza e bem-estar

## 3. Layout e Espaçamento

### 3.1. Sistema de Grid
- Base: 8px
- Colunas: 12 (desktop), 8 (tablet), 4 (mobile)
- Gutter: 16px
- Margin: 16px (mobile), 24px (tablet), 32px (desktop)

### 3.2. Unidades de Espaçamento
```dart
static const double spacingXs = 4.0;    // 0.5x
static const double spacingSm = 8.0;    // 1x
static const double spacingMd = 16.0;   // 2x
static const double spacingLg = 24.0;   // 3x
static const double spacingXl = 32.0;   // 4x
static const double spacing2xl = 48.0;  // 6x
```

### 3.3. Raios de Borda
```dart
static const double borderRadiusSm = 4.0;   // 0.5x
static const double borderRadiusMd = 8.0;   // 1x
static const double borderRadiusLg = 12.0;  // 1.5x
static const double borderRadiusXl = 16.0;  // 2x
```

### 3.4. Elevação e Sombras
```dart
static const List<BoxShadow> shadowSmall = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(0, 2),
    blurRadius: 4,
  ),
];

static const List<BoxShadow> shadowMedium = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 4),
    blurRadius: 8,
  ),
];

static const List<BoxShadow> shadowLarge = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.2),
    offset: Offset(0, 8),
    blurRadius: 16,
  ),
];
```

## 4. Componentes de UI (Core)

### 4.1. Princípios de Design Glassy
- Efeito de vidro fosco (frosted glass)
- Gradientes sutis
- Sombras suaves
- Transparências controladas
- Bordas suaves e arredondadas

#### 4.1.1. Implementação do Efeito Glassy
```dart
class GlassyContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blurRadius;
  final Color? color;

  const GlassyContainer({
    required this.child,
    this.opacity = 0.1,
    this.blurRadius = 10,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (color ?? Colors.white).withOpacity(opacity),
        borderRadius: BorderRadius.circular(borderRadiusLg),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: blurRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurRadius,
            sigmaY: blurRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
```

### 4.2. Drawer (Menu Lateral)
```dart
class AyaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassyContainer(
      child: Container(
        width: 280,
        child: Column(
          children: [
            // Header com Logo
            Container(
              padding: EdgeInsets.all(spacingLg),
              child: Image.asset('assets/images/logo.png'),
            ),
            
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: spacingMd),
                children: [
                  _buildMenuItem(
                    icon: Iconoir.home,
                    title: 'Início',
                    isActive: true,
                  ),
                  _buildMenuItem(
                    icon: Iconoir.book,
                    title: 'Aulas',
                  ),
                  // ... outros itens
                ],
              ),
            ),
            
            // Footer
            Container(
              padding: EdgeInsets.all(spacingLg),
              child: Column(
                children: [
                  Divider(color: Colors.white.withOpacity(0.1)),
                  _buildUserProfile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required Iconoir icon,
    required String title,
    bool isActive = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: spacingMd,
        vertical: spacingXs,
      ),
      decoration: BoxDecoration(
        color: isActive 
            ? lavender.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadiusMd),
      ),
      child: ListTile(
        leading: AyaIcon(
          icon: icon,
          isActive: isActive,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? lavender : textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMd),
        ),
      ),
    );
  }
}
```

### 4.3. Aplicação da Paleta de Cores

#### 4.3.1. Gradientes
```dart
// Gradiente Principal
static const LinearGradient primaryGradient = LinearGradient(
  colors: [
    Color(0xFF2A2939),  // deepPurple
    Color(0xFF575C84),  // softLavender
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// Gradiente de Acento
static const LinearGradient accentGradient = LinearGradient(
  colors: [
    Color(0xFF78C7B4),  // turquoise
    Color(0xFFACA1EF),  // lavender
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

#### 4.3.2. Overlays e Transparências
```dart
// Overlay Escuro
static Color darkOverlay = Colors.black.withOpacity(0.3);

// Overlay Claro
static Color lightOverlay = Colors.white.withOpacity(0.1);

// Transparência para Efeitos Glassy
static Color glassyOverlay = Colors.white.withOpacity(0.05);
```

#### 4.3.3. Implementação em Componentes
```dart
class AyaCard extends StatelessWidget {
  final Widget child;
  final bool isGlassy;
  final bool hasGradient;

  const AyaCard({
    required this.child,
    this.isGlassy = true,
    this.hasGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: hasGradient ? primaryGradient : null,
        color: hasGradient ? null : surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(borderRadiusLg),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: isGlassy
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusLg),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: child,
              ),
            )
          : child,
    );
  }
}
```

### 4.4. Cards de Conteúdo da Biblioteca

#### 4.4.1. Card de Conteúdo
```dart
class LibraryContentCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String contentType; // 'video', 'audio', 'pdf', 'article'
  final String duration;
  final VoidCallback onTap;
  final bool isNew;
  final bool isPremium;

  const LibraryContentCard({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.contentType,
    required this.duration,
    required this.onTap,
    this.isNew = false,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return AyaCard(
      isGlassy: true,
      hasGradient: false,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadiusLg),
        child: Container(
          padding: EdgeInsets.all(spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail com Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusMd),
                    child: Image.network(
                      thumbnailUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Overlay Gradiente
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Badges
                  Positioned(
                    top: spacingSm,
                    right: spacingSm,
                    child: Row(
                      children: [
                        if (isNew)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spacingSm,
                              vertical: spacingXs,
                            ),
                            decoration: BoxDecoration(
                              color: turquoise,
                              borderRadius: BorderRadius.circular(borderRadiusSm),
                            ),
                            child: Text(
                              'Novo',
                              style: TextStyle(
                                color: surface,
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (isPremium)
                          Container(
                            margin: EdgeInsets.only(left: spacingXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spacingSm,
                              vertical: spacingXs,
                            ),
                            decoration: BoxDecoration(
                              color: lavender,
                              borderRadius: BorderRadius.circular(borderRadiusSm),
                            ),
                            child: Text(
                              'Premium',
                              style: TextStyle(
                                color: surface,
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Tipo de Conteúdo e Duração
                  Positioned(
                    bottom: spacingSm,
                    left: spacingSm,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spacingSm,
                            vertical: spacingXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(borderRadiusSm),
                          ),
                          child: Row(
                            children: [
                              AyaIcon(
                                icon: _getContentTypeIcon(contentType),
                                color: surface,
                                size: 16,
                              ),
                              SizedBox(width: spacingXs),
                              Text(
                                _getContentTypeLabel(contentType),
                                style: TextStyle(
                                  color: surface,
                                  fontSize: fontSizeSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spacingSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spacingSm,
                            vertical: spacingXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(borderRadiusSm),
                          ),
                          child: Text(
                            duration,
                            style: TextStyle(
                              color: surface,
                              fontSize: fontSizeSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacingMd),
              // Título
              Text(
                title,
                style: TextStyle(
                  fontFamily: titleFontFamily,
                  fontSize: fontSizeH3,
                  fontWeight: titleFontWeight,
                  color: textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: spacingSm),
              // Descrição
              Text(
                description,
                style: TextStyle(
                  fontFamily: bodyFontFamily,
                  fontSize: fontSizeBody,
                  color: textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Iconoir _getContentTypeIcon(String type) {
    switch (type) {
      case 'video':
        return Iconoir.play;
      case 'audio':
        return Iconoir.music;
      case 'pdf':
        return Iconoir.file;
      case 'article':
        return Iconoir.document;
      default:
        return Iconoir.file;
    }
  }

  String _getContentTypeLabel(String type) {
    switch (type) {
      case 'video':
        return 'Vídeo';
      case 'audio':
        return 'Áudio';
      case 'pdf':
        return 'PDF';
      case 'article':
        return 'Artigo';
      default:
        return 'Conteúdo';
    }
  }
}
```

#### 4.4.2. Grid de Cards
```dart
class LibraryContentGrid extends StatelessWidget {
  final List<ContentItem> items;
  final Function(ContentItem) onItemTap;

  const LibraryContentGrid({
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(spacingMd),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 0.75,
        crossAxisSpacing: spacingMd,
        mainAxisSpacing: spacingMd,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return LibraryContentCard(
          title: item.title,
          description: item.description,
          thumbnailUrl: item.thumbnailUrl,
          contentType: item.type,
          duration: item.duration,
          isNew: item.isNew,
          isPremium: item.isPremium,
          onTap: () => onItemTap(item),
        );
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}
```

#### 4.4.3. Modelo de Dados
```dart
class ContentItem {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String type;
  final String duration;
  final bool isNew;
  final bool isPremium;

  const ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.type,
    required this.duration,
    this.isNew = false,
    this.isPremium = false,
  });
}
```

## 5. Responsividade

### 5.1. Breakpoints
```dart
static const double mobileBreakpoint = 600.0;
static const double tabletBreakpoint = 1024.0;
```

### 5.2. Comportamentos Responsivos
- Mobile (< 600px):
  - Layout em coluna única
  - Fontes reduzidas em 20%
  - Espaçamentos reduzidos em 25%
  - Cards ocupam 100% da largura

- Tablet (600px - 1024px):
  - Layout em duas colunas
  - Fontes e espaçamentos padrão
  - Cards ocupam 50% da largura

- Desktop (> 1024px):
  - Layout em múltiplas colunas
  - Fontes e espaçamentos aumentados em 20%
  - Cards ocupam 33% da largura

## 6. Animação e Transições

### 6.1. Filosofia de Animação
- Sutis e naturais
- Com propósito claro
- Fluidas e responsivas

### 6.2. Durações Padrão
```dart
static const Duration durationFast = Duration(milliseconds: 150);
static const Duration durationNormal = Duration(milliseconds: 300);
static const Duration durationSlow = Duration(milliseconds: 500);
```

### 6.3. Curvas de Animação
```dart
static const Curve curveDefault = Curves.easeInOut;
static const Curve curveLinear = Curves.linear;
static const Curve curveEaseIn = Curves.easeIn;
static const Curve curveEaseOut = Curves.easeOut;
```

### 6.4. Tipos de Transição Comuns
- Fade: Para mudanças de conteúdo
- Slide: Para navegação entre telas
- Scale: Para elementos interativos

## 7. Acessibilidade (WCAG)

### 7.1. Contraste de Cores
- Texto: Mínimo 4.5:1
- Ícones: Mínimo 3:1
- Elementos interativos: Mínimo 3:1

### 7.2. Tamanhos Mínimos
- Área de toque: 48x48px
- Texto: 16px (14px com peso maior)

### 7.3. Navegação
- Suporte a teclado
- Foco visível
- Ordem lógica de tabulação

### 7.4. Semântica
- Labels apropriados
- Roles ARIA quando necessário
- Estrutura semântica

### 7.5. Alternativas para Mídia
- Texto alternativo para imagens
- Legendas para vídeos
- Transcrições para áudio

## 8. Tom de Voz e Estilo de Escrita

### 8.1. Persona da Marca
- Acolhedora
- Encorajadora
- Calma e serena

### 8.2. Diretrizes para Textos
- Clareza e concisão
- Tom pessoal e direto
- Linguagem inclusiva

## 9. Convenções de Código Flutter & Dart

### 9.1. Nomenclatura
- Arquivos: snake_case.dart
- Classes: PascalCase
- Variáveis: camelCase
- Constantes: SCREAMING_SNAKE_CASE
- Enums: PascalCase

### 9.2. Formatação
- Usar dart format
- Linha máxima: 80 caracteres
- Indentação: 2 espaços

### 9.3. Organização de Código
1. Imports
2. Constantes
3. Enums
4. Classes
5. Métodos
6. Build

### 9.4. Imports
1. Dart SDK
2. Flutter
3. Pacotes externos
4. Arquivos locais

### 9.5. Comentários
```dart
/// Descrição da classe
class MyClass {
  /// Descrição do método
  void myMethod() {
    // Comentário de linha
  }
}
```

### 9.6. Gerenciamento de Estado
- Usar Riverpod
- Separar lógica de UI
- Manter estado mínimo

### 9.7. Widgets
- Preferir stateless
- Usar const quando possível
- Componentizar

### 9.8. Padrões de Componentização
- Extrair widgets reutilizáveis
- Manter componentes pequenos e focados
- Usar composição ao invés de herança
- Implementar interfaces consistentes
- Documentar props e comportamentos

### 9.9. Performance e Otimização
- Usar const constructors
- Implementar shouldRebuild
- Otimizar rebuilds
- Lazy loading de imagens
- Cache de widgets

## 10. Estrutura de Arquivos e Pastas
Consulte o [README.md](README.md) para a estrutura completa do projeto.

## 11. Testes

### 11.1. Estratégia de Testes
- Unitários: Lógica de negócio
- Widget: Componentes UI
- Integração: Fluxos completos

### 11.2. Cobertura Mínima
- 80% para código crítico
- 60% para código geral

### 11.3. Ferramentas
- flutter_test
- mockito
- integration_test

## 12. Apêndice

### Glossário
- **UI**: Interface do Usuário
- **UX**: Experiência do Usuário
- **WCAG**: Web Content Accessibility Guidelines

### Links Úteis
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design](https://material.io/design)
- [WCAG Guidelines](https://www.w3.org/WAI/standards-guidelines/wcag/)

## Convenções de Nomenclatura

### Arquivos e Diretórios
- Use snake_case (letras minúsculas com underscores)
- Exemplos:
  - `user_profile_screen.dart`
  - `auth_service.dart`
  - `shared_widgets/`
  - `custom_button.dart`

### Classes
- Use PascalCase
- Exemplos:
  - `UserProfileScreen`
  - `AuthService`
  - `CustomButton`
  - `UserModel`

### Sufixos Comuns
- `Screen` ou `Page`: Para rotas/telas de nível superior
- `Widget`: Para componentes de UI reutilizáveis
- `Service`: Para classes de lógica de negócios, comunicação com API, etc.
- `Controller`/`Notifier`/`Provider`: Para gerenciamento de estado
- `Model`: Para estruturas de dados
- `Exception`: Para classes de exceção customizadas

### Enums
- Use PascalCase para o nome do enum
- Use camelCase para os valores
- Exemplo:
```dart
enum AuthStatus {
  authenticated,
  unauthenticated,
  unknown
}
```

### Variáveis e Métodos
- Use camelCase
- Exemplos:
  - `userName`
  - `isLoading`
  - `submitForm()`
- Variáveis privadas começam com underscore:
  - `_internalCounter`
  - `_fetchData()`

### Constantes
- Use UPPER_SNAKE_CASE para constantes de tempo de compilação (const)
- Use camelCase prefixado com k para constantes globais
- Para static const dentro de classes, use camelCase
- Exemplos:
```dart
const MAX_RETRIES = 3;
static const double defaultPadding = 16.0;
const kDefaultTimeout = Duration(seconds: 30);
```

### Keys para Widgets
- Use camelCase seguido por Key
- Use keys apenas quando necessário (testes, estado específico, listas dinâmicas)
- Exemplos:
```dart
const Key('loginButtonKey')
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
``` 