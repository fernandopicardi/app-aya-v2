# App Aya

Aplicativo de saúde e bem-estar focado em autoconhecimento, equilíbrio, meditação e práticas de saúde mental.

## Tecnologias Utilizadas

- Flutter
- Supabase
- Riverpod
- Go Router
- Flutter SVG
- Google Fonts
- Flutter Animate
- Cached Network Image
- Just Audio
- Shimmer
- Google Sign In
- Sign In With Apple
- Flutter Secure Storage
- SQLite

## Configuração do Ambiente

1. Clone o repositório:
```bash
git clone https://github.com/fernandopicardi/app-aya-v2.git
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure as variáveis de ambiente:
   - Crie um arquivo `.env` na raiz do projeto
   - Adicione as seguintes variáveis:
     ```
     SUPABASE_URL=sua_url_do_supabase
     SUPABASE_ANON_KEY=sua_chave_anonima_do_supabase
     ```

4. Execute o projeto:
```bash
flutter run
```

## Estrutura do Projeto

```
lib/
  ├── config/           # Configurações do app
  ├── features/         # Funcionalidades do app
  │   ├── admin/       # Área administrativa
  │   ├── auth/        # Autenticação
  │   ├── content/     # Conteúdo do app
  │   ├── dashboard/   # Dashboard do usuário
  │   ├── landing/     # Página inicial
  │   ├── subscription/# Assinaturas
  │   └── user/        # Perfil do usuário
  ├── services/        # Serviços
  └── main.dart        # Ponto de entrada
```

## Funcionalidades

- Autenticação com Google e Apple
- Dashboard personalizado
- Conteúdo de meditação e bem-estar
- Sistema de gamificação
- Perfil do usuário
- Assinaturas
- Área administrativa

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
