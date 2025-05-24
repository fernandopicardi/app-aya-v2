# Guia de Estilo e Documentação Técnica

## Índice
1. [Visão Geral](#visão-geral)
2. [Sistema de Cores](#sistema-de-cores)
3. [Tipografia](#tipografia)
4. [Espaçamento e Layout](#espaçamento-e-layout)
5. [Componentes](#componentes)
6. [Responsividade](#responsividade)
7. [Animações](#animações)
8. [Acessibilidade](#acessibilidade)

## Visão Geral

Este documento estabelece os padrões de design e desenvolvimento para o projeto, garantindo consistência visual e comportamental em toda a aplicação.

### Princípios Fundamentais
- Consistência visual e comportamental
- Experiência de usuário intuitiva
- Performance e otimização
- Acessibilidade universal
- Manutenibilidade do código

## Sistema de Cores

### Cores Primárias
```dart
static const Color primary = Color(0xFF1E88E5);  // Azul principal
static const Color secondary = Color(0xFF26A69A); // Verde água
static const Color accent = Color(0xFFFFA726);    // Laranja
```

### Cores de Estado
```dart
static const Color success = Color(0xFF4CAF50);   // Verde
static const Color error = Color(0xFFE53935);     // Vermelho
static const Color warning = Color(0xFFFFB300);   // Amarelo
static const Color info = Color(0xFF2196F3);      // Azul info
```

### Cores de Fundo
```dart
static const Color background = Color(0xFFF5F5F5);    // Fundo principal
static const Color surface = Color(0xFFFFFFFF);       // Superfícies
static const Color cardBackground = Color(0xFFFFFFFF); // Fundo de cards
```

### Cores de Texto
```dart
static const Color textPrimary = Color(0xFF212121);   // Texto principal
static const Color textSecondary = Color(0xFF757575); // Texto secundário
static const Color textHint = Color(0xFF9E9E9E);      // Texto de dica
```

## Tipografia

### Famílias de Fonte
```dart
static const String fontFamily = 'Poppins';
static const String fontFamilySecondary = 'Roboto';
```

### Tamanhos de Fonte
```dart
static const double fontSizeXs = 12.0;    // Textos muito pequenos
static const double fontSizeSm = 14.0;    // Textos pequenos
static const double fontSizeMd = 16.0;    // Textos médios
static const double fontSizeLg = 18.0;    // Textos grandes
static const double fontSizeXl = 20.0;    // Textos muito grandes
static const double fontSize2xl = 24.0;   // Títulos pequenos
static const double fontSize3xl = 30.0;   // Títulos médios
static const double fontSize4xl = 36.0;   // Títulos grandes
```

### Pesos de Fonte
```dart
static const FontWeight light = FontWeight.w300;
static const FontWeight regular = FontWeight.w400;
static const FontWeight medium = FontWeight.w500;
static const FontWeight semiBold = FontWeight.w600;
static const FontWeight bold = FontWeight.w700;
```

## Espaçamento e Layout

### Sistema de Grid
- Baseado em múltiplos de 8px
- Breakpoints responsivos:
  - Mobile: < 600px
  - Tablet: 600px - 1024px
  - Desktop: > 1024px

### Espaçamento
```dart
static const double spacingXs = 4.0;    // Espaçamento muito pequeno
static const double spacingSm = 8.0;    // Espaçamento pequeno
static const double spacingMd = 16.0;   // Espaçamento médio
static const double spacingLg = 24.0;   // Espaçamento grande
static const double spacingXl = 32.0;   // Espaçamento muito grande
static const double spacing2xl = 48.0;  // Espaçamento extra grande
```

### Bordas e Raios
```dart
static const double borderRadiusSm = 4.0;   // Bordas pequenas
static const double borderRadiusMd = 8.0;   // Bordas médias
static const double borderRadiusLg = 12.0;  // Bordas grandes
static const double borderRadiusXl = 16.0;  // Bordas muito grandes
```

## Componentes

### Botões

#### Botão Primário
- Altura: 48px
- Padding horizontal: 24px
- Borda: 8px
- Cor de fundo: primary
- Cor do texto: branco
- Estado hover: 10% mais escuro
- Estado disabled: 50% de opacidade

#### Botão Secundário
- Altura: 48px
- Padding horizontal: 24px
- Borda: 8px
- Cor de fundo: transparente
- Cor da borda: primary
- Cor do texto: primary
- Estado hover: 10% de opacidade do primary

### Campos de Texto
- Altura: 56px
- Padding horizontal: 16px
- Borda: 8px
- Cor de fundo: surface
- Cor da borda: textHint
- Cor do texto: textPrimary
- Estado focado: borda primary
- Estado erro: borda error

### Cards
- Padding: 16px
- Borda: 8px
- Sombra: 0 2px 4px rgba(0,0,0,0.1)
- Cor de fundo: cardBackground
- Espaçamento entre cards: 16px

### Listas
- Altura do item: 72px
- Padding: 16px
- Divisor: 1px solid textHint
- Espaçamento entre itens: 0px

## Responsividade

### Breakpoints
```dart
static const double mobileBreakpoint = 600.0;
static const double tabletBreakpoint = 1024.0;
```

### Comportamentos Responsivos
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

## Animações

### Durações
```dart
static const Duration durationFast = Duration(milliseconds: 150);
static const Duration durationNormal = Duration(milliseconds: 300);
static const Duration durationSlow = Duration(milliseconds: 500);
```

### Curvas
```dart
static const Curve curveDefault = Curves.easeInOut;
static const Curve curveFast = Curves.easeOut;
static const Curve curveSlow = Curves.easeIn;
```

### Transições
- Fade: 300ms
- Slide: 300ms
- Scale: 300ms
- Rotate: 300ms

## Acessibilidade

### Tamanhos Mínimos
- Área de toque: 48x48px
- Texto: mínimo 12sp
- Ícones: mínimo 24x24px

### Contraste
- Texto sobre fundo claro: mínimo 4.5:1
- Texto sobre fundo escuro: mínimo 3:1
- Elementos interativos: mínimo 3:1

### Navegação
- Suporte a navegação por teclado
- Ordem de foco lógica
- Indicadores de foco visíveis

### Semântica
- Labels apropriados
- Roles ARIA quando necessário
- Descrições alternativas para imagens

## Boas Práticas

### Performance
- Evitar rebuilds desnecessários
- Usar construtores const quando possível
- Implementar lazy loading para listas longas
- Otimizar imagens e assets

### Manutenibilidade
- Seguir princípios SOLID
- Documentar componentes complexos
- Manter consistência na nomenclatura
- Usar widgets reutilizáveis

### Testes
- Testes unitários para lógica de negócio
- Testes de widget para componentes UI
- Testes de integração para fluxos críticos
- Cobertura mínima de 80%

## Sistema de Nomenclatura

### Estrutura de Diretórios
```
lib/
├── core/                    # Funcionalidades core da aplicação
│   ├── constants/          # Constantes globais
│   ├── theme/             # Configurações de tema
│   └── utils/             # Utilitários globais
├── features/              # Funcionalidades da aplicação
│   ├── auth/             # Autenticação
│   ├── home/             # Tela inicial
│   └── profile/          # Perfil do usuário
├── shared/               # Componentes e widgets compartilhados
│   ├── widgets/         # Widgets reutilizáveis
│   └── models/          # Modelos de dados compartilhados
└── main.dart            # Ponto de entrada da aplicação
```

### Convenções de Nomenclatura

#### Arquivos
- **Páginas**: `feature_name_page.dart`
  - Exemplo: `home_page.dart`, `profile_page.dart`
- **Widgets**: `widget_name_widget.dart`
  - Exemplo: `custom_button_widget.dart`, `user_card_widget.dart`
- **Modelos**: `model_name_model.dart`
  - Exemplo: `user_model.dart`, `product_model.dart`
- **Serviços**: `service_name_service.dart`
  - Exemplo: `auth_service.dart`, `api_service.dart`
- **Controladores**: `controller_name_controller.dart`
  - Exemplo: `home_controller.dart`, `auth_controller.dart`
- **Estados**: `state_name_state.dart`
  - Exemplo: `auth_state.dart`, `home_state.dart`

#### Classes
- **Páginas**: `FeatureNamePage`
  - Exemplo: `HomePage`, `ProfilePage`
- **Widgets**: `WidgetNameWidget`
  - Exemplo: `CustomButtonWidget`, `UserCardWidget`
- **Modelos**: `ModelNameModel`
  - Exemplo: `UserModel`, `ProductModel`
- **Serviços**: `ServiceNameService`
  - Exemplo: `AuthService`, `ApiService`
- **Controladores**: `ControllerNameController`
  - Exemplo: `HomeController`, `AuthController`
- **Estados**: `StateNameState`
  - Exemplo: `AuthState`, `HomeState`

#### Variáveis e Funções
- **Variáveis**: camelCase
  - Exemplo: `userName`, `isLoading`, `selectedIndex`
- **Funções**: camelCase
  - Exemplo: `getUserData()`, `handleSubmit()`, `updateProfile()`
- **Constantes**: SCREAMING_SNAKE_CASE
  - Exemplo: `MAX_RETRY_COUNT`, `API_BASE_URL`
- **Enums**: PascalCase
  - Exemplo: `UserRole`, `AuthStatus`

#### IDs e Keys
- **IDs de Widgets**: `widget_name_id`
  - Exemplo: `submit_button_id`, `user_list_id`
- **Keys**: `widgetNameKey`
  - Exemplo: `submitButtonKey`, `userListKey`

#### Estilos e Temas
- **Estilos de Texto**: `text_style_name`
  - Exemplo: `heading_text_style`, `body_text_style`
- **Cores**: `color_name`
  - Exemplo: `primary_color`, `error_color`
- **Espaçamentos**: `spacing_name`
  - Exemplo: `small_spacing`, `large_spacing`

### Organização de Código

#### Ordem dos Membros em Classes
1. Constantes estáticas
2. Variáveis de instância
3. Construtor
4. Getters e Setters
5. Métodos públicos
6. Métodos privados

#### Ordem dos Imports
1. Imports do Flutter/Dart
2. Imports de pacotes externos
3. Imports de arquivos do projeto (relativos)
4. Imports de arquivos do projeto (absolutos)

### Documentação

#### Comentários de Classe
```dart
/// Descrição da classe
/// 
/// Exemplo de uso:
/// ```dart
/// final widget = WidgetName();
/// ```
class WidgetName extends StatelessWidget {
  // ...
}
```

#### Comentários de Método
```dart
/// Descrição do método
/// 
/// [param1] Descrição do primeiro parâmetro
/// [param2] Descrição do segundo parâmetro
/// 
/// Retorna [Tipo] Descrição do retorno
Future<Tipo> methodName(Tipo param1, Tipo param2) async {
  // ...
}
```

### Exemplos de Uso

#### Página
```dart
// lib/features/home/presentation/pages/home_page.dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
    );
  }
}
```

#### Widget
```dart
// lib/shared/widgets/custom_button_widget.dart
class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  const CustomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // ...
    );
  }
}
```

#### Modelo
```dart
// lib/features/user/data/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });
  
  // ...
}
```

### Regras Gerais
1. Use nomes descritivos e autoexplicativos
2. Evite abreviações, exceto para termos muito comuns (id, url, etc.)
3. Mantenha consistência com o padrão escolhido
4. Documente classes e métodos públicos
5. Use o mesmo padrão em todo o projeto
6. Siga as convenções do Flutter/Dart
7. Mantenha os arquivos organizados em diretórios lógicos
8. Use o sistema de nomenclatura para refletir a hierarquia do projeto 

### Nomenclatura de Componentes Aninhados e Layout

#### Estrutura de Layout
```dart
// Exemplo de estrutura bem nomeada
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key('user_profile_main_column'),
        children: [
          // Header Section
          Container(
            key: const Key('user_profile_header_container'),
            child: Row(
              key: const Key('user_profile_header_row'),
              children: [
                // ... header content
              ],
            ),
          ),
          
          // Content Section
          Expanded(
            key: const Key('user_profile_content_expanded'),
            child: Column(
              key: const Key('user_profile_content_column'),
              children: [
                // ... content
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

#### Padrões de Nomenclatura para Containers

1. **Containers de Seção**
   - Nome: `section_name_container`
   - Exemplo: `profile_header_container`, `settings_list_container`
   - Uso: Para containers que agrupam uma seção específica

2. **Containers de Conteúdo**
   - Nome: `content_type_container`
   - Exemplo: `user_info_container`, `product_details_container`
   - Uso: Para containers que envolvem um tipo específico de conteúdo

3. **Containers de Layout**
   - Nome: `layout_purpose_container`
   - Exemplo: `centered_content_container`, `padded_section_container`
   - Uso: Para containers que servem propósitos específicos de layout

#### Padrões de Nomenclatura para Rows e Columns

1. **Rows Principais**
   - Nome: `section_name_row`
   - Exemplo: `header_actions_row`, `product_info_row`
   - Uso: Para rows que organizam elementos principais

2. **Columns Principais**
   - Nome: `section_name_column`
   - Exemplo: `main_content_column`, `settings_options_column`
   - Uso: Para columns que organizam seções principais

3. **Rows e Columns Aninhados**
   - Nome: `parent_section_child_section_row/column`
   - Exemplo: `header_actions_buttons_row`, `profile_info_details_column`
   - Uso: Para estruturas aninhadas, indicando a hierarquia

#### Padrões de Nomenclatura para Expanded e Flexible

1. **Expanded**
   - Nome: `section_name_expanded`
   - Exemplo: `content_area_expanded`, `list_view_expanded`
   - Uso: Para widgets Expanded que ocupam espaço flexível

2. **Flexible**
   - Nome: `section_name_flexible`
   - Exemplo: `header_flexible`, `footer_flexible`
   - Uso: Para widgets Flexible com flexibilidade específica

#### Padrões de Nomenclatura para Stack e Positioned

1. **Stack**
   - Nome: `section_name_stack`
   - Exemplo: `overlay_content_stack`, `floating_elements_stack`
   - Uso: Para Stacks que organizam elementos sobrepostos

2. **Positioned**
   - Nome: `element_name_positioned`
   - Exemplo: `floating_button_positioned`, `overlay_text_positioned`
   - Uso: Para elementos posicionados dentro de um Stack

#### Exemplo de Implementação

```dart
class ProductCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('product_card_main_container'),
      child: Column(
        key: const Key('product_card_main_column'),
        children: [
          // Header Section
          Container(
            key: const Key('product_card_header_container'),
            child: Row(
              key: const Key('product_card_header_row'),
              children: [
                // Product Image
                Container(
                  key: const Key('product_card_image_container'),
                  child: Image.network(...),
                ),
                // Product Title
                Expanded(
                  key: const Key('product_card_title_expanded'),
                  child: Column(
                    key: const Key('product_card_title_column'),
                    children: [
                      Text('Product Name'),
                      Text('Product Price'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Details Section
          Container(
            key: const Key('product_card_details_container'),
            child: Column(
              key: const Key('product_card_details_column'),
              children: [
                // Product Description
                Container(
                  key: const Key('product_card_description_container'),
                  child: Text('Description'),
                ),
                // Product Actions
                Row(
                  key: const Key('product_card_actions_row'),
                  children: [
                    // Action Buttons
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

#### Regras para Keys

1. **Keys de Container**
   - Formato: `section_name_container_key`
   - Exemplo: `user_profile_header_container_key`

2. **Keys de Row/Column**
   - Formato: `section_name_row/column_key`
   - Exemplo: `user_profile_header_row_key`

3. **Keys de Expanded/Flexible**
   - Formato: `section_name_expanded/flexible_key`
   - Exemplo: `user_profile_content_expanded_key`

4. **Keys de Stack/Positioned**
   - Formato: `section_name_stack/positioned_key`
   - Exemplo: `user_profile_overlay_stack_key`

#### Boas Práticas para Componentes Aninhados

1. **Limite de Aninhamento**
   - Evite mais de 3 níveis de aninhamento
   - Extraia componentes complexos para widgets separados
   - Use constantes para valores repetidos

2. **Organização de Código**
   - Agrupe widgets relacionados
   - Comente seções complexas
   - Use espaçamento consistente

3. **Performance**
   - Use const quando possível
   - Evite rebuilds desnecessários
   - Implemente keys apropriadamente

4. **Manutenibilidade**
   - Mantenha nomes descritivos
   - Documente estruturas complexas
   - Siga o padrão de nomenclatura consistentemente

#### Exemplo de Extração de Componentes

```dart
// Componente Principal
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        key: const Key('user_profile_main_column'),
        children: [
          const UserProfileHeaderWidget(),
          const UserProfileContentWidget(),
          const UserProfileFooterWidget(),
        ],
      ),
    );
  }
}

// Componente Extraído
class UserProfileHeaderWidget extends StatelessWidget {
  const UserProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('user_profile_header_container'),
      child: Row(
        key: const Key('user_profile_header_row'),
        children: [
          const UserProfileAvatarWidget(),
          const UserProfileInfoWidget(),
        ],
      ),
    );
  }
}
```

Esta estrutura detalhada de nomenclatura ajudará a:
1. Localizar rapidamente componentes específicos
2. Manter a consistência do código
3. Facilitar a manutenção
4. Melhorar a legibilidade
5. Otimizar a performance
6. Facilitar o debugging 

## Componentes Existentes no App

### Componentes de Layout Base
1. **AyaGlassContainer**
   - Localização: `lib/widgets/aya_glass_container.dart`
   - Função: Container base com efeito de vidro
   - Variações: 
     - `AyaGlassButton`
     - `AyaGlassCard`

2. **AyaAppBar**
   - Localização: `lib/widgets/aya_app_bar.dart`
   - Função: Barra de navegação superior
   - Variações:
     - `primary`
     - `transparent`
     - `elevated`
     - `GlassmorphicAppBar`

3. **AyaBottomSheet**
   - Localização: `lib/widgets/aya_bottom_sheet.dart`
   - Função: Painel deslizante inferior
   - Variações:
     - `standard`
     - `modal`

### Componentes de Entrada
1. **AyaInput**
   - Localização: `lib/widgets/aya_input.dart`
   - Função: Campo de entrada de texto base
   - Variações:
     - `text`
     - `password`
     - `email`
     - `number`
     - `multiline`

2. **AyaGlassInput**
   - Localização: `lib/widgets/aya_glass_input.dart`
   - Função: Campo de entrada com efeito de vidro
   - Variações:
     - `AyaGlassPasswordInput`

### Componentes de Navegação
1. **AyaDrawer**
   - Localização: `lib/widgets/aya_drawer.dart`
   - Função: Menu lateral
   - Subcomponentes:
     - `AyaDrawerItem`

2. **AyaBottomNav**
   - Localização: `lib/widgets/aya_bottom_nav.dart`
   - Função: Navegação inferior

### Componentes de Ação
1. **AyaButton**
   - Localização: `lib/widgets/aya_button.dart`
   - Função: Botão base
   - Variações:
     - `primary`
     - `secondary`
     - `outline`
     - `text`

### Componentes de Diálogo
1. **AyaGlassDialog**
   - Localização: `lib/widgets/aya_glass_dialog.dart`
   - Função: Diálogo com efeito de vidro
   - Variações:
     - `AyaGlassAlertDialog`

### Componentes de Mídia
1. **AyaVideoPlayer**
   - Localização: `lib/features/lessons/widgets/aya_video_player.dart`
   - Função: Reprodutor de vídeo

2. **AyaAudioPlayer**
   - Localização: `lib/features/lessons/widgets/aya_audio_player.dart`
   - Função: Reprodutor de áudio

### Componentes de Visualização
1. **AyaRichTextViewer**
   - Localização: `lib/features/lessons/widgets/aya_rich_text_viewer.dart`
   - Função: Visualizador de texto formatado

2. **AyaPdfViewer**
   - Localização: `lib/features/lessons/widgets/aya_pdf_viewer.dart`
   - Função: Visualizador de PDF

### Páginas Principais
1. **LandingPage**
   - Localização: `lib/features/landing/landing_page.dart`
   - Função: Página inicial de autenticação

2. **DashboardScreen**
   - Localização: `lib/features/dashboard/screens/dashboard_screen.dart`
   - Função: Tela principal do dashboard

3. **AdminDashboardPage**
   - Localização: `lib/features/admin/admin_dashboard_page.dart`
   - Função: Dashboard administrativo

4. **LessonPage**
   - Localização: `lib/features/lessons/screens/lesson_page.dart`
   - Função: Página de lição

### Serviços de Animação
1. **AnimationsService**
   - Localização: `lib/core/services/animations_service.dart`
   - Funções:
     - `fadeThrough`
     - `slideUp`
     - `slideRight`
     - `fadeIn`
     - `scaleIn`
     - `slideInUp`

### Padrões de Nomenclatura Atuais
1. **Prefixo "Aya"**
   - Todos os componentes base começam com "Aya"
   - Exemplo: `AyaButton`, `AyaInput`

2. **Sufixos Específicos**
   - `Page`: Para páginas completas
   - `Screen`: Para telas principais
   - `Widget`: Para componentes reutilizáveis
   - `Service`: Para serviços
   - `Container`: Para containers base
   - `Dialog`: Para diálogos
   - `Input`: Para campos de entrada

3. **Variações**
   - Usam sufixos descritivos
   - Exemplo: `AyaGlassInput`, `AyaGlassButton`

### Estrutura de Diretórios Atual
```
lib/
├── core/
│   ├── services/
│   │   └── animations_service.dart
│   └── theme/
│       └── app_theme.dart
├── features/
│   ├── admin/
│   │   └── admin_dashboard_page.dart
│   ├── dashboard/
│   │   └── screens/
│   │       └── dashboard_screen.dart
│   ├── landing/
│   │   └── landing_page.dart
│   └── lessons/
│       ├── screens/
│       │   └── lesson_page.dart
│       └── widgets/
│           ├── aya_audio_player.dart
│           ├── aya_pdf_viewer.dart
│           ├── aya_rich_text_viewer.dart
│           └── aya_video_player.dart
└── widgets/
    ├── aya_app_bar.dart
    ├── aya_bottom_nav.dart
    ├── aya_bottom_sheet.dart
    ├── aya_button.dart
    ├── aya_drawer.dart
    ├── aya_glass_container.dart
    ├── aya_glass_dialog.dart
    ├── aya_glass_input.dart
    └── aya_input.dart
```

### Próximos Passos para Padronização
1. **Reorganização de Componentes**
   - Mover componentes para diretórios apropriados
   - Separar componentes base de componentes específicos
   - Criar estrutura de diretórios mais organizada

2. **Padronização de Nomes**
   - Aplicar o novo sistema de nomenclatura
   - Atualizar nomes de arquivos e classes
   - Manter consistência com o guia de estilo

3. **Documentação**
   - Adicionar documentação aos componentes
   - Criar exemplos de uso
   - Manter o guia atualizado

4. **Refatoração**
   - Extrair componentes aninhados
   - Implementar keys apropriadas
   - Otimizar performance 