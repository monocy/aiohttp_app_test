# Aiohttp Web Application

WindowsとUbuntuの両方で動作するaiohttpを使ったシンプルなWebアプリケーションです。

## 必要な環境

- Python 3.11
- pipenv

## セットアップ

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