#!/usr/bin/env python3
"""
Windows と Ubuntu の両方で動作する aiohttp + React アプリケーション
"""

import sys
import os
from pathlib import Path
from aiohttp import web

async def api_hello(request):
    """API: Hello worldを返すハンドラー"""
    return web.Response(text='Hello from Aiohttp API!')

async def index(request):
    """React アプリケーションのindex.htmlを返す"""
    static_dir = Path(__file__).parent / 'static'
    index_file = static_dir / 'index.html'
    
    if index_file.exists():
        return web.FileResponse(index_file)
    else:
        return web.Response(text='React app not found', status=404)

async def init_app():
    """アプリケーションの初期化"""
    app = web.Application()
    
    # 静的ファイルの配信設定
    static_dir = Path(__file__).parent / 'static'
    if static_dir.exists():
        app.router.add_static('/static/', path=static_dir, name='static')
    
    # ルートの設定
    app.router.add_get('/', index)  # React アプリケーション
    app.router.add_get('/api/hello', api_hello)  # API エンドポイント
    
    return app

def main():
    """メイン関数"""
    print("Starting aiohttp + React web application...")
    print("Platform:", sys.platform)
    print("Python version:", sys.version)
    
    app = init_app()
    
    # WindowsとUbuntuの両方で動作するように設定
    print("Server starting on http://localhost:8080")
    print("React app available at: http://localhost:8080")
    print("API endpoint at: http://localhost:8080/api/hello")
    print("Press Ctrl+C to stop the server")
    
    web.run_app(
        app,
        host='localhost',  # ローカルホストでリッスン
        port=8080,         # ポート8080を使用
        access_log=None    # アクセスログを無効化
    )

if __name__ == '__main__':
    main()