const path = require('path')

const serverlessWebpack = require('serverless-webpack')
const webpackNodeExternals = require('webpack-node-externals')
const CopyPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: serverlessWebpack.lib.entries,
  target: 'node',
  mode: serverlessWebpack.lib.webpack.isLocal ? 'development' : 'production',
  // UPSTREAM: https://github.com/serverless-heaven/serverless-webpack/issues/651#issuecomment-718787162
  optimization: {
    concatenateModules: false,
    minimize: false
  },
  performance: {
    hints: false
  },
  devtool: 'nosources-source-map',
  externals: [webpackNodeExternals()],
  ...(serverlessWebpack.lib.webpack.isLocal
    ? {
        resolve: {
          modules: [path.join(__dirname, 'node_modules')]
        }
      }
    : {}),
  module: {
    rules: [
      {
        test: /\.js$/,
        use: [
          {
            loader: 'babel-loader'
          }
        ]
      }
    ]
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        {
          from: 'package.json',
          transform(content, absoluteFrom) {
            const pkg = JSON.parse(content.toString())
            delete pkg.type
            return Buffer.from(JSON.stringify(pkg))
          }
        }
      ]
    })
  ],
  output: {
    libraryTarget: 'commonjs2',
    path: path.join(__dirname, '.webpack'),
    filename: '[name].js',
    sourceMapFilename: '[file].map'
  }
}
