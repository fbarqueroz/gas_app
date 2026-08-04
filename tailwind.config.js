const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}"
  ],
  theme: {
    extend: {
      colors: {
        gekko: {
          green: "#2BAE66",
          "green-dark": "#1E8A4F",
          "green-light": "#E7F7EE",
          black: "#000000",
          ink: "#111111",
          white: "#FFFFFF",
          gray: {
            50: "#FAFAFA",
            100: "#F2F2F2",
            200: "#E4E4E4",
            400: "#9E9E9E",
            600: "#5F5F5F",
            800: "#2A2A2A"
          }
        }
      },
      fontFamily: {
        sans: ["Poppins", ...defaultTheme.fontFamily.sans],
        heading: ["Poppins", ...defaultTheme.fontFamily.sans],
        body: ["Montserrat", ...defaultTheme.fontFamily.sans]
      },
      boxShadow: {
        // Elevaciones estilo Material Design (1dp a 8dp)
        "elevation-1": "0 1px 2px 0 rgba(0,0,0,0.06), 0 1px 3px 0 rgba(0,0,0,0.10)",
        "elevation-2": "0 2px 4px -1px rgba(0,0,0,0.08), 0 4px 6px -1px rgba(0,0,0,0.10)",
        "elevation-4": "0 4px 8px -2px rgba(0,0,0,0.10), 0 10px 15px -3px rgba(0,0,0,0.10)",
        "elevation-8": "0 8px 16px -4px rgba(0,0,0,0.12), 0 20px 25px -5px rgba(0,0,0,0.12)"
      },
      borderRadius: {
        xl: "1rem",
        "2xl": "1.25rem"
      }
    }
  },
  // Nota: se evita depender de plugins npm (ej. @tailwindcss/forms) porque
  // el gem tailwindcss-rails usa el binario standalone de Tailwind (sin
  // Node). Los estilos de formulario ya se resuelven con la clase .gk-field
  // definida en application.tailwind.css.
  plugins: []
}
