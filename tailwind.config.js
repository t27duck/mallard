module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/packs/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms')
  ],
}
