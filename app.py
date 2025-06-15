from aiohttp import web
from datetime import datetime

async def hello(request):
    """Hello worldを返すハンドラー"""
    return web.Response(text='Hello World!')

async def get_current_datetime(request):
    """現在日時を返すハンドラー"""
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    return web.Response(text=current_time)

async def init_app():
    """アプリケーションの初期化"""
    app = web.Application()
    
    # ルートの設定
    app.router.add_get('/api/hello', hello)
    app.router.add_get('/api/datetime', get_current_datetime)
    
    # 静的ファイルの設定
    app.router.add_static('/', path='static', name='static')
    
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