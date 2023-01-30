#管理者のアカウント
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
      name: '掃除'
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
      name: 'その他'
    }
  ]
)

Tag.create([
  { name: 'タグ1' },
  { name: 'タグ2' },
  { name: 'タグ3' },
  { name: 'タグ4' },
  { name: 'タグ5' }
])

5.times do |n|
  article = Article.new(question: "投稿#{n + 1}", answer: "解答#{n + 1}", user_id: n + 1, genre_id: n + 1)
  article.article_tag_relations.new(article_id: n + 1, tag_id: n + 1)
  article.save!
end
