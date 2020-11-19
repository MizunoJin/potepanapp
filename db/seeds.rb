# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             username: "inco-man",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  username = "inco-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

#50.times do
#  content = Faker::Lorem.sentence(word_count: 5)
#  users.each { |user| user.microposts.create!(content: content) }
#end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
6.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each do |user|
      micropost = user.microposts.build(content:content)
      micropost.image.attach(io: File.open('app/assets/images/1.jpg'), filename: '1.jpg' )
      micropost.save
    end
end
