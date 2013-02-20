[![Dependency Status](https://gemnasium.com/SonicGarden/kanna.png)](https://gemnasium.com/SonicGarden/kanna)

# Kanna

Kanna は Ruby on Rails と Phonegap (Cordova) を繋いで、Railsエンジニアにも簡単に
モバイルアプリを作成することができるようにするフレームワークです。
Railsでアプリを開発しているのと同じ感覚でモバイルアプリを作れることを目指します。

## セットアップ

Gemfileに以下の行を追加してください。

    gem 'kanna'

で、次を実行

    $ bundle

generator を実行してください。これで、モバイルアプリを作成する雛形を作ります。

    $ rails g kanna:install

以下の様に、ディレクトリが作成されます。


````
Root
├── Guardfile
└── app
    └── kanna
        ├── ios                # ios 用の設定ファイルを配置します。
        │   └── Cordova.plist
        ├── src                # モバイルアプリのソースコード(haml, sass, coffee)を配置します。
        │   ├── css
        │   │   └── application.sass
        │   ├── haml
        │   │   └── index.haml
        │   └── js
        │       ├── application.coffee
        │       └── kanna.coffee
        └── www                # Cordovaに配置するために生成されるソースコードです。
            ├── index.html     # app/src/haml/index.html から生成されます
            ├── js
            ├── css
            └── vendor
                ├── cordova-2.3.0.js
                ├── jquery-1.8.3.min.js
                ├── json2.js
                └── rails_ujs_custom.js
````


kanna では guard を使って、haml, coffee-script, sass のソースコードをコンパイルします。guardを実行してください。
(現状、generateしたファイルのコンパイルは行わないので、一旦src以下のすべてのファイルをtouchしてください。)

    $ guard

以下の、rakeコマンドでios用のプロジェクトを生成します。`tmp/#{Appname}-ios`というディレクトリに生成されます。

    $ rake kanna:ios:init

以下のコマンドで`app/kanna/www`以下のファイルをプロジェクト内にコンパイルしてアプリのビルドを行います。
ios-sim コマンドがインストールされている場合は自動的にシュミレータが起動してアプリが動きます。

    $ rake kanna:ios:build

アプリのデバックについては、通常シュミレータ上で動かす必要がありますが、kannaでは開発環境のブラウザ上で
確認ができます。

    $ rails server

でサーバを起動して、`http://localhost:3000/www/index.html`にアクセスしてください。ブラウザ上でアプリ相当の画面が動きます。

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
