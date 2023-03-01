# 管理者のアカウント
Admin.create!( email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

  5.times do |n|
    User.create!(
      email: "test#{n + 1}@a",
      nickname: "テスト#{n + 1}",
      password: 'qazpl,',
    )
  end

  Genre.create(
  [
    {
      name: '家事全般'
    },
    {
      name: '料理'
    },
    {
      name: 'スマホ'
    },
    {
      name: '雑学'
    },
    {
      name: '勉強'
    },
    {
      name: 'その他'
    }
  ]
)

Tag.create([
  { name: '今日から使える' },
  { name: '誰かに教えたい' },
  { name: 'いつかは役に立つ' },
  { name: 'インドア' },
  { name: 'アウトドア' }
])

  article = Article.new(question: "iPhoneのフリック入力時、空白を長押しすると", answer: "文字と文字の間に追記しやすくなる", user_id: 1, genre_id: 3)
  article.article_tag_relations.new(article_id: 1, tag_id: 1)
  article.save!

  article = Article.new(question: "勉強中に雑音が気になる時は", answer: "バックグラウンドサウンドを試してみる(iPhone)", user_id: 1, genre_id: 3)
  article.article_tag_relations.new(article_id: 2, tag_id: 1)
  article.save!

  article = Article.new(question: "信号機のピヨピヨとカッコーの違い", answer: "ピヨピヨが主に南東の横断歩道、カッコーが主に東西の横断歩道", user_id: 1, genre_id: 4)
  article.article_tag_relations.new(article_id: 3, tag_id: 2)
  article.save!

  article = Article.new(question: "板チョコの溝はチョコレートを固めやすくするため", user_id: 1, genre_id: 4)
  article.article_tag_relations.new(article_id: 4, tag_id: 2)
  article.save!

  article = Article.new(question: "「駅まで徒歩5分」競歩世界一位の選手だと", answer: "1分55秒(トリビアの泉)", user_id: 2, genre_id: 4)
  article.article_tag_relations.new(article_id: 5, tag_id: 2)
  article.save!

  article = Article.new(question: "Two Zero Two Four　の読み方", answer: "2024", user_id: 2, genre_id: 5)
  article.article_tag_relations.new(article_id: 6, tag_id: 3)
  article.save!

  article = Article.new(question: "洗濯機を使う時、重いものは上？下？", answer: "下。回転がよりスムーズになり、洗浄効率が向上します。", user_id: 2, genre_id: 1)
  article.article_tag_relations.new(article_id: 7, tag_id: 1, tag_id: 1)
  article.save!
