#!/usr/bin/env python3
"""
Windows と Ubuntu の両方で動作する aiohttp アプリケーション起動スクリプト
"""

import sys
import os
from aiohttp import web

async def hello(request):
    """Hello worldを返すハンドラー"""
    return web.Response(text='Hello World!')

async def init_app():
    """アプリケーションの初期化"""
    app = web.Application()
    
    # ルートの設定
    app.router.add_get('/', hello)
    
    return app

def main():
    """メイン関数"""
    print("Starting aiohttp web application...")
    print("Platform:", sys.platform)
    print("Python version:", sys.version)
    
    app = init_app()
    
    # WindowsとUbuntuの両方で動作するように設定
    print("Server starting on http://localhost:8080")
    print("Press Ctrl+C to stop the server")
    
    web.run_app(
        app,
        host='localhost',  # ローカルホストでリッスン
        port=8080,         # ポート8080を使用
        access_log=None    # アクセスログを無効化
    )

if __name__ == '__main__':
    main()