# firestoreにデータを追加する

step3では、firestoreの操作画面でコレクションやドキュメントを追加しましたが、もちろん、コードで追加することもできます。  
今回は、messagesコレクションに新しいドキュメントを追加してみましょう。

## 投稿を追加する

index.htmlに以下の変更を加えてください。

before
```js
function add_message() {
    //入力欄からmessage内容を取得する
    var message = $('#message').val();

    if(message !== "") {
        //配列の先頭にmessageを追加する
        messages.unshift(message);
        
        //再表示する
        display_messages();
        //入力ボックスを空にする
        $('#message').val("");
    }
}
```

after
```js
function add_message() {
    //入力欄からmessage内容を取得する
    var message = $('#message').val();
    
    if(message !== "") {
        //documentにセットするオブジェクトを作る
        var docmuent = {
            message: message
        };

        // firestoreのmessagesコレクションに新しくdocumentを追加する
        db.collection('messages').add(docmuent).then(() => {
            //再表示する
            display_messages();
            //入力ボックスを空にする
            $('#message').val("");
        });
    }
}
```

少し作業が増えましたが、流れは変わっていません。

```firebase serve```で実行してみてください。

メッセージ入力欄に、なにか入力して投稿ボタンを押すと、投稿の追加がきちんと行われていますね。  
試しにfirestoreの操作画面で、messagesコレクションがどう変化したか確認してみてください。  
ドキュメントが増えていますね。

ここまでできれば、firestoreの基本中の基本はOKです。

# アロー関数
thenなどのメソッドでは、引数の中に関数を書きますが、インターネットで調べていると、見慣れない書き方を見ると思います。

```js
db.collection('messages').add(docmuent).then(function () {
    display_messages();
    $('#message').val("");
});
```

この部分が

```js
db.collection('messages').add(docmuent).then(() => {
    display_messages();
    $('#message').val("");
});
```

こんな感じで、```=>```を使って書かれているのをよく見かけます。  
これは、「アロー関数」という書き方で、javascriptの比較的新しい書き方です。  
短く省略して書けることと、thisの扱いが異なることが特徴ですが、現段階では、thisについては触れないでおきましょう。

書き換えかたは、簡単です。  
```function```を消し、```()```の後ろに```=>```を追加します。

関数に引数があるときも同じです。

before
```js
db.collection("messages").get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
        var message = doc.data().message;
        $('#box').append("<div class='message'>" + message + "</div>");
    });        
});
```

after
```js
db.collection("messages").get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        var message = doc.data().message;
        $('#box').append("<div class='message'>" + message + "</div>");
    });        
});
```

引数がひとつのときは、カッコも省略できます。  
（個人的には、この省略はやらなくてもいいかと思います）

after

```js
db.collection("messages").get().then(querySnapshot => {
    querySnapshot.forEach(doc => {
        var message = doc.data().message;
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

だんだんカッコいいコードになってきましたね。

---

次は[step5](./step5.html)に進みます
