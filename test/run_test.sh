#!/bin/bash

# Limpa o cache do Flutter
flutter clean

# Obtém as dependências
flutter pub get

# Executa os testes
flutter test test/run_test.dart 