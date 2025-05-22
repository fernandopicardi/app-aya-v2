<!-- markdownlint-disable MD013 MD033 MD041 MD007 MD012 MD022 MD024 MD025 MD026 MD029 MD030 MD031 MD032 MD036 MD037 MD038 MD039 MD040 MD042 MD043 MD044 MD045 MD046 MD047 MD048 MD049 MD050 MD051 MD052 MD053 MD054 MD055 MD056 MD057 MD058 MD059 MD060 MD061 MD062 MD063 MD064 MD065 MD066 MD067 MD068 MD069 MD070 MD071 MD072 MD073 MD074 MD075 MD076 MD077 MD078 MD079 MD080 MD081 MD082 MD083 MD084 MD085 MD086 MD087 MD088 MD089 MD090 MD091 MD092 MD093 MD094 MD095 MD096 MD097 MD098 MD099 MD100 MD101 MD102 MD103 MD104 MD105 MD106 MD107 MD108 MD109 MD110 MD111 MD112 MD113 MD114 MD115 MD116 MD117 MD118 MD119 MD120 MD121 MD122 MD123 MD124 MD125 MD126 MD127 MD128 MD129 MD130 MD131 MD132 MD133 MD134 MD135 -->

# App Aya 🧘‍♀️✨

**Um caminho de profundo cuidado com a sua existência.**

App Aya é um aplicativo multiplataforma (iOS, Android, Web) de saúde e bem-estar, desenvolvido com Flutter e Supabase. Nosso foco é auxiliar usuários em sua jornada de autoconhecimento, equilíbrio, meditação, espiritualidade e práticas de saúde mental, oferecendo conteúdo rico, uma comunidade de suporte, gamificação e interações personalizadas com IA.

[![Status da Build](URL_DO_SEU_STATUS_DE_BUILD_AQUI_SE_TIVER_CI_CD)](URL_DO_SEU_PIPELINE_DE_CI_CD)
[![Licença: MIT](https://img.shields.io/badge/Licença-MIT-lavender.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.19.x-blueviolet)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-green)](https://supabase.io)

## 🌟 Visão Geral e Proposta de Valor

O App Aya foi criado para ser um santuário digital, um companheiro na busca por uma vida mais consciente e equilibrada. Inspirado em uma estética feminina, moderna e serena, o aplicativo oferece:

*   **Conteúdo Transformador:** Meditações guiadas, jornadas de autoconhecimento, vídeos inspiradores, áudios relaxantes, artigos e PDFs.
*   **Personalização com IA:** Um assistente virtual para tirar dúvidas, sugerir conteúdos e criar playlists personalizadas.
*   **Comunidade Acolhedora:** Fóruns de discussão e desafios em grupo para troca de experiências e suporte mútuo.
*   **Gamificação Motivadora:** Níveis, pontos e badges para incentivar a progressão e o engajamento.
*   **Flexibilidade de Acesso:** Planos de assinatura para diferentes necessidades, incluindo conteúdo gratuito.

## 🛠️ Stack Tecnológica Principal

*   **Frontend:** [Flutter](https://flutter.dev/) (para iOS, Android e Web)
    *   **Gerenciamento de Estado:** [Riverpod](https://riverpod.dev/)
    *   **Roteamento:** [Go Router](https://pub.dev/packages/go_router)
    *   **Assets Vetoriais:** [Flutter SVG](https://pub.dev/packages/flutter_svg)
    *   **Fontes Customizadas:** [Google Fonts](https://pub.dev/packages/google_fonts)
    *   **Animações:** [Flutter Animate](https://pub.dev/packages/flutter_animate)
    *   **Imagens em Cache:** [Cached Network Image](https://pub.dev/packages/cached_network_image)
    *   **Player de Áudio:** [Just Audio](https://pub.dev/packages/just_audio)
    *   **Efeitos de Carregamento:** [Shimmer](https://pub.dev/packages/shimmer)
    *   **Autenticação Social:**
        *   [Google Sign In](https://pub.dev/packages/google_sign_in)
        *   [Sign In With Apple](https://pub.dev/packages/sign_in_with_apple)
    *   **Armazenamento Seguro:** [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) (para tokens ou dados sensíveis do cliente)
    *   **Banco de Dados Local:** [SQFlite](https://pub.dev/packages/sqflite) (para downloads offline e cache)
    *   **Variáveis de Ambiente:** [Flutter DotEnv](https://pub.dev/packages/flutter_dotenv)
*   **Backend:** [Supabase](https://supabase.io/)
    *   **Banco de Dados:** PostgreSQL
    *   **Autenticação:** Supabase Auth (Email/Senha, Google, Apple)
    *   **Armazenamento de Arquivos:** Supabase Storage
    *   **Funções Serverless:** Supabase Edge Functions
    *   **Realtime:** Supabase Realtime Subscriptions
*   **Monetização:** [RevenueCat](https://www.revenuecat.com/)
*   **Automação e IA:** [n8n](https://n8n.io/) (como intermediário para o modelo de IA)

## 🚀 Configuração do Ambiente de Desenvolvimento

Siga os passos abaixo para configurar e executar o projeto localmente:

1.  **Pré-requisitos:**
    *   Flutter SDK (versão 3.19.x ou superior recomendada)
    *   Um editor de código (VS Code, Android Studio, IntelliJ IDEA)
    *   Conta no Supabase (para configurar seu próprio backend)
    *   (Opcional) Contas de desenvolvedor Google e Apple para configurar o OAuth.

2.  **Clonar o Repositório:**
    ```bash
    git clone https://github.com/fernandopicardi/app-aya-v2.git
    cd app-aya-v2
    ```

3.  **Instalar Dependências do Flutter:**
    ```bash
    flutter pub get
    ```

4.  **Configurar Variáveis de Ambiente:**
    *   Crie um arquivo `.env` na raiz do projeto, copiando o conteúdo de `.env.example` (se existir, caso contrário, crie do zero).
    *   Preencha as seguintes variáveis com suas credenciais e configurações:
        ```dotenv
        # Supabase
        SUPABASE_URL=SUA_URL_DO_SUPABASE
        SUPABASE_ANON_KEY=SUA_CHAVE_ANONIMA_DO_SUPABASE

        # Google OAuth (substitua pelos seus IDs de cliente)
        GOOGLE_CLIENT_ID_WEB=SEU_GOOGLE_CLIENT_ID_PARA_WEB
        GOOGLE_CLIENT_ID_ANDROID=SEU_GOOGLE_CLIENT_ID_PARA_ANDROID # Pode ser o mesmo do web para serverClientId do google_sign_in
        GOOGLE_CLIENT_ID_IOS=SEU_GOOGLE_CLIENT_ID_PARA_IOS # Geralmente do GoogleService-Info.plist

        # Apple Sign In (o Service ID é o principal para a config no Supabase)
        APPLE_SERVICE_ID=SEU_APPLE_SERVICE_ID

        # Callbacks/Redirects (esquemas para deep linking e web)
        ANDROID_REDIRECT_SCHEME=com.aya.app
        IOS_BUNDLE_ID=com.aya.app
        WEB_REDIRECT_URL_AFTER_LOGIN=SUA_URL_DE_REDIRECIONAMENTO_WEB

        # Outras chaves, se necessário (ex: RevenueCat API Keys, n8n webhook URL)
        REVENUECAT_ANDROID_API_KEY=
        REVENUECAT_IOS_API_KEY=
        N8N_WEBHOOK_URL=
        ```
    *   **Importante:** Nunca comite o arquivo `.env` com suas credenciais reais. Ele já deve estar no `.gitignore`.

5.  **Configuração do Supabase Backend:**
    *   Acesse seu projeto no [Supabase Dashboard](https://app.supabase.io).
    *   Execute os scripts SQL de migração localizados em `supabase/migrations/` para criar o schema do banco de dados (tabelas, roles, RLS, triggers).
        *   `20240320000000_initial_schema.sql`
        *   `20240320000001_roles_and_rls.sql`
        *   (Adicionar outros scripts de migração conforme evoluem)
    *   Configure os provedores de autenticação OAuth (Google, Apple) no painel do Supabase, utilizando as URLs de callback:
        *   Android: `com.aya.app://login-callback`
        *   iOS: `com.aya.app://login-callback`
        *   Web: Sua URL de redirecionamento web
    *   Configure as políticas de Row Level Security (RLS) para todas as tabelas.
    *   Crie os Buckets no Supabase Storage (ex: `aya-content`, `user-avatars`) e defina suas políticas de acesso.

6.  **Configuração Específica por Plataforma (OAuth):**
    *   **Android:**
        *   Gere e configure o fingerprint SHA-1/SHA-256 no Google Cloud Console para seu `applicationId`.
        *   Configure o `intent-filter` para o deep linking no `AndroidManifest.xml`.
    *   **iOS:**
        *   Adicione `CFBundleURLTypes` no `Info.plist` para Google e Supabase callback.
        *   Habilite a capacidade "Sign in with Apple" no Xcode e configure no Apple Developer Portal.
        *   (Se usar Firebase para Google Sign-in no iOS) Adicione o `GoogleService-Info.plist`.
    *   (Consulte o guia detalhado de configuração OAuth para mais informações).

7.  **Executar o Projeto:**
    *   Selecione um dispositivo/emulador.
    *   ```bash
      flutter run
      ```
    *   Para executar na web:
        ```bash
        flutter run -d chrome
        ```

## 🏛️ Estrutura do Projeto (Diretório `lib`)

A estrutura do projeto visa modularidade e escalabilidade, organizada por funcionalidades.

lib/
├── main.dart # Ponto de entrada principal da aplicação
├── routes.dart # Configuração de rotas (Go Router)
├── core/ # Lógica central, constantes, helpers, tema
│ ├── theme/ # Definição do tema visual "AYA" (AppTheme)
│ └── supabase_config.dart # Configuração inicial do cliente Supabase
├── config/ # (REVISAR: Pode ser mesclado com core/ ou removido se redundante)
├── features/ # Módulos principais da aplicação
│ ├── admin/ # Funcionalidades do Painel de Administração (se integrado)
│ │ ├── models/
│ │ ├── screens/
│ │ ├── services/
│ │ └── widgets/
│ ├── auth/ # Autenticação (Login, Cadastro, Perfil, Roles)
│ ├── content/ # Exibição de conteúdo (Módulos, Pastas, Aulas, Players)
│ ├── community/ # Fóruns, Interações Sociais
│ ├── dashboard/ # Dashboard principal do usuário
│ ├── gamification/ # Lógica e UI de Gamificação
│ ├── landing/ # Landing Page Web (se diferente da informativa principal)
│ ├── subscription/ # Gerenciamento de Planos e Assinaturas (RevenueCat)
│ └── user/ # Funcionalidades específicas do perfil do usuário (Favoritos, Anotações)
├── models/ # Modelos de dados globais (se houver, senão dentro de features)
├── services/ # Serviços de negócio reutilizáveis (AuthService, ContentService, etc.)
├── shared/ # Widgets e utilitários compartilhados entre features
│ └── widgets/
└── widgets/ # (REVISAR: Pode ser mesclado com shared/widgets/ ou referir-se a widgets específicos de features)

## ✨ Funcionalidades Implementadas e Planejadas

*   [✅] Autenticação Completa (Email/Senha, Google, Apple)
*   [🚧] Dashboard Personalizado do Usuário
*   [🚧] Biblioteca de Conteúdo (Módulos, Pastas, Aulas)
    *   [🚧] Player de Áudio Avançado (com download offline)
    *   [🚧] Player de Vídeo Avançado
    *   [🚧] Visualizador de PDF
    *   [🚧] Renderizador de Rich-Text (HTML)
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

*(Legenda: ✅ = Concluído, 🚧 = Em Andamento/Planejado)*

## 🎨 Identidade Visual "AYA"

O design do App Aya é fundamental para a experiência. Ele é caracterizado por:
*   **Paleta de Cores Serena:** Fundos escuros (roxo/azul profundo `#2A2939FF`), acentos em lavanda suave (`#ACA1EFFF`, `#575C84FF`) e verde água (`#78C7B4FF`, `#73BDDAFF`), com textos em branco (`#F8F8FF`). Uso de degradês sutis.
*   **Tipografia Elegante:** Combinação de uma fonte Serifada para títulos de impacto e uma Sans-serif (Roboto/Open Sans) limpa para o restante.
*   **Estética Feminina e Moderna:** Cantos arredondados, ícones delicados, espaçamento generoso, ilustrações e fotografias que evocam calma, natureza e bem-estar.
*   (Consulte `lib/core/theme/app_theme.dart` para a implementação do tema).

## 🗺️ Roadmap (Visão Geral)

1.  **Fase 1: Estabilização e Correções** - Resolver todos os erros do `flutter analyze`, estabilizar os serviços de Auth e Admin.
2.  **Fase 2: Implementação da Identidade Visual AYA** - Aplicar consistentemente o tema e a estética em todas as telas.
3.  **Fase 3: Finalização das Funcionalidades do Usuário** - Completar todos os módulos do usuário final (Conteúdo, Comunidade, Gamificação, IA).
4.  **Fase 4: Desenvolvimento/Finalização do Painel Admin.**
5.  **Fase 5: Testes Abrangentes, Otimização e Preparação para Produção.**

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1.  Faça um fork deste projeto.
2.  Crie uma nova branch para sua feature: `git checkout -b feature/MinhaNovaFeature`
3.  Faça commit de suas mudanças: `git commit -m 'Adiciona MinhaNovaFeature'`
4.  Faça push para a branch: `git push origin feature/MinhaNovaFeature`
5.  Abra um Pull Request para a branch `main` ou `develop`.

Por favor, siga as convenções de código do projeto e adicione testes para novas funcionalidades.

## ❓ Suporte e Contato

*   Se encontrar um bug ou tiver uma sugestão, por favor, abra uma [Issue](https://github.com/fernandopicardi/app-aya-v2/issues).
*   Para outras questões, entre em contato com [Seu Nome/Email de Contato].

## 📜 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Feito com ♥ para o seu bem-estar.