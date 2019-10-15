# 日付の扱いについて学ぶ

## 投稿日を表示する
メッセージの横に、投稿日時を表示してみましょう。

データを取得して表示している部分はここですね。

```js
//firestoreからデータを読み込みます（orderByを追加、降順）
db.collection("messages").orderBy('postdate', 'desc').get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

以下のように書き換えます。

```js
//firestoreからデータを読み込みます（orderByを追加、降順）
db.collection("messages").orderBy('postdate', 'desc').get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //投稿日時情報も取得します
        var postdate = doc.data().postdate;
        //message、postdateを追加表示します
        $('#box').append("<div class='message'>" + message + "<span class='postdate'>" + postdate + "</span></div>");
    });
});
```

実行すると、何やら長い文字列が表示されました。    
firestoreの内部では、日時情報はTimestampというかたちで保存されています。  
これは、全世界、多言語で汎用的に使える反面、表示するときには何かしらの変換をしてあげないといけません。

簡単なのは、javascriptのDate型に変換することです。  
toDate()メソッドで、Date型に変換できます。

```js
var postdate = doc.data().postdate.toDate();
```

まだ、情報がごちゃっと表示されています。  
もう少しスマートに表示するには、Dateオブジェクトから情報を取り出してあげるといいですね。

```js
var postdate = doc.data().postdate.toDate();

//postdateからいろんな情報を取り出す
var year = postdate.getFullYear();
var month = postdate.getMonth() + 1; //getMonth()は1月が0、12月が11を返します
var day = postdate.getDate();
var hour = postdate.getHours();
var minute = postdate.getMinutes();
var second = postdate.getSeconds();

//表示
$('#box').append("<div class='message'>" + message + "<span class='postdate'>" + year + "/" + month + "/" + day + " " + hour + ":" + minute + ":" + second + "</span></div>");
```

## 日付に関するライブラリを導入する

日付を扱うのは、思ったより手間がかかりますね。  
こういうときは、先人が作った「ライブラリ」を使って楽をしましょう。

dayjsというライブラリを使ってみます。

[ここ](https://github.com/iamkun/dayjs/blob/master/docs/ja/Installation.md)にインストール方法が書いています。  
真ん中にある「CDNを使う場合:」の方法で使用してみましょう。

これはWeb上でURLに指定されたファイルを探してきて、使えるようにするやり方です。

```html
<script src="./jquery.min.js"></script>

//この一行を追加
<script src="https://unpkg.com/dayjs"></script>
```

これで使えるようになります。

実際に使ってみましょう。  
データを変換して、表示している部分を書き換えます。

```js
//firestoreからデータを読み込みます
db.collection("messages").orderBy('postdate', 'desc').get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //firestore内に保存されたTimestampから、Dayjsのための日時情報オブジェクトを取得する
        var postdate = dayjs(doc.data().postdate.toDate());

        //表示（formatを使うと表示形式が簡単に指定できます）
        $('#box').append("<div class='message'>" + message + "<span class='postdate'>" + postdate.format('YYYY/MM/DD HH:mm:ss') + "</span></div>");
    });
});
```

7行目以下が書き換わっています。  
```dayjs()```という部分が、dayjs用の日付情報オブジェクトを作っているところです。  
引数には、日付を表す文字列や、javascriptのDate型や、Timestampを入れることができます。  

出力するときは、formatというメソッドを使います。引数に文字列で「こんな形で出力したい」と指定します。  
この指定の仕方は、だいたいどの言語でも同じですので、覚えておくといいですね。  
「日付 フォーマット」などでググると情報が得られます。

dayjsには、他にも日付や時間のためのいろんな機能が用意されています。  
ドキュメントを一通り眺めてみるのも面白いですよ。  
また、dayjsはMoment.jsという有名なライブラリと完全に互換があります。Moment.jsの軽量版と考えてもいいですね。  
ですから、dayjsの使い方がわからないときは、Moment.jsで調べてもOKです。

---

これで、メッセージアプリの最低限の機能が実装できました。  
```firebase deploy```を実行して、インターネットに公開しましょう。

次は[step7](./step7.html)に進みます

