# Aiohttp Web Application

WindowsとUbuntuの両方で動作するaiohttpを使ったシンプルなWebアプリケーションです。

## 必要な環境

- Python 3.11（pyenvで自動管理）
- Poetry（依存関係管理ツール）
- pyenv（Pythonバージョン管理）

## クイックスタート（Ubuntu/Linux）

```bash
# リポジトリをクローン
git clone https://github.com/monocy/aiohttp_app_test.git
cd aiohttp_app_test

# 実行権限を付与して起動（pyenv、Poetry、Python 3.11が自動でインストールされます）
chmod +x start.sh
./start.sh
```

## セットアップ

### 手動セットアップの場合
1. Poetryをインストール:
```bash
curl -sSL https://install.python-poetry.org | python3 -
```

2. 依存関係をインストール:
```bash
poetry install
```

## 実行方法

### Windows
```cmd
start.bat
```
または
```cmd
poetry run python start.py
```

### Ubuntu/Linux
```bash
chmod +x start.sh
./start.sh
```
または
```bash
poetry run python start.py
```

## アクセス

アプリケーションが起動したら、ブラウザで以下のURLにアクセスしてください:
http://localhost:8080

"Hello World!" が表示されます。

## 停止方法

ターミナルで `Ctrl+C` を押してサーバーを停止します。

## Poetry + pyenvの利点

### Poetry
- **依存関係の管理**: `pyproject.toml`で依存関係を明確に管理
- **仮想環境の自動作成**: Poetryが自動的に仮想環境を作成・管理
- **ロックファイル**: `poetry.lock`で正確なバージョンを固定
- **PEP 668対応**: システムパッケージを保護しながら安全にパッケージ管理

### pyenv
- **Pythonバージョン管理**: プロジェクトごとに異なるPythonバージョンを使用可能
- **複数バージョン共存**: システムPythonに影響せずに複数バージョンを管理
- **自動切り替え**: `.python-version`ファイルでプロジェクトのPythonバージョンを自動選択

## 注意事項

- Ubuntu環境では、curlとビルドツールのインストールが必要です
- 初回実行時はpyenv、Poetry、Python 3.11、依存関係のインストールのため時間がかかる場合があります
- PipenvのPipfileとPipfile.lockは削除されています（Poetry + pyenvに移行）