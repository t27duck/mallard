const { webpackConfig, merge } = require('@rails/webpacker')

// MiniCssExtractPlugin is already loaded as a plugin, but in dev mode it does
// not include the content hash. This removes the plugin, and we will make our
// own instance of it to always include contentHash in the resulting file name.
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
webpackConfig.plugins = webpackConfig.plugins.filter(p => p.constructor.name != 'MiniCssExtractPlugin')

const customConfig = {
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/[name]-[contenthash:8].css',
      chunkFilename: 'css/[id]-[contenthash:8].css'
    })
  ],
  resolve: {
    extensions: ['.css', '.scss']
  }
}

module.exports = merge(webpackConfig, customConfig)
