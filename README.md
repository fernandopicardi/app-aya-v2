# App Aya

Plataforma de autoconhecimento, meditação e bem-estar para mulheres, construída com Flutter + Supabase.

## Visão Geral
O App Aya oferece:
- Meditações guiadas, jornadas de autoconhecimento e comunidade
- Gamificação (desafios, badges, pontos)
- Sistema de assinatura (planos gratuitos e pagos)
- Painel de Administração completo para gestão de usuários, conteúdo, comunidade e configurações

## Tecnologias
- **Flutter** (Web, Mobile)
- **Supabase** (Auth, Database, Storage, RLS)
- **GoRouter** (Navegação)
- **Supabase Auth** (Email/senha, Google, Apple)
- **Supabase Storage** (Uploads de mídia)

## Estrutura de Pastas
```
lib/
├── config/                # Temas, rotas, helpers globais
├── core/                  # Configuração do Supabase, utilitários
├── features/
│   ├── admin/             # Painel de Administração (navegação, seções)
│   │   ├── admin_dashboard_page.dart
│   │   ├── admin_menu.dart
│   │   └── sections/
│   │       ├── admin_dashboard_overview.dart
│   │       ├── admin_users_section.dart
│   │       ├── admin_content_section.dart
│   │       ├── admin_moderation_section.dart
│   │       ├── admin_gamification_section.dart
│   │       ├── admin_logs_section.dart
│   │       └── admin_settings_section.dart
│   ├── auth/              # Login, registro, AuthService
│   ├── content/           # Módulos, pastas, aulas, páginas de conteúdo
│   ├── dashboard/         # Dashboard do usuário
│   ├── landing/           # Landing page (pública)
│   ├── subscription/      # Planos, pagamentos
│   └── ...                # Outras features (comunidade, fórum, etc)
├── shared/                # Widgets reutilizáveis
└── main.dart              # Entry point

supabase/
├── migrations/            # Scripts SQL de schema, RLS, triggers
└── ...
```

## Fluxo de Autenticação
- Cadastro/login via email/senha, Google ou Apple
- Supabase Auth + tabela `profiles` (com coluna `role`)
- RLS protege todos os dados sensíveis
- Redirecionamento automático para dashboard ou painel admin conforme role

## Painel de Administração
- Acesso restrito a usuários com `role = 'admin'`
- Navegação lateral com seções:
  - Dashboard (KPIs, ações rápidas)
  - Usuários (CRUD, alteração de role)
  - Conteúdo (CRUD de módulos, pastas, aulas)
  - Moderação (comentários, posts)
  - Gamificação (desafios, badges)
  - Logs de auditoria
  - Configurações globais

## Setup Local
1. **Clone o repositório:**
   ```bash
   git clone <repo-url>
   cd app-aya-v2
   ```
2. **Configure o Supabase:**
   - Crie um projeto no [Supabase](https://supabase.com/)
   - Copie as chaves para `lib/core/supabase_config.dart`
   - Execute os scripts SQL em `supabase/migrations/` para criar o schema e RLS
3. **Instale as dependências:**
   ```bash
   flutter pub get
   ```
4. **Rode o app:**
   ```bash
   flutter run -d chrome
   # ou para mobile: flutter run
   ```

## Comandos Úteis
- `flutter analyze` — análise estática de código
- `flutter run` — rodar o app
- `flutter test` — rodar testes (se houver)

## Observações
- Para definir o primeiro admin, altere manualmente a coluna `role` na tabela `profiles` para 'admin' via Supabase SQL.
- O painel admin pode ser expandido para web dedicada no futuro.
- Assets de imagens devem ser adicionados em `assets/images/` e referenciados no `pubspec.yaml`.

---

**App Aya** — Transformando vidas com autoconhecimento e bem-estar.
