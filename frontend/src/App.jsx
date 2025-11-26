import { useState } from 'react'

function App() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-slate-50 to-slate-200 p-4">
      <div className="max-w-md w-full bg-white rounded-2xl shadow-xl overflow-hidden border border-slate-100">
        <div className="p-8 text-center">
          <div className="text-6xl mb-4">🏔️</div>
          <h1 className="text-3xl font-bold text-slate-900 mb-2">AlpineBot.ch</h1>
          <p className="text-slate-600 mb-8">Your AI-powered Sherpa for all things Switzerland.</p>
          
          <div className="bg-slate-50 rounded-lg p-4 border border-slate-200">
            <p className="text-sm text-slate-500">System Status</p>
            <div className="flex items-center justify-center gap-2 mt-2">
              <span className="relative flex h-3 w-3">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-3 w-3 bg-green-500"></span>
              </span>
              <span className="font-medium text-slate-700">Operational</span>
            </div>
          </div>
        </div>
        
        <div className="bg-slate-50 px-8 py-4 border-t border-slate-100 text-center">
          <p className="text-xs text-slate-400">Made with ❤️ and 🧀 in Switzerland</p>
        </div>
      </div>
    </div>
  )
}

export default App
