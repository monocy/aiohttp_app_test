#!/usr/bin/env python3
"""
Windows と Ubuntu の両方で動作する aiohttp + React アプリケーション
"""

import sys
import os
import json
import argparse
from pathlib import Path
from aiohttp import web
from datetime import datetime

async def api_hello(request):
    """API: Hello worldを返すハンドラー"""
    return web.Response(text='Hello from Aiohttp API!')

async def api_datetime(request):
    """API: 現在日時を返すハンドラー"""
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    return web.Response(text=current_time)

async def index(request):
    """React アプリケーションのindex.htmlを返す"""
    static_dir = Path(__file__).parent / 'static'
    index_file = static_dir / 'index.html'
    
    if index_file.exists():
        return web.FileResponse(index_file)
    else:
        return web.Response(text='React app not found', status=404)

def load_settings():
    """設定ファイルを読み込む"""
    settings_file = Path(__file__).parent / 'settings.json'
    
    # デフォルト設定
    default_settings = {
        "server": {
            "host": "localhost",
            "port": 8080,
            "access_log": False
        },
        "app": {
            "name": "AioHTTP React App",
            "version": "1.0.0",
            "debug": False
        },
        "static": {
            "directory": "static",
            "url_prefix": "/static/"
        }
    }
    
    print(f"[設定] 設定ファイルを確認中: {settings_file}")
    
    if settings_file.exists():
        try:
            with open(settings_file, 'r', encoding='utf-8') as f:
                file_settings = json.load(f)
            print(f"[設定] 設定ファイルを正常に読み込みました: {settings_file}")
            
            # ファイル設定でデフォルト設定を更新
            settings = default_settings.copy()
            settings.update(file_settings)
            
            return settings
        except Exception as e:
            print(f"[設定] 設定ファイルの読み込みに失敗しました: {e}")
            print(f"[設定] デフォルト設定を使用します")
            return default_settings
    else:
        print(f"[設定] 設定ファイルが見つかりません。デフォルト設定を使用します")
        return default_settings

async def init_app(settings):
    """アプリケーションの初期化"""
    app = web.Application()
    
    # 静的ファイルの配信設定
    static_dir = Path(__file__).parent / settings['static']['directory']
    if static_dir.exists():
        app.router.add_static(settings['static']['url_prefix'], path=static_dir, name='static')
        print(f"[設定] 静的ファイルディレクトリを設定しました: {static_dir}")
    
    # ルートの設定
    app.router.add_get('/', index)  # React アプリケーション
    app.router.add_get('/api/hello', api_hello)  # API エンドポイント
    app.router.add_get('/api/datetime', api_datetime)  # 日時API エンドポイント
    
    return app

def main():
    """メイン関数"""
    # コマンドライン引数の解析
    parser = argparse.ArgumentParser(description='AioHTTP React Web Application')
    parser.add_argument('--port', type=int, help='サーバーポート番号 (settings.jsonの値を上書き)')
    parser.add_argument('--host', type=str, help='サーバーホスト (settings.jsonの値を上書き)')
    args = parser.parse_args()
    
    print("=" * 50)
    print("AioHTTP + React Web Application 起動中...")
    print("=" * 50)
    print("Platform:", sys.platform)
    print("Python version:", sys.version)
    print()
    
    # 設定を読み込み
    settings = load_settings()
    
    # コマンドライン引数で設定を上書き
    if args.port:
        settings['server']['port'] = args.port
        print(f"[設定] ポートをコマンドライン引数で上書き: {args.port}")
    
    if args.host:
        settings['server']['host'] = args.host
        print(f"[設定] ホストをコマンドライン引数で上書き: {args.host}")
    
    # 環境変数での上書きもサポート
    env_port = os.environ.get('APP_PORT')
    env_host = os.environ.get('APP_HOST')
    
    if env_port:
        try:
            settings['server']['port'] = int(env_port)
            print(f"[設定] ポートを環境変数で上書き: {env_port}")
        except ValueError:
            print(f"[警告] 無効な環境変数 APP_PORT: {env_port}")
    
    if env_host:
        settings['server']['host'] = env_host
        print(f"[設定] ホストを環境変数で上書き: {env_host}")
    
    # 最終的な設定を表示
    host = settings['server']['host']
    port = settings['server']['port']
    access_log = None if not settings['server']['access_log'] else True
    
    print()
    print("[最終設定]")
    print(f"  ホスト: {host}")
    print(f"  ポート: {port}")
    print(f"  アクセスログ: {'有効' if access_log else '無効'}")
    print()
    
    app = init_app(settings)
    
    # WindowsとUbuntuの両方で動作するように設定
    print(f"サーバー起動: http://{host}:{port}")
    print(f"React app: http://{host}:{port}")
    print(f"API endpoint: http://{host}:{port}/api/hello")
    print(f"DateTime API: http://{host}:{port}/api/datetime")
    print()
    print("Ctrl+C でサーバーを停止")
    print("=" * 50)
    
    web.run_app(
        app,
        host=host,
        port=port,
        access_log=access_log
    )

if __name__ == '__main__':
    main()