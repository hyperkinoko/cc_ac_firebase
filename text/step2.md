# jQueryでデータを表示する

このステップでは、jQueryの使い方を学習します。

## jQueryを読み込む
step1で作ったファイル```index.html```を書き換えて、jQueryを読み込みましょう。

まず、jQueryのファイルをダウンロードします。  
ダウンロードのしかたは、javascriptの教科書で習いましたね。  
わからない方は、チャットで質問するか、ググってみてください。  
ダウンロードしたjQueryのファイルをappフォルダの中に入れて、firebase/init.jsを読み込んだ後に、```<script>```で読み込みます。


```html
<!-- ・・・略・・・ -->

    <!-- Initialize Firebase -->
    <script src="/__/firebase/init.js"></script>
    
    <!-- jQueryファイルの読み込み-->
    <script src="./jquery.min.js"></script>
</body>
</html>
```

## メッセージを表示する
次は、メッセージを表示する部分を作っていきます。  
jQueryを読み込んだ後に、```<script>```タグを書き、その中にどんどんコードを書いていきます。

まずは、投稿メッセージを覚えておくための配列を作ります。

配列は

```js
    var messages = [];
```

で**グローバルに**宣言します。  
グローバル変数は、基本的に、スクリプトのはじめに定義します。

次に、メッセージを読み込んだり、表示したりする処理を```display_messages```という関数としてまとめます。  
関数の定義部分を書いてみましょう。  

display_messagesのはじめに、messagesに3つのメッセージデータを入れる部分を書きましょう。  
後のstepで、この部分はデータベースからデータを読み込む処理に変えます。    

メッセージデータの内容は何でもOKです。文字列で入れます。  
配列に要素を追加するには、```配列.push(入れたい要素)```と書きます。

```html
    <!-- ・・・略・・・ -->

    <!-- jQueryファイルの読み込み-->
    <script src="./jquery.min.js"></script>

    <script>
        var messages = [];

        function display_messages() {
            //配列messagesにデータを追加する
            messages.push('こんにちは！');
            messages.push('やあ');
            messages.push('今日はいい天気ですね');
        }
    </script>
</body>
</html>
```
jQueryオブジェクトを読み込んだ後 => ```$(fucntion() {★ここにコードを書く★});```
jQueryオブジェクト（DOM）を読み込んだ後に、display_messagesを実行します。

```js
function display_messages() {
    //配列messagesにデータを追加する
    messages.push('こんにちは！');
    messages.push('やあ');
    messages.push('今日はいい天気ですね');
}
    
$(function() {
    display_messages();
});
```

```display_messages```では、boxの中に、配列の中の各メッセージを追加表示します。  
各メッセージもdiv要素として表示します。classはmessageを付与しましょう。

ヒント：
1. 配列messagesに対して、for文を使います。
1. 要素を追加するには、```★親要素★.append("★追加したい要素★")```を使います。

実行結果は、

![step2-3](../screenshot/step2-3.png)

このように表示され、

この部分のコードは

```html
<body>
    <div id="box">
        <div class="message">こんにちは！</div>
        <div class="message">やあ</div>
        <div class="message">今日はいい天気ですね</div>
    </div>
    
    <!-- ・・・略・・・ -->    
```

このようになります。  
（このコードは、手書きで書くのではなく、このコードがjavascriptで生成されます）

```js
function display_messages() {
    //配列messagesにデータを追加する
    messages.push('こんにちは！');
    messages.push('やあ');
    messages.push('今日はいい天気ですね');

    //データを表示する
    for(var i = 0; i < messages.length; i++) {
        var message = messages[i];
        $('#box').append('<div class="message">' + message + '</div>');
    }
}
```

## 投稿入力ボックスと投稿ボタンを作る

index.htmlに以下のコードを追加して、入力ボックスと投稿ボタンを追加します。

```html
<!--以下の2行を追加-->
<input type="text" id="message" placeholder="メッセージを入力">
<button id="post">投稿</button>

<div id="box"></div>
```

メッセージを入力してボタンを押したら、そのメッセージが先頭に追加されるように書き換えてください。  
メッセージ入力ボックスは、メッセージがboxに反映された時点で空にします。

ヒント：

1. ボタンを押したら```add_message```を実行するように作ります。```add_message```では、まずは配列の先頭に入力されたメッセージを追加し、次に、メッセージを再表示します。```display_messages```関数をうまく使いましょう。
1. 配列の**先頭に**要素を追加する方法を調べてみましょう。
1. 入力ボックスに入力されたメッセージを取得する方法、また、入力ボックスに任意の文字を（javascriptで）表示する方法を調べましょう。
1. display_messagesを呼び出すたびに、一旦boxの中の表示をリセットしましょう。

答え：


---

次は[step3](./step3.md)に進みます

