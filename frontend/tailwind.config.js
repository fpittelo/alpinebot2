/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Swiss inspired palette
        'swiss-red': '#FF0000',
        'swiss-white': '#FFFFFF',
        'slate-850': '#1e293b', // Custom dark shade
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      }
    },
  },
  plugins: [],
}
