# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SEEDING...'

###### ========================================================================

users = User.create([
    {email: 'user@framgia.com', password: '12345678'}
  ])

users.each { |user| user.save! }

puts "#{User.count} users created"

user_ids = User.all.pluck(:id)

###### ========================================================================

admins = Admin.create([
    {email: 'admin@framgia.com', password: '12345678'}
  ])

admins.each { |admin| admin.save! }

puts "#{Admin.count} admins created"

###### ========================================================================

categories = Category.create([
    {name: 'Basic 500', cover_photo: '1.jpg'},
    {name: 'Essential 1000', cover_photo: '2.jpg'},
    {name: 'Usual 3000', cover_photo: '3.jpg'}
  ])

categories.each { |category| category.save! }

puts "#{Category.count} categories created"

category_ids = Category.all.pluck(:id)

###### ========================================================================

100.times do
  word = Word.create({
      category_id:        category_ids.sample,
      text:               Faker::Lorem.word,
      meaning:            Faker::Lorem.word,
      pronunciation_file: nil
    })
  word.save!

  correct_choice = rand(0..3)

  4.times do |i|
    choice = QuestionChoice.create({
        word_id:  word.id,
        text:     correct_choice == i ? word.meaning : Faker::Lorem.word,
        correct:  correct_choice == i
      })
    choice.save!
  end
end

puts "#{Word.count} words created together with question choices"

###### ========================================================================

3.times do
  lesson = Lesson.create({
      category_id:  category_ids.sample,
      user_id:      user_ids.sample
    })
  lesson.save!

  words = Word.where(category_id: lesson.category_id).sample(lesson.number_of_questions)

  words.each_with_index do |word, i|
    answer = UserAnswer.create({
        user_id:            lesson.user_id,
        word_id:            word.id,
        lesson_id:          lesson.id,
        order:              i + 1,
        question_choice_id: QuestionChoice.where(word_id: word.id).sample.id
      })
    answer.save!
  end
end

puts "#{Lesson.count} lessons created together with user answers"

###### ========================================================================

puts 'DONE'