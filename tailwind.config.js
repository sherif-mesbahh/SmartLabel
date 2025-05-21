/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "node_modules/flowbite-react/lib/esm/**/*.js",
  ],
  darkMode: "class",
  theme: {
    extend: {
      animation: {
        fadeIn: "fadeIn 0.5s ease-in-out",
        slideInUp: "slideInUp 0.5s ease-out",
        slideInUpDelay: "slideInUp 0.5s ease-out 0.1s",
      },
      screens: {
        xs: { min: "500px" },
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideInUp: {
          "0%": {
            opacity: "0",
            transform: "translateY(20px)",
          },
          "100%": {
            opacity: "1",
            transform: "translateY(0)",
          },
        },
      },
    },
    fontFamily: {
      quicksand: ["Quicksand", "sans-serif"],
    },
  },
  plugins: [require("flowbite/plugin")],
};
