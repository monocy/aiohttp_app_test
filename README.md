# Aiohttp Web Application

WindowsとUbuntuの両方で動作するaiohttpを使ったシンプルなWebアプリケーションです。

## 必要な環境

- Python 3.11 (または Python 3.x)
- pipenv

## クイックスタート（Ubuntu/Linux）

```bash
# リポジトリをクローン
git clone https://github.com/monocy/aiohttp_app_test.git
cd aiohttp_app_test

# 実行権限を付与して起動（依存関係は自動でインストールされます）
chmod +x start.sh
./start.sh
```

## セットアップ

### 手動セットアップの場合
1. 依存関係をインストール:
```bash
pipenv install
```

## 実行方法

### Windows
```cmd
start.bat
```
または
```cmd
pipenv run python start.py
```

### Ubuntu/Linux
```bash
chmod +x start.sh
./start.sh
```
または
```bash
pipenv run python start.py
```

## アクセス

アプリケーションが起動したら、ブラウザで以下のURLにアクセスしてください:
http://localhost:8080

"Hello World!" が表示されます。

## 停止方法

ターミナルで `Ctrl+C` を押してサーバーを停止します。

## 注意事項

- Ubuntu環境では、事前にpipenvとPython 3.11（またはPython 3.x）のインストールが必要です
- 初回実行時は依存関係のインストールのため時間がかかる場合があります