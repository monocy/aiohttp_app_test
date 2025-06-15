const { useState, useEffect } = React;

function App() {
    const [message, setMessage] = useState('');
    const [apiResponse, setApiResponse] = useState('');
    const [loading, setLoading] = useState(false);
    const [currentDateTime, setCurrentDateTime] = useState('');

    useEffect(() => {
        setMessage('Hello from React!');
        // 自動的に現在日時を取得
        fetchDateTime();
    }, []);

    const fetchDateTime = async () => {
        try {
            const response = await fetch('/api/datetime');
            const data = await response.text();
            setCurrentDateTime(data);
        } catch (error) {
            console.error('Error fetching datetime:', error);
        }
    };

    const callAPI = async () => {
        setLoading(true);
        try {
            // Call hello API
            const response = await fetch('/api/hello');
            const data = await response.text();
            setApiResponse(data);
            
            // Update datetime
            await fetchDateTime();
        } catch (error) {
            setApiResponse('Error: ' + error.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="app-container">
            <h1 className="title">🚀 Aiohttp + React</h1>
            <p className="subtitle">{message}</p>
            
            <div className="tech-stack">
                <div className="tech-item">React 18</div>
                <div className="tech-item">Aiohttp</div>
                <div className="tech-item">Python 3.11</div>
                <div className="tech-item">Poetry</div>
                <div className="tech-item">pyenv</div>
            </div>
            
            <button 
                className="button" 
                onClick={callAPI}
                disabled={loading}
            >
                {loading ? '読み込み中...' : 'API呼び出し'}
            </button>
            
            {apiResponse && (
                <div className="api-response">
                    <strong>APIレスポンス:</strong> {apiResponse}
                </div>
            )}
            
            {currentDateTime && (
                <div className="api-response">
                    <strong>現在日時:</strong> {currentDateTime}
                </div>
            )}
        </div>
    );
}

// アプリケーションをレンダリング
ReactDOM.render(<App />, document.getElementById('root'));