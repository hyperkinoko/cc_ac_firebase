#firestoreにデータを追加する

step3では、firestoreの操作画面でコレクションやドキュメントを追加しましたが、もちろん、コードで追加することもできます。  
今回は、messagesコレクションに新しいドキュメントを追加してみましょう。

## 投稿を追加する

index.htmlに以下の変更を加えてください。

before
```js
    function add_message() {
        var message = $('#message').val();
        console.log(message);
        if(message !== "") {
            messages.unshift(message);
            console.log(messages);
            display_messages();
            $('#message').val("");
        }
    }
```

after
```js
    function add_message() {
        //入力欄からmessage内容を取得する
        var message = $('#message').val();
        
        //documentにセットするオブジェクトを作る
        if(message !== "") {
            var docmuent = {
                message: message
            };
            console.log(docmuent);
            
            // firestoreのmessagesコレクションに新しくdocumentを追加する→その後、メッセージを表示しなおす
            db.collection('messages').add(docmuent).then(function () {
                display_messages();
                $('#message').val("");
            });
        }
    }
```

少し作業が増えましたが、流れは変わっていません。

```firebase serve```で実行してみてください。

メッセージ入力欄に、なにか入力して投稿ボタンを押すと、（同じ投稿がダブって表示されてしまいますが）投稿の追加がきちんと行われていますね。  
試しにfirestoreの操作画面で、messagesコレクションがどう変化したか確認してみてください。  
ドキュメントが増えていますね。

ここまでできれば、firestoreの基本中の基本はOKです。

#messages配列を削除する
投稿ボタンを押すと、同じ投稿がダブる原因は、messagesという配列のグローバル変数に値をpushしている部分が原因です。

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

この4行目ですね。
display_messagesが呼び出されるたびに、firestoreから読み込んだデータがmessagesに「追加」されます。
どこかのタイミングで、messagesを空っぽにし直せば解決しますが、もっと良い解決策があります。
messagesを使わないことです。

```js
var messages = [];
```

思い切ってこの行を削除しましょう。  
IDEによっては、「定義されていない変数を使っているよ」というエラーが出ます。

では、messagesを使わないようにしましょう。  
firestoreからデータを読み込んで、（messagesに入れずに）そのままboxに表示すればいいのです。

before
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

after
```js
    function display_messages() {
        //先にboxを初期化（空に）しておきます
        $('#box').html("");
        
        //firestoreからデータを読み込みます
        db.collection("messages").get().then(function(querySnapshot) {
            querySnapshot.forEach(function(doc) {
                //読み込んだデータ（1件分）を一旦messageという変数に入れます。
                var message = doc.data().message;
                //messageを追加表示します
                $('#box').append("<div class='message'>" + message + "</div>");
            });
        });
    }
```

これで、firestoreから読み込んだデータを直接表示できるようになりました。

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
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

after
```js
db.collection("messages").get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
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
        //読み込んだデータ（1件分）を一旦messageという変数に入れます。
        var message = doc.data().message;
        //messageを追加表示します
        $('#box').append("<div class='message'>" + message + "</div>");
    });
});
```

だんだんカッコいいコードになってきましたね。

---

次は[step5](./step5.md)に進みます
