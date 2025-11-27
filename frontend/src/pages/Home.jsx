import React from 'react';
import { useGoogleLogin } from '@react-oauth/google';
import { useNavigate } from 'react-router-dom';

const Home = () => {
  const navigate = useNavigate();

  const login = useGoogleLogin({
    onSuccess: (tokenResponse) => {
      console.log(tokenResponse);
      // In a real app, we would verify this token with the backend
      // and establish a session. For now, we just redirect.
      localStorage.setItem('auth_token', tokenResponse.access_token);
      navigate('/chat');
    },
    onError: () => {
      console.error('Login Failed');
      alert('Login Failed');
    },
  });

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col items-center justify-center p-4 font-sans text-slate-900">
      <div className="max-w-md w-full bg-white rounded-2xl shadow-xl overflow-hidden">
        <div className="p-8 text-center">
          <div className="mx-auto h-24 w-24 bg-red-600 rounded-full flex items-center justify-center mb-6 shadow-lg">
            <span className="text-4xl">🏔️</span>
          </div>
          <h1 className="text-3xl font-bold mb-2 tracking-tight">AlpineBot.ch</h1>
          <p className="text-slate-500 mb-8">
            Your AI-powered Sherpa for all things Switzerland. 🇨🇭
          </p>

          <button
            onClick={() => login()}
            className="w-full bg-white border border-slate-300 hover:bg-slate-50 text-slate-700 font-medium py-3 px-4 rounded-lg transition-all duration-200 flex items-center justify-center gap-3 shadow-sm hover:shadow-md"
          >
            <img src="https://www.svgrepo.com/show/475656/google-color.svg" className="w-6 h-6" alt="Google logo" />
            Sign in with Google
          </button>
        </div>
        <div className="bg-slate-50 px-8 py-4 border-t border-slate-100 text-center">
          <p className="text-xs text-slate-400">
            By signing in, you agree to our Terms of Service and Privacy Policy.
          </p>
        </div>
      </div>
    </div>
  );
};

export default Home;
