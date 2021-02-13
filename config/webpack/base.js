const { webpackConfig, merge } = require('@rails/webpacker')

const isDevelopment = module.exports.isDevelopment

/*
,
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        exclude: /node_modules/,
        use: [
          {
            loader: 'style-loader',
          },
          {
            loader: 'css-loader',
            options: {
              importLoaders: 1,
            }
          },
          {
            loader: 'postcss-loader'
          }
        ]
      },
    ],
  }



        use: [
          "style-loader",
          "css-loader",
          {
            loader: "sass-loader",
            options: {
              // Prefer `dart-sass`
              implementation: require("sass"),
            },
          },
        ],
*/
const customConfig = {
  resolve: {
    extensions: ['.css', '.scss']
  }
}

module.exports = merge(webpackConfig, customConfig)
