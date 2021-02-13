module.exports = {
  plugins: [
    require('tailwindcss'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-nested'),
    plugins: {
      'postcss-hash': {
        algorithm: 'sha256',
        trim: 20,
        manifest: './manifest.json'
      },
    },
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
