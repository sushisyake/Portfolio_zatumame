# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のアカウント
Admin.create!( email: "ad@ad", password: "qazpl,")

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