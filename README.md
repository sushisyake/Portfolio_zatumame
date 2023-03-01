# Zatumame

## サイト概要
### サイトテーマ
ざつマメは、ユーザーが投稿できる雑学や豆知識を、みんなでクイズ形式で楽しむことができるコミュニティサイトです。
ユーザー主体のウェブサイトなので、管理者側は基本的にジャンルの追加や、サイトの信憑性を保つための管理業務を行います。
高評価機能と低評価機能があることで、情報の信憑性を可視化できます。
投稿のジャンルは管理者のみが追加できますが、「今すぐ試せる」「誰かに教えたい」などのタグは、ユーザーが自由に設定できます。
フォロー機能やいいね機能、コメント機能があることで、ユーザーは投稿を見ることも見られることも楽しむことができます。
アプリ名は雑学とマメ知識をもじったものです。

### テーマを選んだ理由
一番大きな理由は、よく見ているネットニュースや雑学系の動画と今までDMMWEBCAMPで習ったSNSの要素を組み合わせ、全く新しいものを作れるのではないかと思ったことです。
最初は豆知識をみんなで共有するだけのサイトを作ろうと思ったのですが、クイズ番組や、Youtubeのクイズチャンネルが人気を博していることからヒントを得て、クイズ要素を追加しました。
また、サイトを制作するにあたって、似たようなサイトを見つけらなかったことも、テーマを選んだ理由の一つです。
ユーザーに認知されるまでは大変ですが、一度軌道に乗れば、全く新しい需要を作り出されると思いました。

### 主な利用シーン
- 新しいライフハックを知りたい時
- 明日の話題作りたい時
- 日常の暇つぶし

## こだわって実装した機能
- 見たい投稿を絞り込むためのタグ検索とジャンル検索
- アクティブユーザーにも新規ユーザーにもわかりやすいランキング機能
- 中間テーブルを利用した、フォロー機能とタグ機能
- そのほか、部分テンプレートをなるべく活用してコードの量を削減し、インデントなどは書籍「リーダブルコード」を参考にしました。

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9