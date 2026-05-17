# 🐾 CAC Vet — Sistema de Gestão Veterinária

Aplicação desktop desenvolvida em **Flutter** para gerenciamento de clínicas veterinárias. Permite cadastro e controle de clientes e animais, autenticação via API externa (Keycloak) com fallback local, e conta com um assistente de IA integrado para dúvidas veterinárias.

---

## Funcionalidades

- **Autenticação** — Login e cadastro de usuários via API REST (Keycloak). Caso a API esteja indisponível, o sistema faz fallback para autenticação local via SQLite.
- **Cadastro de Clientes** — Nome, telefone, e-mail, endereço e CPF.
- **Cadastro de Animais** — Nome, espécie, raça, idade e nome do dono.
- **Listagem com busca** — Listagem de clientes e animais com pesquisa e opções de editar/excluir.
- **Assistente IA** — Chat integrado com IA especializada em cuidados veterinários, acessível pelo botão flutuante em qualquer tela.

---

## Pré-requisitos

### 1. Flutter SDK

Baixe e instale o Flutter SDK:

- Acesse: https://docs.flutter.dev/get-started/install/windows/desktop
- Extraia o arquivo em um diretório (ex: `C:\flutter`)
- Adicione `C:\flutter\bin` à variável de ambiente **PATH** do sistema

Verifique a instalação:

```bash
flutter --version
```

### 2. Dart SDK

O Dart já vem incluído no Flutter SDK. Não é necessário instalar separadamente.

### 3. Visual Studio (Build Tools para Windows)

O Flutter precisa do Visual Studio para compilar apps Windows nativos.

- Baixe o **Visual Studio 2022** (Community é gratuito): https://visualstudio.microsoft.com/
- Durante a instalação, selecione a carga de trabalho:
  - ✅ **Desenvolvimento para desktop com C++**
- Certifique-se de que os seguintes componentes estão marcados:
  - MSVC (compilador C++)
  - Windows SDK

### 4. Git

Necessário para o Flutter e gerenciamento do projeto:

- Baixe em: https://git-scm.com/download/win
- Adicione ao **PATH** se não for feito automaticamente

### 5. Verificação do ambiente

Após instalar tudo, execute:

```bash
flutter doctor
```

Todos os itens devem aparecer com ✅. Corrija eventuais pendências apontadas.

---

## Dependências do projeto

| Pacote | Função |
|---|---|
| `sqflite` / `sqflite_common_ffi` | Banco de dados SQLite local |
| `http` | Requisições HTTP para APIs REST |
| `path` | Manipulação de caminhos do banco |

---

## Como rodar

1. **Clone o repositório:**

```bash
git clone <url-do-repositorio>
cd <nome-do-projeto>
```

2. **Instale as dependências:**

```bash
flutter pub get
```

3. **Execute no Windows:**

```bash
flutter run -d windows
```

---

## Estrutura do projeto

```
lib/
├── constants/
│   └── app_theme.dart          # Cores, tipografia e formas do tema
├── database/
│   └── database_helper.dart    # CRUD SQLite (clientes, animais, usuários)
├── models/
│   ├── animal.dart             # Modelo Animal
│   ├── auth_model.dart         # Modelo de autenticação
│   └── cliente.dart            # Modelo Cliente
├── screens/
│   ├── cadastro_ani_page.dart  # Tela de cadastro de animais
│   ├── cadastro_cli_page.dart  # Tela de cadastro de clientes
│   ├── cadastro_page.dart      # Tela de cadastro de usuário
│   ├── home_page.dart          # Tela principal com menu
│   ├── listagem_ani_page.dart  # Listagem de animais
│   ├── listagem_cli_page.dart  # Listagem de clientes
│   └── login_page.dart         # Tela de login
├── services/
│   └── auth_service.dart       # Serviço de autenticação e chat IA
├── widgets/
│   ├── input_field.dart        # Campo de input reutilizável
│   ├── main_layout.dart        # Layout principal + chat IA
│   ├── paw_logo.dart           # Logo do app
│   └── side_menu.dart          # Menu lateral
└── main.dart                   # Ponto de entrada da aplicação
```

---

## APIs utilizadas

| Endpoint | Método | Descrição |
|---|---|---|
| `/api/auth/login` | POST | Autenticação via Keycloak |
| `/api/register` | POST | Cadastro de novo usuário |
| `/api/ai/chat` | POST | Chat com assistente IA veterinário |

Base URLs:
- **Autenticação:** `https://mobile-ios-login.zani0x03.eti.br/api`
- **IA:** `https://mobile-ios-ia.zani0x03.eti.br/api`

---

## Banco de dados local (SQLite)

O app utiliza SQLite via `sqflite_common_ffi` para desktop. O banco `petshop.db` é criado automaticamente na primeira execução com as tabelas:

- **clientes** — id, nome, telefone, email, endereco, cpf
- **animais** — id, nome, especie, raca, idade, nome_dono
- **usuarios** — id, login, senha (fallback local)

---

## Observações

- O projeto é voltado para **Windows desktop**. Para rodar em outras plataformas, ajustes podem ser necessários na configuração do SQLite.
- O token de autenticação (Keycloak) expira em 10 horas. Após expirar, é necessário fazer login novamente.
- O assistente IA funciona apenas com um token válido obtido via login na API externa.
