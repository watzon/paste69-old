/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    "./src/pages/**/*.cr",
    "./src/components/**/*.cr",
    "./src/js/**/*.{js,ts}",
  ],
  theme: {
    extend: {
      
    },
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}

