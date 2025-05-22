@echo off

REM Limpa o cache do Flutter
flutter clean

REM Obtém as dependências
flutter pub get

REM Executa os testes
flutter test test/run_test.dart 