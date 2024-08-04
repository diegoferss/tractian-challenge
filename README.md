# Desafio mobile software engineer

## Participante

- Diego F. S. Souza

## Resumo

Esse README contém instruções de como rodar a aplicação mobile do desafio da Tractian, que tem por foco proporcionar um método de visualização de Assets de uma unidade.

### Branches
O projeto contém duas branches diferentes para executar a aplicação:

- [main](https://github.com/diegoferss/tractian-challenge/tree/main) - Nessa branch, o projeto foi feito utilizando o package bloc para gerenciamento de estado, reatividade e lidar com interações do usuário;
- [main-without-bloc](https://github.com/diegoferss/tractian-challenge/tree/main-without-bloc) - Nessa branch, o projeto foi feito utilizando somente o disponibilizado pelo flutter para gerenciamento de estado, reatividade e lidar com interações do usuário.

Ambas branches irão funcionar da mesma forma, a única diferença é o jeito que foram feitas, sinta-se livre para testar a aplicação em cada uma delas!

## Pré-requisitos

Antes de começar, verifique se você atende aos seguintes requisitos:

* Você instalou o `Flutter`.

## Instalação

Para instalar a aplicação, siga estas etapas:

Clone o projeto:
```
git clone https://github.com/diegoferss/tractian-challenge.git
```

ou

```
git@github.com:diegoferss/tractian-challenge.git
```

Instale as depêndencias:
```
flutter pub get
```

## Execução

Rodando a aplicação:

```
flutter run
```

## Estrutura do projeto

```
root/
├── data/ -> Contém todos os dados utilizados pela aplicação fornecidos pelos arquivos JSON
│   └── unit/
│       └── sample.json
├── assets/ -> Contém as imagens utilizadas pela aplicação
├── lib/ -> Código da aplicação
│   ├── adapters/ -> Arquivos para transformação de dados
│   ├── features/ -> Funcionalidades de aplicação
│   │   ├── asset_tree/ -> Funcionalidade específica da aplicação
│   │   │   ├── di/ -> Injeção de dependências da funcionalidade
│   │   │   ├── models/ -> Modelos que representam os dados da utilizados pela minha funcionalidade
│   │   │   │   └── asset.dart
│   │   │   ├── use_cases/ -> Casos de uso específicos da funcionalidade
│   │   │   │   └── fetch_assets_use_case.dart
│   │   │   ├──bloc/ -> Gerenciador de estado e interações do usuário da funcionalidade
|   |   |   |   └── asset_tree_state.dart
|   |   |   |   └── asset_tree_event.dart
|   |   |   |   └── asset_tree_bloc.dart
│   │   │   └── asset_tree_view.dart
│   ├── l10n/ -> Internacionalização da aplicação 
│   ├── support/ -> Arquivos de suporte para aplicação
│   │   ├── components/ -> Componentes comuns da aplicação
│   │   ├── enums/ Enums compartilhados pela aplicação
│   │   ├── extensions/ Extensão de tipos para fornecer novas ações
│   │   ├── router/ Configuração das rotas
│   │   ├── services/ Definição de serviços da minha aplicação
│   │   ├── styles/ Estilos, temas, fontes e cores padrões da aplicação
│   │   ├── utils/ Arquivos voltados para utilidades no geral da aplicação
│   └── main.dart
├── pubspec.yaml
└── README.md
```
