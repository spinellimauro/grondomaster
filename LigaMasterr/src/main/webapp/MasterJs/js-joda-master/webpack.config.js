var fs = require('fs');
var path = require('path');
var webpack = require('webpack');

var minify = JSON.parse(process.env.DIST_MIN || '0');
var sourceMaps = !minify;

function createBanner(){
    var packageJson = require('./package.json');
    var version = '//! @version ' + packageJson.name + ' - ' + packageJson.version + '\n';
    var preamble = fs.readFileSync('./src/license-preamble.js', 'utf8');
    return version + preamble;
}

var banner = createBanner();

module.exports = {
    context: __dirname,
    entry: './src/js-joda.js',
    devtool: sourceMaps ? 'hidden-source-map' : '',
    output: {
        path: __dirname  + '/dist',
        filename: minify ? 'js-joda.min.js' : 'js-joda.js',
        libraryTarget: minify ? 'var' : 'umd',
        library: 'JSJoda'
    },
    module: {
        loaders: [{
            loader: 'babel-loader',
            include: [
                path.resolve(__dirname, 'src'),
                path.resolve(__dirname, 'test')
            ],
            test: /.js$/
        }]
    },
    plugins: minify ? [
        new webpack.optimize.UglifyJsPlugin({
            comments: false,
            compress: {
                warnings: false
            }
        }),
        new webpack.BannerPlugin(
            banner, {raw: true}
        )
    ] : [
        new webpack.BannerPlugin(
            banner, {raw: true}
        )
    ]
};
