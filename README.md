<!-- markdownlint-disable MD013 MD033 MD041 MD007 MD012 MD022 MD024 MD025 MD026 MD029 MD030 MD031 MD032 MD036 MD037 MD038 MD039 MD040 MD042 MD043 MD044 MD045 MD046 MD047 MD048 MD049 MD050 MD051 MD052 MD053 MD054 MD055 MD056 MD057 MD058 MD059 MD060 MD061 MD062 MD063 MD064 MD065 MD066 MD067 MD068 MD069 MD070 MD071 MD072 MD073 MD074 MD075 MD076 MD077 MD078 MD079 MD080 MD081 MD082 MD083 MD084 MD085 MD086 MD087 MD088 MD089 MD090 MD091 MD092 MD093 MD094 MD095 MD096 MD097 MD098 MD099 MD100 MD101 MD102 MD103 MD104 MD105 MD106 MD107 MD108 MD109 MD110 MD111 MD112 MD113 MD114 MD115 MD116 MD117 MD118 MD119 MD120 MD121 MD122 MD123 MD124 MD125 MD126 MD127 MD128 MD129 MD130 MD131 MD132 MD133 MD134 MD135 -->

# App Aya 🧘‍♀️✨

**Um caminho de profundo cuidado com a sua existência.**

Bem-vindo ao repositório oficial do App Aya! Este documento serve como o guia central para desenvolvedores e colaboradores, detalhando a visão do projeto, tecnologias, fluxo do usuário, estrutura de conteúdo, configuração, e como contribuir.

[![Status da Build](URL_DO_SEU_STATUS_DE_BUILD_AQUI_SE_TIVER_CI_CD)](URL_DO_SEU_PIPELINE_DE_CI_CD)
[![Licença: MIT](https://img.shields.io/badge/Licença-MIT-lavender.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.19.x-blueviolet)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-green)](https://supabase.io)

## 🌟 1. Visão Geral do Projeto

App Aya é um aplicativo multiplataforma (iOS, Android, Web) de saúde e bem-estar, construído com Flutter para o frontend e Supabase para o backend. Nossa missão é fornecer um santuário digital que auxilie os usuários em sua jornada de autoconhecimento, equilíbrio emocional, meditação, desenvolvimento espiritual e práticas de saúde mental.

### 1.1. Proposta de Valor
*   **Conteúdo Transformador e Curado:** Meditações, jornadas temáticas, vídeos, áudios, artigos (Rich Text) e PDFs.
*   **Personalização Inteligente:** Assistente virtual (IA) para dúvidas, sugestões e criação de playlists.
*   **Comunidade Acolhedora:** Fóruns e desafios em grupo.
*   **Gamificação Motivadora:** Níveis, pontos e badges.
*   **Design Premium e Intuitivo:** Interface moderna, elegante, com estética feminina e serena.
*   **Acesso Flexível:** Planos de assinatura (Gratuito, Mensal, Anual).
*   **Lives Interativas:** Eventos ao vivo dentro do app.

## 🎨 2. Design e Identidade Visual

A identidade visual do App Aya é fundamental. Ela é caracterizada por uma estética **clean, premium, moderna, feminina e serena.** Todos os detalhes sobre cores, a família de fontes **Inter** (e seus fallbacks: `ui-sans-serif, system-ui, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji`), espaçamentos, componentes, **iconografia (Iconoir)**, animações e a aplicação do efeito "glassmorphism" estão documentados em nosso **`STYLE_GUIDE.md`**. Este guia é a fonte da verdade para todas as decisões de UI/UX.

## 🌊 3. Fluxo do Usuário (User Flow) e Estrutura de Navegação de Conteúdo

### 3.1. Fluxo Principal do Usuário
1.  **Primeiro Acesso (Usuário Não Logado):**
    *   **Web (Desktop):** Acesso à landing page informativa completa (`caminhoaya.com`), que apresenta todos os benefícios, planos, e direciona para a página inicial da aplicação web para Login/Assinatura.
    *   **Aplicação Web (Deslogado):** Página inicial da aplicação (`app.caminhoaya.com`) com destaque visual (vídeo curto), e opções claras de "Entrar" ou "Ver Planos e Assinar".
    *   **Mobile (Android/iOS):** Abertura direta na tela de Login, com um link proeminente para "Criar Conta".
2.  **Autenticação:**
    *   **Tela de Login:** Campos para Email/Senha, Login Social (Google, Apple), link "Esqueci Senha".
    *   **Tela de Cadastro:** Campos para Nome, Email, Senha, Confirmação de Senha, aceite de Termos. Cadastro Social (Google, Apple). Link para Login.
    *   **Tela de Recuperação de Senha.**
    *   **Tela de Planos de Assinatura:** Apresentação dos planos (Gratuito, Mensal, Anual) e seus benefícios, levando ao fluxo de pagamento (RevenueCat).
3.  **Usuário Logado:**
    *   **Dashboard (Home):** Tela inicial principal.
    *   **Navegação Principal (BottomNavigationBar e Drawer):** Home, Biblioteca, Comunidade, Chat IA. (O Perfil é acessado pelo Drawer).
    *   Acesso ao conteúdo, perfil, configurações, etc.

### 3.2. Estrutura de Navegação e Consumo de Conteúdo
A navegação pelo conteúdo é hierárquica, promovendo uma jornada de descoberta:

1.  **`DashboardScreen` (Home):**
    *   **Hero Slider:** Destaques dinâmicos (novos conteúdos, eventos, planos).
    *   **Seções de Módulos:** Abaixo do Hero, são listados os **Módulos Principais** (ex: "Meditação para Iniciantes", "Astrologia na Prática"). Cada seção de módulo exibe:
        *   Título do Módulo.
        *   Uma **lista horizontal rolável de cards representando as Pastas** contidas nesse módulo. Cada card de Pasta exibe um thumbnail e o título da Pasta.
        *   Se um Módulo não tiver Pastas, ele exibirá diretamente uma lista horizontal de cards de Aulas.
2.  **`FolderPage` (Página da Pasta):**
    *   Acessada ao clicar em um card de Pasta no Dashboard ou na Biblioteca.
    *   **Conteúdo:**
        *   Banner/Título da Pasta.
        *   Se a Pasta contiver **Subpastas**, exibe uma lista (vertical ou horizontal) de cards de Subpastas (com thumbnail e título).
        *   Se a Pasta contiver **Aulas diretamente** (sem Subpastas), exibe uma lista vertical de cards de Aulas.
3.  **`SubfolderPage` (Página da Subpasta - se aplicável):**
    *   Acessada ao clicar em um card de Subpasta na `FolderPage`.
    *   **Conteúdo:**
        *   Banner/Título da Subpasta.
        *   Lista vertical de cards de **Aulas** contidas nesta Subpasta.
4.  **`LessonPage` (Página da Aula/Conteúdo):**
    *   Acessada ao clicar em um card de Aula.
    *   Exibe o conteúdo específico da aula (Vídeo, Áudio com espectro visual, Artigo Rich-Text, PDF) e todas as funcionalidades interativas (Like, Favoritar, Anotações, Download de Materiais, Comentários, Próxima Aula), conforme detalhado no PDR e nas discussões.

### 3.3. Outras Telas Principais
*   **`LibraryScreen` (Biblioteca):** Visão completa de todo o conteúdo, com filtros avançados (por Módulo, tipo de conteúdo, etc.) e busca.
*   **`CommunityScreen` (Comunidade):** Acesso a Fóruns, Leaderboards, Desafios em Grupo.
*   **`ChatIAScreen` (Aya Chat):** Interface para interação com o assistente virtual.
*   **`UserProfileScreen` (Perfil - acessado pelo Drawer):** Dados do usuário, progresso, downloads, configurações, gerenciamento de assinatura.
*   **`AdminDashboardPage` (Painel Admin - acesso condicional por role):** Gerenciamento básico da plataforma. Será criado um AdminDashboard por fora para gerenciar todo o app, seus conteúdos e personalização. Então o app deve ser parado para essa integração.

## 🛠️ 4. Stack Tecnológica Principal

*   **Frontend:** [Flutter](https://flutter.dev/) (iOS, Android, Web)
    *   **Gerenciamento de Estado:** [Riverpod](https://riverpod.dev/)
    *   **Roteamento:** [Go Router](https://pub.dev/packages/go_router)
    *   **Variáveis de Ambiente:** [Flutter DotEnv](https://pub.dev/packages/flutter_dotenv)
    *   **Cliente HTTP:** [Dio](https://pub.dev/packages/dio)
    *   **Integração Backend:** [Supabase Flutter](https://pub.dev/packages/supabase_flutter)
    *   **Fontes:** [Google Fonts](https://pub.dev/packages/google_fonts) (configurado para **Inter** e seus fallbacks)
    *   **Ícones:** [Iconoir](https://iconoir.com/) (ou um pacote Flutter que os disponibilize, ex: `iconoir_flutter`)
    *   **Imagens:** [Cached Network Image](https://pub.dev/packages/cached_network_image)
    *   **Players:** `just_audio` (+ `just_audio_background`), `video_player`.
    *   **Visualizadores:** `syncfusion_flutter_pdfviewer`, `flutter_html`.
    *   **Visualização de Áudio:** `audio_visualizer` (ou alternativa baseada na pesquisa para integração com `just_audio`).
    *   **Armazenamento Seguro:** `flutter_secure_storage`.
    *   **Config App:** `flutter_launcher_icons`, `flutter_native_splash`.
*   **Backend:** [Supabase](https://supabase.io/) (PostgreSQL, Auth, Storage, Edge Functions, Realtime).
*   **Monetização:** [RevenueCat](https://www.revenuecat.com/).
*   **Automação/IA:** [n8n](https://n8n.io/).

## 🚀 5. Configuração do Ambiente de Desenvolvimento

1.  **Pré-requisitos:** Flutter SDK 3.19.x+, Editor, Conta Supabase, etc.
2.  **Clonar Repositório.**
3.  **Instalar Dependências (`flutter pub get`).**
4.  **Configurar Variáveis de Ambiente (`.env`):**
    ```dotenv
    SUPABASE_URL=SUA_URL_DO_SUPABASE
    SUPABASE_ANON_KEY=SUA_CHAVE_ANONIMA_DO_SUPABASE
    GOOGLE_CLIENT_ID_WEB=
    GOOGLE_CLIENT_ID_ANDROID=
    GOOGLE_CLIENT_ID_IOS=
    APPLE_SERVICE_ID=
    ANDROID_REDIRECT_SCHEME=com.aya.app # Exemplo
    IOS_BUNDLE_ID=com.aya.app         # Exemplo
    WEB_REDIRECT_URL_AFTER_LOGIN=     # Ex: https://app.suaurl.com/login-callback
    REVENUECAT_PUBLIC_ANDROID_SDK_KEY=
    REVENUECAT_PUBLIC_IOS_SDK_KEY=
    N8N_WEBHOOK_URL_CHATBOT=
    ```
5.  **Configurar Backend Supabase:** Migrações SQL, Provedores OAuth (com callbacks corretos: `com.aya.app://login-callback` para mobile, e a URL web), RLS, Storage.
6.  **Configuração Específica por Plataforma (OAuth, Ícones, Splash).**
7.  **Executar Projeto.**

## 🏛️ 6. Estrutura do Projeto e Convenções de Nomenclatura

A organização do código é crucial. **Consulte o `STYLE_GUIDE.md` para:**
*   **Estrutura de Diretórios Detalhada.**
*   **Convenções de Nomenclatura Completas.**

## ✨ 7. Funcionalidades Chave (Escopo)

*   [✅] Autenticação Completa (Email/Senha, Google, Apple)
*   [🚧] Dashboard Personalizado do Usuário
*   [🚧] Biblioteca de Conteúdo (Módulos, Pastas, Aulas)
    *   [🚧] Player de Áudio Avançado (com download offline)
    *   [🚧] Player de Vídeo Avançado (com download offline)
    *   [🚧] Visualizador de PDF
    *   [🚧] Renderizador de Rich-Text (HTML)
    *   [🚧] LiveStream de Conteúdo feitas pelos administradores e armazenadas no Supabase junto aos conteúdos (Será como o Módulo Lives)
*   [🚧] Interações com Conteúdo (Likes, Favoritos, Comentários, Anotações Privadas)
*   [🚧] Sistema de Gamificação (Pontos, Níveis, Badges, Desafios)
*   [✅] Perfil do Usuário (Dados, Progresso)
*   [🚧] Gerenciamento de Assinaturas (RevenueCat)
*   [🚧] Comunidade (Fóruns, Leaderboards, Desafios em Grupo)
*   [🚧] Chatbot de IA (Sugestões, Playlists Personalizadas via n8n)
*   [🚧] Painel de Administração (Integrado ou Web Separado)
    *   [🚧] Gerenciamento de Conteúdo (CMS)
    *   [🚧] Gerenciamento de Usuários e Roles
    *   [🚧] Moderação da Comunidade
    *   [🚧] Gerenciamento de Gamificação
    *     [🚧] Configuração de personalização do app
    *     [🚧] Gerenciamento completo dos conteúdos (Módulos, Pastas, SubPastas, Aulas) e sua ordem de exibição nas páginas e compoenentes do APP.
    *     [🚧] COnfiguração dos conteúdos exibidos na Hero Slider. 
    *     [🚧] Configuração completa dos Desafios em Grupo, Recompensas, etc. 




## 🗺️ 8. Roadmap de Desenvolvimento (Visão Geral)

1.  **Fase 1: Estabilização e Estrutura Base (Atual)**
    *   Resolver todos os erros e warnings do `flutter analyze`.
    *   Aplicar estrutura de diretórios e nomenclatura do `STYLE_GUIDE.md`.
    *   Implementar o tema visual base (cores, **tipografia Inter**) do `STYLE_GUIDE.md`.
    *   Autenticação mockada.
2.  **Fase 2: Layouts Funcionais e Navegação Completa**
    *   Reconstruir o Dashboard com Hero Slider e navegação Módulo > Pasta (com dados mockados já integrados ao Supabase).
    *   Criar `FolderPage` e `SubfolderPage` (se aplicável) com dados mockados.
    *   Garantir que `LessonPage` e todos os players/viewers (Vídeo, Áudio com espectro, PDF, **Rich-Text funcional**) estejam operando com estética AYA base e dados mockados consistentes.
    *   Implementar a navegação completa do Dashboard até a Aula.
3.  **Fase 3: Integração Backend e Funcionalidades Avançadas**
    *   Conectar todas as telas e funcionalidades ao Supabase (CRUD, interações, gamificação).
    *   Implementar sistema de Livestreams.
    *   Implementar Roles e RLS.
    *   Desenvolver Chatbot de IA, Lives, Painel Admin.
4.  **Fase 4: Autenticação Real, Monetização e Refinamento Premium**
    *   Implementar fluxos OAuth e Email/Senha reais.
    *   Integrar RevenueCat.
    *   Aplicar efeitos "glassmorphism", blur, animações sofisticadas.
5.  **Fase 5: Testes e Produção.**

## 🤝 9. Como Contribuir 

Contribuições são bem-vindas! Para contribuir:

1.  Faça um fork deste projeto.
2.  Crie uma nova branch para sua feature: `git checkout -b feature/MinhaNovaFeature`
3.  Faça commit de suas mudanças: `git commit -m 'Adiciona MinhaNovaFeature'`
4.  Faça push para a branch: `git push origin feature/MinhaNovaFeature`
5.  Abra um Pull Request para a branch `main` ou `develop`.

Por favor, siga as convenções de código do projeto e adicione testes para novas funcionalidades.

## ❓ 10. Suporte e Contato

*   Se encontrar um bug ou tiver uma sugestão, por favor, abra uma [Issue](https://github.com/fernandopicardi/app-aya-v2/issues).
*   Para outras questões, entre em contato com [Seu Nome/Email de Contato].

## 📜 11. Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Feito com ♥ para sua jornada de bem-estar e autoconhecimento.