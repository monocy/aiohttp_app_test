# Aiohttp Web Application

WindowsとUbuntuの両方で動作するaiohttpを使ったシンプルなWebアプリケーションです。

## 必要な環境

- Python 3.8以上
- Poetry（依存関係管理ツール）

## クイックスタート（Ubuntu/Linux）

```bash
# リポジトリをクローン
git clone https://github.com/monocy/aiohttp_app_test.git
cd aiohttp_app_test

# 実行権限を付与して起動（PoetryとPoetryは自動でインストールされます）
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

## Poetryの利点

- **依存関係の管理**: `pyproject.toml`で依存関係を明確に管理
- **仮想環境の自動作成**: Poetryが自動的に仮想環境を作成・管理
- **ロックファイル**: `poetry.lock`で正確なバージョンを固定
- **PEP 668対応**: システムパッケージを保護しながら安全にパッケージ管理

## 注意事項

- Ubuntu環境では、curlとPython 3.8以上のインストールが必要です
- 初回実行時はPoetryと依存関係のインストールのため時間がかかる場合があります
- PipenvのPipfileとPipfile.lockは削除されています（Poetryに移行）