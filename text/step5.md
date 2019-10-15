# メッセージに投稿日時のデータを加える

アプリを動かしてみると、投稿の表示順がバラバラです。  
投稿時に投稿日時情報を保存し、その情報を使って、順番に表示するように変えてみましょう。

では早速コーディングに移ります。

```add_message```の中のdocumentオブジェクトを作っているところに、投稿日時情報を追加します。

before
```js
var docmuent = {
    message: message
};
```

after
```js
var docmuent = {
    message: message, //フィールドの区切り（カンマ）を追加
    //投稿日時のフィールドを追加（firestoreサーバの時間）
    postdate: firebase.firestore.FieldValue.serverTimestamp()
};
```

postdateというフィールド名で、投稿日時を保存します。  
投稿日時は、クライアント（投稿者側）の日付情報を取ってもいいですが、firestoreのサーバ側の時間を取得すると、より正確になります。  
（時差は表示時にきちんと変換されるので、サーバが世界のどこにあろうと問題ありません）

```firebase serve```でローカル環境を起動して、ローカルサーバにアクセスしましょう。

なにかメッセージを投稿してから、firestore操作画面で、追加されたドキュメントを見てください。  
postdateというフィールドが増えていますね。時差もしっかり考慮されています。  
並び替えを検証するため、いくつかメッセージを投稿してみてください。  

# メッセージを投稿日時順に取得する

今度は、メッセージの取得です。  
firestoreでは、orderByというメソッドで、並び替えをすることができます。  

firestoreからデータを読み込んでいるのは以下の部分ですね。

before
```js
//firestoreからデータを読み込みます
db.collection("messages").get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

これを以下のように書き換えます。

```js
//firestoreからデータを読み込みます（orderByを追加）
db.collection("messages").orderBy('postdate').get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

きちんと投稿順に並んでいます。  
ただ、step4までで投稿したメッセージが表示されていないのに気づきますね。  
この理由は[公式ドキュメント](https://firebase.google.com/docs/firestore/query-data/order-limit-data?authuser=0)に書かれています。

> 注: orderBy() 句は、指定したフィールドの有無によるフィルタも行います。指定したフィールドがないドキュメントは結果セットには含まれません。

気になる場合は、firestore操作画面で、表示されていないドキュメント（postdateフィールドのないドキュメント）を削除してください。

新しいものが下に来ていますが、新しいものを上にしたいときは、orderBy()の第2引数に```'desc'```を指定します。

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

---

次は[step6](./step6.html)に進みます
