# firestoreを使う

## firestoreとは
firestoreは、データベースです。
（以下説明）

## firestoreを使うための準備

### firebase コンソールでの作業
まずは、firestoreをプロジェクトに追加します。


### firebaseを使うためのコーディング
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
```

たったこれだけで、firestoreへ接続することができます。

## firestoreにデータを追加する
まずは、firestoreのコンソールで、お手軽にデータを追加してみましょう。

firestoreの内部では、オブジェクトの形式でデータが保存されていきます。
（オブジェクトについてわからない人は、javascriptの教科書、6章を参照してください）  

ドキュメントというのが、データ（オブジェクト）ひとつ分で、コレクションは、ドキュメントが集まったものと考えるといいです。  
また、ひとつのドキュメントには、複数のフィールドを作ることができます。
どんなフィールドを持つかという構造は、ドキュメントごとにできるだけ同じになるようにします。

例えば、今回のチャットアプリであれば、ドキュメントはひとつひとつの書き込みメッセージ、コレクションはその集まりとなります。
ドキュメントのフィールドは、今はメッセージのみですが、ここには例えば投稿者や、投稿日時などの情報も追加されるでしょう。

実際にmessagesというコレクションと、その下にドキュメントを3つ作ってみましょう。
（[動画]()）

## firestoreからデータを取り出す
次は、firestoreからデータを取り出す方法です。  
これは、index.htmlにコードを書き足すことでできます。

``display_messages``関数を以下のように書き換えましょう。

書き換え前
```js
function display_messages() {
    messages.push('こんにちは！');
    messages.push('やあ');
    messages.push('今日はいい天気ですね');
    
    $('#box').html("");
    for(var i = 0; i < messages.length; i++) {
        $('#box').append("<div class='message'>" + messages[i] + "</div>");
    }
}
```

書き換え後
```js
function display_messages() {
    db.collection("messages").get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            messages.push(doc.data().message);
        });
        
        $('#box').html("");
        for(var i = 0; i < messages.length; i++) {
            $('#box').append("<div class='message'>" + messages[i] + "</div>");
        }
    });
}
```

dbはfirestoreそのもののことです。ここから、messagesというコレクションを取り出すのが、
```collection('messages').get()```です。
この作業は少し時間がかかるので、.then()という特殊な書き方で続きを書きます。
「コレクションの取得が終わってからthen()の中に書いたことをしてね」という意味です。
（詳しいことを知りたい人は、「javascript Promise」というキーワードでググってみてください）

thenの引数には、関数が入ります。
この書き方は、今後よく出てくるので、覚えておいてください。
関数を引数の()の中に定義ごと書いてしまいます。
10行目の```)```がthenの```(```に対応する閉じカッコです。
関数とは処理のまとまりですから、要するに、thenの引数に書いた処理のまとまりを、```collection('messages').get()```の後で実行してねということです。

querySnapshot.forEach(function(doc){});
querySnapshotには、collectionの中身、つまり、複数個のドキュメントが配列のようなものに入っています。
（本当の配列ではないので、```querySnapshot[0]```と書いてもドキュメントは取り出せません。厳密なことは、追々学んでください）  
配列に入っているdocumentを一つづつ取り出して、docという変数で受け、{}の中でdocを処理します。  
これをdocumentの数だけ繰り返します（今回の例なら3回ですね）
（forEachについて、詳しいことは、「javascript forEach」でググってください。）

ドキュメントから各フィールドの内容を取り出すには、```ドキュメント.data().フィールド名```と書きます。
今回なら、messageフィールドを取り出したいので、```doc.data().message```です。
そして、この取り出した各messageを、配列messagesにpushで入れます。

あとは、messagesを表示する部分です。
これはstep2と変わりません。
気をつけてほしいのは、この作業もfirestoreからデータが読み終わってから行わないと意味がないので、thenの中に入っているということです。

```firebase serve```で実行してみましょう。  
（今後は、firebaseと連携しないといけないので、```index.html```ファイルを単にブラウザで表示してもエラーになります。serveで実行します）

firestoreの操作画面で、データを書き換えたり、追加したりすると、すぐに反映されます。（画面をリロードする必要があります）
色々試してみてくださいね。

---

次は[step4](./step4.md)に進みます

