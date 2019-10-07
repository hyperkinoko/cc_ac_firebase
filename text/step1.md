# はじめに
このカリキュラムでは、firebaseというクラウドサービスを使って、簡単にWebサービスを作る方法を学びます。

## 必要となる前提知識

### HTML/CSS
CodeCampのHTML/CSSカリキュラムを修了している、または、修了相当の知識を持っていること。

### javascript
CodeCampのjavascriptカリキュラムを修了している、または、修了相当の知識を持っていること。

### コンソール、ターミナル
Windowsのコマンドプロンプト、Macのターミナルがある程度抵抗感なく使えること。  
各コマンドに関しては、今回のカリキュラムで追々覚えていってもらっても大丈夫です。

# 準備

この教材を学習するためには以下の準備が必要です。

1. Googleアカウント
1. Node.jsのインストール（npmコマンドが使える）
1. gitのインストールとgithubアカウント
1. IntelliJ IDEA、Visual Studio Code、EclipseなどのIDE

# firebaseを使ってみる

## プロジェクトの作成

1. [https://firebase.google.com/](https://firebase.google.com/)からfirebaseにログインし、firebase console へ移動する。

1. プロジェクトを作成する。([動画](../movie/step1-create.mp4))

## Webアプリの作成

1. 簡単なHTMLファイルを作っておく。

```index.html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Hello Firebase</title>
</head>
<body>
    Hello, Firebase!
</body>
</html>
```

1. firebase consoleでwebアプリに追加する。([動画](../movie/step1-create.mp4))

```html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シンプルチャット</title>
</head>
<body>
    <div id="box"></div>
</body>
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="/__/firebase/7.0.0/firebase-app.js"></script>

<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->

<!-- Initialize Firebase -->
<script src="/__/firebase/init.js"></script>
</html>
```

---

次は[step2](./step2.md)に進みます




