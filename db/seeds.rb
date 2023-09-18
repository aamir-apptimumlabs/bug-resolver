
3.times do |i|
    Project.create(
        name: Faker::Lorem.sentence(word_count: 10), 
        description: Faker::Lorem.paragraph(sentence_count: 70),
        manager_id: i
    ) 
end  