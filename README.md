# Aiohttp + React Web Application

WindowsとUbuntuの両方で動作するaiohttp + Reactを使ったモダンなWebアプリケーションです。

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

- **Reactアプリケーション**: http://localhost:8080
- **API エンドポイント**: http://localhost:8080/api/hello

React製のモダンなUIが表示され、「API呼び出し」ボタンでPython APIとの連携が確認できます。

## 停止方法

ターミナルで `Ctrl+C` を押してサーバーを停止します。

## 技術スタック

### フロントエンド
- **React 18**: モダンなUIライブラリ
- **Babel**: JSXのトランスパイル
- **ES6+**: 最新のJavaScript機能

### バックエンド
- **aiohttp**: 非同期Pythonウェブフレームワーク
- **Python 3.11**: 最新のPython機能
- **静的ファイル配信**: Reactアプリの配信

### 開発環境管理
- **Poetry**: 依存関係管理とパッケージングツール
  - `pyproject.toml`での依存関係管理
  - 仮想環境の自動作成・管理
  - `poetry.lock`での正確なバージョン固定
  - PEP 668対応
- **pyenv**: Pythonバージョン管理
  - プロジェクトごとの異なるPythonバージョン使用
  - システムPythonに影響しない複数バージョン共存
  - `.python-version`でのプロジェクト自動切り替え

## 注意事項

- Ubuntu環境では、curlとビルドツールのインストールが必要です
- 初回実行時はpyenv、Poetry、Python 3.11、依存関係のインストールのため時間がかかる場合があります
- PipenvのPipfileとPipfile.lockは削除されています（Poetry + pyenvに移行）