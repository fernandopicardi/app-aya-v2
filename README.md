# App Aya 🧘‍♀️✨

**Um caminho de profundo cuidado com a sua existência.**

Bem-vindo ao repositório oficial do App Aya! Este documento serve como o guia central para desenvolvedores e colaboradores, detalhando a visão do projeto, tecnologias, fluxo do usuário, estrutura de conteúdo, configuração, e como contribuir.

[![Status da Build](URL_DO_SEU_STATUS_DE_BUILD_AQUI_SE_TIVER_CI_CD)](URL_DO_SEU_PIPELINE_DE_CI_CD)
[![Licença: MIT](https://img.shields.io/badge/Licença-MIT-lavender.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.32.0-blueviolet)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-green)](https://supabase.io)

## 🌟 1. Visão Geral do Projeto

App Aya é um aplicativo multiplataforma (iOS, Android, Web) de saúde e bem-estar, construído com Flutter para o frontend e Supabase para o backend. Nossa missão é fornecer um santuário digital que auxilie os usuários em sua jornada de autoconhecimento, equilíbrio emocional, meditação, desenvolvimento espiritual e práticas de saúde mental.

### 1.1. Proposta de Valor
* **Conteúdo Transformador e Curado:** Meditações, jornadas temáticas, vídeos, áudios, artigos (Rich Text) e PDFs.
* **Personalização Inteligente:** Assistente virtual (IA) para dúvidas, sugestões e criação de playlists.
* **Comunidade Acolhedora:** Fóruns e desafios em grupo.
* **Gamificação Motivadora:** Níveis, pontos e badges.
* **Design Premium e Intuitivo:** Interface moderna, elegante, com estética feminina e serena.
* **Acesso Flexível:** Planos de assinatura (Gratuito, Mensal, Anual).
* **Lives Interativas:** Eventos ao vivo dentro do app.

## 🎨 2. Design e Identidade Visual

A identidade visual do App Aya é fundamental. Ela é caracterizada por uma estética **clean, premium, moderna, feminina e serena.** Todos os detalhes sobre cores, a família de fontes principal **Inter** (e seus fallbacks: `ui-sans-serif, system-ui, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji`), a fonte Serifada para títulos, espaçamentos, componentes, **iconografia (Iconoir)**, animações e a aplicação do efeito "glassmorphism" estão documentados em nosso **`STYLE_GUIDE.md`**. Este guia é a fonte da verdade para todas as decisões de UI/UX e define a paleta de cores escura, com tons de roxo profundo, acentos em lavanda e verde água, conforme a visão do projeto.

## 🌊 3. Fluxo do Usuário (User Flow) e Estrutura de Navegação de Conteúdo

### 3.1. Fluxo Principal do Usuário
1.  **Primeiro Acesso (Usuário Não Logado):**
    * **Web (Desktop):** Acesso à landing page informativa completa (`caminhoaya.com`), que apresenta todos os benefícios, planos, e direciona para a página inicial da aplicação web para Login/Assinatura.
    * **Aplicação Web (Deslogado):** Página inicial da aplicação (`app.caminhoaya.com`) com destaque visual (vídeo curto), e opções claras de "Entrar" ou "Ver Planos e Assinar".
    * **Mobile (Android/iOS):** Abertura direta na tela de Login, com um link proeminente para "Criar Conta".
2.  **Autenticação:**
    * **Tela de Login:** Campos para Email/Senha, Login Social (Google, Apple), link "Esqueci Senha".
    * **Tela de Cadastro:** Campos para Nome, Email, Senha, Confirmação de Senha, aceite de Termos. Cadastro Social (Google, Apple). Link para Login.
    * **Tela de Recuperação de Senha.**
    * **Tela de Planos de Assinatura:** Apresentação dos planos (Gratuito, Mensal, Anual) e seus benefícios, levando ao fluxo de pagamento (RevenueCat).
3.  **Usuário Logado:**
    * **Dashboard (Home):** Tela inicial principal.
    * **Navegação Principal (BottomNavigationBar e Drawer):** Home, Biblioteca, Comunidade, Chat IA. (O Perfil é acessado pelo Drawer).
    * Acesso ao conteúdo, perfil, configurações, etc.

### 3.2. Estrutura de Navegação e Consumo de Conteúdo
A navegação pelo conteúdo é hierárquica, promovendo uma jornada de descoberta:

1.  **`DashboardScreen` (Home):**
    * **Hero Slider:** Destaques dinâmicos (novos conteúdos, eventos, planos).
    * **Seções de Módulos:** Abaixo do Hero, são listados os **Módulos Principais** (ex: "Meditação para Iniciantes", "Astrologia na Prática"). Cada seção de módulo exibe:
        * Título do Módulo.
        * Uma **lista horizontal rolável de cards representando as Pastas** contidas nesse módulo. Cada card de Pasta exibe um thumbnail e o título da Pasta.
        * Se um Módulo não tiver Pastas, ele exibirá diretamente uma lista horizontal de cards de Aulas.
2.  **`FolderPage` (Página da Pasta):**
    * Acessada ao clicar em um card de Pasta no Dashboard ou na Biblioteca.
    * **Conteúdo:**
        * Banner/Título da Pasta.
        * Se a Pasta contiver **Subpastas**, exibe uma lista (vertical ou horizontal) de cards de Subpastas (com thumbnail e título).
        * Se a Pasta contiver **Aulas diretamente** (sem Subpastas), exibe uma lista vertical de cards de Aulas.
3.  **`SubfolderPage` (Página da Subpasta - se aplicável):**
    * Acessada ao clicar em um card de Subpasta na `FolderPage`.
    * **Conteúdo:**
        * Banner/Título da Subpasta.
        * Lista vertical de cards de **Aulas** contidas nesta Subpasta.
4.  **`LessonPage` (Página da Aula/Conteúdo):**
    * Acessada ao clicar em um card de Aula.
    * Exibe o conteúdo específico da aula (Vídeo, Áudio com espectro visual dinâmico e reativo em tempo real, Artigo Rich-Text, PDF) e todas as funcionalidades interativas (Like, Favoritar, Anotações, Download de Materiais, Comentários, Próxima Aula), conforme detalhado no PDR e nas discussões. O player de áudio oferecerá controles de play/pause, volume, avanço/retrocesso e velocidade.

### 3.3. Outras Telas Principais
* **`LibraryScreen` (Biblioteca):** Visão completa de todo o conteúdo, com filtros avançados (por Módulo, tipo de conteúdo, etc.) e busca.
* **`CommunityScreen` (Comunidade):** Acesso a Fóruns, Leaderboards, Desafios em Grupo.
* **`ChatIAScreen` (Aya Chat):** Interface para interação com o assistente virtual.
* **`UserProfileScreen` (Perfil - acessado pelo Drawer):** Dados do usuário, progresso, downloads, configurações, gerenciamento de assinatura.
* **Painel Administrativo Externo (React Next.js):** Uma plataforma web dedicada será desenvolvida para o gerenciamento completo do App Aya. Esta plataforma permitirá aos administradores controle total sobre todos os aspectos do aplicativo.

## 🛠️ 4. Stack Tecnológica Principal

* **Frontend (App):** [Flutter](https://flutter.dev/) (iOS, Android, Web)
    * **Gerenciamento de Estado:** [Riverpod](https://riverpod.dev/)
    * **Roteamento:** [Go Router](https://pub.dev/packages/go_router)
    * **Variáveis de Ambiente:** [Flutter DotEnv](https://pub.dev/packages/flutter_dotenv)
    * **Cliente HTTP:** [Dio](https://pub.dev/packages/dio). Escolhido devido à necessidade de múltiplas chamadas entre o App e o Supabase para sincronização de conteúdo e para lidar com as requisições CRUD que o n8n poderá solicitar nas automações, garantindo uma comunicação robusta com o backend.
    * **Integração Backend (App):** [Supabase Flutter](https://pub.dev/packages/supabase_flutter)
    * **Fontes:** [Google Fonts](https://pub.dev/packages/google_fonts) (configurado para **Inter** e seus fallbacks, com suporte para fonte Serifada para títulos, conforme `STYLE_GUIDE.md`)
    * **Ícones:** [Iconoir](https://iconoir.com/) (ou um pacote Flutter que os disponibilize, ex: `iconoir_flutter`)
    * **Imagens:** [Cached Network Image](https://pub.dev/packages/cached_network_image)
    * **Players:** `just_audio` (+ `just_audio_background`), `video_player`.
    * **Visualizadores:** `syncfusion_flutter_pdfviewer`, `flutter_html`.
    * **Visualização de Áudio:** `audio_visualizer` (ou alternativa para espectro dinâmico integrado ao `just_audio`, conforme referência visual)
    * **Armazenamento Seguro:** `flutter_secure_storage`.
    * **Config App:** `flutter_launcher_icons`, `flutter_native_splash`.
* **Backend (App & Admin Panel):** [Supabase](https://supabase.io/) (PostgreSQL, Auth, Storage, Edge Functions, Realtime).
* **Frontend (Admin Panel):** React (Next.js).
* **Monetização:** [RevenueCat](https://www.revenuecat.com/).
* **Automação/IA:** [n8n](https://n8n.io/).

## 🚀 5. Configuração do Ambiente de Desenvolvimento

1.  **Pré-requisitos:** Flutter SDK 3.32.0+, Node.js (para o Painel Admin Next.js), Editor, Conta Supabase, etc.
2.  **Clonar Repositório.**
3.  **Instalar Dependências (`flutter pub get` para o app, `npm install` ou `yarn install` para o painel admin).**
4.  **Configurar Variáveis de Ambiente (`.env` para o app Flutter e para o painel Next.js):**
    ```dotenv
    # Flutter App (.env)
    SUPABASE_URL=SUA_URL_DO_SUPABASE
    SUPABASE_ANON_KEY=SUA_CHAVE_ANONIMA_DO_SUPABASE
    GOOGLE_CLIENT_ID_WEB=
    GOOGLE_CLIENT_ID_ANDROID=
    GOOGLE_CLIENT_ID_IOS=
    APPLE_SERVICE_ID=
    ANDROID_REDIRECT_SCHEME=com.aya.app # Exemplo
    IOS_BUNDLE_ID=com.aya.app         # Exemplo
    WEB_REDIRECT_URL_AFTER_LOGIN=     # Ex: [https://app.suaurl.com/login-callback](https://app.suaurl.com/login-callback)
    REVENUECAT_PUBLIC_ANDROID_SDK_KEY=
    REVENUECAT_PUBLIC_IOS_SDK_KEY=
    N8N_WEBHOOK_URL_CHATBOT=

    # Adicionar outras variáveis necessárias para o painel Next.js se houver
    # Ex: NEXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
    # NEXT_PUBLIC_SUPABASE_ANON_KEY=${SUPABASE_ANON_KEY}
    ```
5.  **Configurar Backend Supabase:** Migrações SQL, Provedores OAuth (com callbacks corretos: `com.aya.app://login-callback` para mobile, e as URLs web para o app e para o painel admin), RLS, Storage.
6.  **Configuração Específica por Plataforma (OAuth, Ícones, Splash para o app Flutter).**
7.  **Executar Projetos (App Flutter e Painel Admin Next.js).**

## 🏛️ 6. Estrutura do Projeto e Convenções de Nomenclatura

A organização do código é crucial. A estrutura do projeto segue a abordagem **Clean Architecture** (Feature-first) com o objetivo de manter a separação de camadas e a escalabilidade do código.

### 6.1.Estrutura de Diretórios em `lib/` (Sugestão)

lib/
├── core/ # Lógica e utilitários centrais, não específicos de features
│ ├── config/ # Configurações globais (ex: URLs de API se não no .env)
│ ├── constants/ # Constantes da aplicação (rotas, chaves de storage, etc.)
│ ├── supabase/ # Configuração e inicialização do Supabase
│ ├── theme/ # app_theme.dart (com ThemeData e AyaColors), app_constants_design.dart (paddings, radius)
│ └── utils/ # Funções utilitárias globais (formatadores, validadores)
├── features/ # Módulos funcionais do app
│ ├── auth/ # Autenticação (login, cadastro, perfil)
│ │ ├── data/ # Fontes de dados (models específicos, repositories)
│ │ │ ├── models/ # ex: user_credentials_model.dart
│ │ │ └── repositories/ # ex: auth_repository.dart (implementação)
│ │ ├── domain/ # Lógica de negócio (entities, usecases, interfaces de repository)
│ │ │ ├── entities/ # ex: user_entity.dart
│ │ │ ├── repositories/ # ex: i_auth_repository.dart (interface)
│ │ │ └── usecases/ # ex: login_usecase.dart
│ │ └── presentation/ # Camada de UI
│ │ ├── providers/ # Gerenciamento de estado (Riverpod providers)
│ │ ├── screens/ # Telas/Páginas completas (ex: login_screen.dart)
│ │ └── widgets/ # Widgets específicos desta feature
│ ├── dashboard/ # Estrutura similar para Dashboard
│ ├── content_library/ # Estrutura similar para Biblioteca e consumo de conteúdo
│ ├── community/ # Estrutura similar para Comunidade
│ ├── admin_panel/ # Estrutura similar para o Painel Admin (se integrado)
│ └── ... # Outras features
├── models/ # (Alternativa) Modelos de dados globais/compartilhados se não em shared/
├── services/ # (Alternativa) Serviços globais se não em core/services/ ou feature/data/
├── shared/ # Widgets e lógica compartilhados entre múltiplas features
│ ├── widgets/ # ex: AyaButtonWidget, AyaCardWidget
│ └── models/ # Modelos de dados globais (ex: LessonModel, ModuleModel)
└── main.dart # Ponto de entrada
└── app_widget.dart # Widget raiz do MaterialApp e configuração de tema/rotas
└── routes.dart # Configuração do GoRouter

## ✨ 7. Funcionalidades Chave (Escopo)

* [✅] Autenticação Completa (Email/Senha, Google, Apple) para o App.
* [🚧] Dashboard Personalizado do Usuário no App.
* [🚧] Biblioteca de Conteúdo no App (Módulos, Pastas, Aulas).
    * [🚧] Player de Áudio Avançado (com download offline, espectro visual dinâmico).
    * [🚧] Player de Vídeo Avançado (com download offline).
    * [🚧] Visualizador de PDF.
    * [🚧] Renderizador de Rich-Text (HTML).
    * [🚧] LiveStream de Conteúdo (visualização no app).
* [🚧] Interações com Conteúdo no App (Likes, Favoritos, Comentários, Anotações Privadas).
* [🚧] Sistema de Gamificação no App (Pontos, Níveis, Badges, Desafios).
* [✅] Perfil do Usuário no App (Dados, Progresso).
* [🚧] Gerenciamento de Assinaturas (RevenueCat, integrado ao App e visualização no Painel Admin).
* [🚧] Comunidade no App (Fóruns, Leaderboards, Desafios em Grupo).
* [🚧] Chatbot de IA no App (Sugestões, Playlists Personalizadas via n8n).
* **[🚧] Painel de Administração Externo (Next.js):**
    * [🚧] Gerenciamento de Conteúdo (CMS):
        * Criação, edição e exclusão de Módulos, Pastas, Subpastas e Aulas.
        * Suporte para tipos de aula: Vídeo, Áudio (com upload de arquivo e metadados para espectro), PDF, Rich-Text (com editor WYSIWYG).
        * Adição de título, descrição, materiais complementares para aulas.
        * Organização e reordenação de todo o conteúdo exibido no app.
        * Configuração dos conteúdos do Hero Slider no Dashboard do app.
    * [🚧] Gerenciamento de Usuários e Roles (visualização, atribuição de papéis).
    * [🚧] Moderação da Comunidade (comentários, posts em fóruns).
    * [🚧] Gerenciamento de Gamificação:
        * Criação e configuração de Desafios em Grupo.
        * Definição de Pontos e Recompensas (Badges).
    * [🚧] Visualização de dados de Assinaturas e Pagamentos (via RevenueCat).
    * [🚧] Configurações de personalização do app (ex: features flags, cores de componentes específicos relacionados a conteúdos, se viável).
    * [🚧] Gerenciamento de Lives (agendamento, links).

## 🗺️ 8. Roadmap de Desenvolvimento (Visão Geral)

1.  **Fase 1: Estabilização e Estrutura Base (App Flutter - Atual)**
    * Resolver todos os erros e warnings do `flutter analyze`.
    * Aplicar estrutura de diretórios e nomenclatura do `STYLE_GUIDE.md`.
    * Implementar o tema visual base (cores, **tipografia Inter** e Serifada para títulos) do `STYLE_GUIDE.md`.
    * Autenticação mockada.
2.  **Fase 2: Layouts Funcionais e Navegação Completa (App Flutter)**
    * Reconstruir o Dashboard com Hero Slider e navegação Módulo > Pasta (com dados mockados já integrados ao Supabase).
    * Criar `FolderPage` e `SubfolderPage` (se aplicável) com dados mockados.
    * Garantir que `LessonPage` e todos os players/viewers (Vídeo, Áudio com espectro visual, PDF, **Rich-Text funcional**) estejam operando com estética AYA base e dados mockados consistentes.
    * Implementar a navegação completa do Dashboard até a Aula.
3.  **Fase 3: Integração Backend e Funcionalidades Avançadas (App Flutter e Início Painel Admin)**
    * Conectar todas as telas e funcionalidades do App ao Supabase (CRUD, interações, gamificação).
    * Implementar sistema de Livestreams (visualização no App).
    * Implementar Roles e RLS no Supabase.
    * Desenvolver Chatbot de IA.
    * Início do desenvolvimento do Painel de Administração Externo (Next.js) com funcionalidades CRUD básicas para conteúdo.
4.  **Fase 4: Autenticação Real, Monetização e Refinamento Premium (App Flutter e Finalização Painel Admin)**
    * Implementar fluxos OAuth e Email/Senha reais no App.
    * Integrar RevenueCat no App.
    * Aplicar efeitos "glassmorphism", blur, animações sofisticadas no App.
    * Finalizar e integrar todas as funcionalidades do Painel de Administração Externo.
5.  **Fase 5: Testes e Produção (App Flutter e Painel Admin).**

## 🤝 9. Como Contribuir

Contribuições são bem-vindas! Para contribuir:

1.  Faça um fork deste projeto.
2.  Crie uma nova branch para sua feature: `git checkout -b feature/MinhaNovaFeature`
3.  Faça commit de suas mudanças: `git commit -m 'Adiciona MinhaNovaFeature'`
4.  Faça push para a branch: `git push origin feature/MinhaNovaFeature`
5.  Abra um Pull Request para a branch `main` ou `develop`.

Por favor, siga as convenções de código do projeto e adicione testes para novas funcionalidades.

## ❓ 10. Suporte e Contato

* Se encontrar um bug ou tiver uma sugestão, por favor, abra uma [Issue](https://github.com/fernandopicardi/app-aya-v2/issues).
* Para outras questões, entre em contato com [Seu Nome/Email de Contato].

## 📜 11. Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Feito com ♥ para sua jornada de bem-estar e autoconhecimento.