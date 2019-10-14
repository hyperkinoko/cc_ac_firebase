# firestoreを使う

## firestoreとは
firestoreは、データベースです。  

Webアプリケーションでは、いろんなデータを保存したり取り出したりしなければなりません。  
例えば、チャットアプリでは、少なくともチャット内容は必ず保存されているでしょう。  
他にも、投稿日時や、投稿者などの情報も保存されているかもしれませんね。

データベースは、そのような膨大なデータを、取り出しやすい形で保存しておく場所です。  
従来は「RDB」と呼ばれる形式のデータベースがよく使われていましたが、最近では、firestoreなどの、「RDBではない」データベースも増えてきました。  
理論や歴史などはさておき、まずは使ってみましょう。  
（気になる人は「nosql rdb 違い」などでググってみてください）

## firestoreを使うための準備

### firebase コンソールでの作業

まずは、firestoreをプロジェクトに追加します。   
そのまま続けて、firestoreのコンソールで、お手軽にデータを追加してみましょう。
（[動画](../movie/step3-firestore.mp4)）

firestoreの内部では、オブジェクトの形式でデータが保存されていきます。  
（オブジェクトについてわからない人は、javascriptの教科書、6章を参照してください）  

ドキュメントというのが、データ（オブジェクト）ひとつ分で、コレクションは、ドキュメントが集まったものと考えるといいです。  
また、ひとつのドキュメントには、複数のフィールド（オブジェクトのプロパティ）を作ることができます。  
どんなフィールドを持つかという構造は、ドキュメントごとにできるだけ同じになるようにします。

例えば、今回のチャットアプリであれば、ドキュメントはひとつひとつの書き込みメッセージ、コレクションはその集まりとなります。  
ドキュメントのフィールドは、今はメッセージのみですが、ここには例えば投稿者や、投稿日時などの情報も追加されるでしょう。

実際にmessagesというコレクションと、その下にドキュメントを3つ作ってみましょう。


### firestoreを使うためのライブラリを追加する

index.htmlの以下の位置に、次のように書き加えてください。

before
```
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
```

after
```html
<!-- TODO: Add SDKs for Firebase products that you want to use
     https://firebase.google.com/docs/web/setup#available-libraries -->
<script src="https://www.gstatic.com/firebasejs/6.3.4/firebase-firestore.js"></script>
```

これで、firestoreを使う準備ができました。

次に、firestoreとデータを行き来させるために、firestoreへ接続するオブジェクトを取得します。  
名前はdbとしておきましょう（データベースのことです）。  
この変数は、グローバル変数として使うので、```<script>```開始タグのすぐ後に宣言しましょう。

```js
var db = firebase.firestore();

var messages = [
    'こんにちは！',
    'やあ',
    '今日はいい天気ですね'
];
```

たったこれだけで、firestoreへ接続することができます。


## firestoreからデータを取り出す

次は、firestoreからデータを取り出す方法です。  
これは、index.htmlにコードを書き足すことでできます。

``display_messages``関数を以下のように書き換えましょう。

before
```js
function display_messages() {
    //先にboxを初期化（空に）しておきます
    $('#box').html("");

    //データを表示する
    messages.forEach(function (message) {
        $('#box').append('<div class="message">' + message + '</div>');
    });
}
```

after
```js
function display_messages() {
    //先にboxを初期化（空に）しておきます
    $('#box').html("");
    
    //firestoreからデータを読み込み、各データを表示する
    db.collection("messages").get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            var message = doc.data().message;
            $('#box').append("<div class='message'>" + message + "</div>");
        });        
    });
}
```

```db```はfirestoreそのもののことです。ここから、messagesというコレクションを取り出すのが、
```collection('messages').get()```です。  
この作業は少し時間がかかるので、```.then()```という特殊な書き方で続きを書きます。  
「コレクションの取得が終わってから```then()```の中に書いたことをしてね」という意味です。  
（詳しいことを知りたい人は、「javascript Promise」というキーワードでググってみてください）

thenの引数には、関数が入ります。  
step2の最後で学習した、無名関数ですね。
関数を引数の()の中に定義ごと書いてしまいます。  
10行目の```)```がthenの```(```に対応する閉じカッコです。  
要するに、thenの引数に書いた処理のまとまりを、```collection('messages').get()```が**終わった後で**実行してねということです。

```js
querySnapshot.forEach(function(doc){});
```

```querySnapshot```には、コレクションの中身、つまり、複数個のドキュメントが配列のようなものに入っています。  
（本当の配列ではないので、```querySnapshot[0]```と書いてもドキュメントは取り出せません。厳密なことは、追々学んでください）  
配列に入っているドキュメントを一つづつ取り出して、```doc```という変数で受け、```{}```の中で```doc```を処理します。  
これをドキュメントの数だけ繰り返します（今回の例なら3回ですね）  

ドキュメントから各フィールドの内容を取り出すには、```ドキュメント.data().フィールド名```と書きます。   
今回なら、messageフィールドを取り出したいので、```doc.data().message```です。  
あとは、messageを表示する部分です。これはstep2と変わりません。  

```js
db.collection("messages").get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
        var message = doc.data().message;
        $('#box').append("<div class='message'>" + message + "</div>");
    });        
});
```
ここまで書けたら、```firebase serve```で実行してみてください。

firestoreの操作画面で、データを書き換えたり、追加したりすると、すぐに反映されます。（画面をリロードする必要があります）  
色々試してみてくださいね。

---

次は[step4](./step4.md)に進みます

