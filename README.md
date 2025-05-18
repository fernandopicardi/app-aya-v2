# App Aya

Aplicativo de saúde e bem-estar focado em autoconhecimento, equilíbrio, meditação, espiritualidade e práticas de saúde mental para iniciantes e usuários avançados.

## Visão Geral

O App Aya é uma plataforma multiplataforma (iOS, Android, Web) desenvolvida com Flutter para o frontend e Supabase como principal plataforma de backend. O objetivo é criar uma plataforma motivacional com conteúdo rico, uma comunidade de suporte, elementos gamificados e um chatbot de IA interativo.

## Tecnologias Utilizadas

- **Frontend**: Flutter
- **Backend**: Supabase (Autenticação, Banco de Dados, Storage, Edge Functions, Realtime)
- **Gerenciamento de Estado**: Flutter Riverpod
- **Navegação**: Go Router
- **Integrações Externas**: RevenueCat (assinaturas), n8n (automação de fluxos), OpenAI (modelo de IA)

## Estrutura do Projeto

```
app_aya_v2/
├── assets/            # Recursos estáticos (imagens, ícones, áudio)
├── lib/
│   ├── config/        # Configurações globais (tema, rotas, constantes)
│   ├── core/          # Funcionalidades centrais (autenticação, API, storage)
│   ├── features/      # Módulos de funcionalidades do aplicativo
│   ├── shared/        # Widgets e utilitários compartilhados
│   └── main.dart      # Ponto de entrada do aplicativo
└── test/              # Testes automatizados
```

## Identidade Visual

### Paleta de Cores

- **Fundo**: #2A2939FF (com degradês para #474C72FF)
- **Texto**: #F8F8FF (Ghost White)
- **Menu/Cabeçalhos**: #474C72FF
- **Secundário**: #575C84FF
- **Botões Primários**: #ACA1EFFF (degradê para #73BDDAFF)
- **Links/Botões Secundários**: #73BDDAFF
- **Indicadores**: #78C7B4FF
- **Cards**: #8DB1D1FF (degradê para #78C7B4FF)

### Estética

Feminina, curvas suaves, cantos arredondados (8px), ícones delicados, ilustrações empoderadoras.

## Configuração do Projeto

### Pré-requisitos

- Flutter SDK (versão mais recente)
- Dart SDK
- Conta no Supabase

### Instalação

1. Clone o repositório
2. Execute `flutter pub get` para instalar as dependências
3. Configure as variáveis de ambiente do Supabase no arquivo `main.dart`
4. Execute `flutter run` para iniciar o aplicativo

## Funcionalidades Planejadas

- Autenticação de usuários
- Conteúdo de saúde e bem-estar
- Sistema de gamificação
- Comunidade de suporte
- Chatbot de IA interativo
- Meditações guiadas com áudio
- Sistema de assinaturas premium
