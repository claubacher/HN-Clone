10.times do 
  user = User.new(:name => Faker::Internet.user_name,
              :password => "pass")
  5.times do 
    user.posts << Post.create(:title => Faker::Lorem.words(rand(5..8)).join(" ").capitalize,
                              :content => Faker::Lorem.paragraph)
  end
  user.save
end

User.all.each do |user|
  5.times do
    comment = Comment.new(:content => Faker::Lorem.paragraphs.join(" "))
    user.comments << comment
    Post.find(rand(1..Post.count)).comments << comment
    comment.save
  end
end