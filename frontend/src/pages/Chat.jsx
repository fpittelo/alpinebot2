import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const Chat = () => {
  const navigate = useNavigate();
  const [messages, setMessages] = useState([
    { role: 'assistant', content: "Grüezi! I'm AlpineBot. How can I help you explore Switzerland today? 🧀" }
  ]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    const token = localStorage.getItem('auth_token');
    if (!token) {
      navigate('/');
    }
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('auth_token');
    navigate('/');
  };

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage = { role: 'user', content: input };
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);

    try {
      // Prepare messages for API (system prompt could be added here or in backend)
      const apiMessages = [
        { role: "system", content: "You are AlpineBot, a helpful AI assistant for Switzerland." },
        ...messages,
        userMessage
      ];

      const apiUrl = (import.meta.env.VITE_API_URL || '') + '/api/chat';
      const response = await fetch(apiUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ messages: apiMessages }),
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      const data = await response.json();
      setMessages(prev => [...prev, { role: 'assistant', content: data.content }]);
    } catch (error) {
      console.error('Error:', error);
      setMessages(prev => [...prev, { role: 'assistant', content: "Sorry, I encountered an error connecting to the Swiss Alps. 🏔️" }]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col font-sans">
      {/* Header */}
      <header className="bg-white border-b border-slate-200 px-6 py-4 flex items-center justify-between sticky top-0 z-10">
        <div className="flex items-center gap-2">
          <span className="text-2xl">🏔️</span>
          <span className="font-bold text-lg text-slate-800">AlpineBot</span>
        </div>
        <button
          onClick={handleLogout}
          className="text-sm text-slate-500 hover:text-red-600 font-medium transition-colors"
        >
          Logout
        </button>
      </header>

      {/* Main Chat Area */}
      <main className="flex-1 max-w-4xl w-full mx-auto p-4 flex flex-col">
        <div className="flex-1 bg-white rounded-2xl shadow-sm border border-slate-100 p-6 mb-4 overflow-y-auto min-h-[500px] max-h-[70vh]">
          <div className="flex flex-col gap-4">
            {messages.map((msg, index) => (
              <div key={index} className={`flex gap-4 ${msg.role === 'user' ? 'flex-row-reverse' : ''}`}>
                <div className={`w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-white text-xs ${msg.role === 'user' ? 'bg-slate-700' : 'bg-red-600'}`}>
                  {msg.role === 'user' ? 'U' : 'AB'}
                </div>
                <div className={`rounded-2xl px-4 py-3 max-w-[80%] ${msg.role === 'user' ? 'bg-slate-800 text-white rounded-tr-none' : 'bg-slate-100 text-slate-700 rounded-tl-none'}`}>
                  <p>{msg.content}</p>
                </div>
              </div>
            ))}
            {isLoading && (
               <div className="flex gap-4">
               <div className="w-8 h-8 rounded-full bg-red-600 flex items-center justify-center flex-shrink-0 text-white text-xs">AB</div>
               <div className="bg-slate-100 rounded-2xl rounded-tl-none px-4 py-3 text-slate-700">
                 <p className="animate-pulse">Thinking...</p>
               </div>
             </div>
            )}
          </div>
        </div>

        {/* Input Area */}
        <div className="relative">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && sendMessage()}
            placeholder="Ask about trains, cheese, or mountains..."
            className="w-full bg-white border border-slate-300 rounded-xl px-4 py-4 pr-12 focus:outline-none focus:ring-2 focus:ring-red-500/20 focus:border-red-500 transition-all shadow-sm"
            disabled={isLoading}
          />
          <button 
            onClick={sendMessage}
            disabled={isLoading}
            className="absolute right-3 top-1/2 -translate-y-1/2 p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
          >
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className="w-5 h-5">
              <path strokeLinecap="round" strokeLinejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
            </svg>
          </button>
        </div>
      </main>
    </div>
  );
};

export default Chat;
