from aiohttp import web
import aiohttp_cors

async def hello(request):
    """Hello worldを返すハンドラー"""
    return web.Response(text='Hello World!')

async def init_app():
    """アプリケーションの初期化"""
    app = web.Application()
    
    # CORSの設定（必要に応じて）
    cors = aiohttp_cors.setup(app, defaults={
        "*": aiohttp_cors.ResourceOptions(
            allow_credentials=True,
            expose_headers="*",
            allow_headers="*",
        )
    })
    
    # ルートの設定
    app.router.add_get('/', hello)
    
    # CORSをルートに追加
    for route in list(app.router.routes()):
        cors.add(route)
    
    return app

def main():
    """メイン関数"""
    app = init_app()
    
    # WindowsとUbuntuの両方で動作するように設定
    web.run_app(
        app,
        host='0.0.0.0',  # すべてのインターフェースでリッスン
        port=8080,       # ポート8080を使用
        access_log=None  # アクセスログを無効化（オプション）
    )

if __name__ == '__main__':
    main()