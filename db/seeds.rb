
# 5.times do |i|
#     User.create(
#         name: Faker::Lorem.sentence(word_count: 2), 
#         email: Faker::Internet.email,
#         role: 'qa',
#         password: Faker::Internet.password(min_length: 8, max_length: 16)
#     ) 
# end

# 3.times do |i|
#     Project.create(
#         name: Faker::Lorem.sentence(word_count: 10), 
#         description: Faker::Lorem.paragraph(sentence_count: 70),
#         manager_id: i
#     ) 
# end  

# Tasks
5.times do |i|
    Task.create(
        title: Faker::Lorem.sentence(word_count: 10), 
        description: Faker::Lorem.paragraph(sentence_count: 70),
        timeline: "October",
        user_id: 1,
        project_id: 5
    ) 
end  
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?