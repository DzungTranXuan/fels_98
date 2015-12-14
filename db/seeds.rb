# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SEEDING...'

###### ========================================================================

5.times do |i|
  user = User.create({email: "user#{i}@framgia.com", password: '12345678', is_admin: true})
end

puts "#{User.count} users created"

user_ids = User.all.pluck(:id)

###### ========================================================================

categories = Category.create([
  {name: 'Basic 500', cover_photo: nil},
  {name: 'Essential 1000', cover_photo: nil},
  {name: 'Usual 3000', cover_photo: nil}
])

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

  correct_choice = rand(0..3)

  4.times do |i|
    choice = QuestionChoice.create({
        word_id:  word.id,
        text:     correct_choice == i ? word.meaning : Faker::Lorem.word,
        correct:  correct_choice == i
      })
  end
end

puts "#{Word.count} words created together with question choices"

###### ========================================================================

3.times do
  lesson = Lesson.create({
      category_id:  category_ids.sample,
      user_id:      user_ids.sample
    })

  words = Word.where(category_id: lesson.category_id).sample(lesson.number_of_questions)

  words.each_with_index do |word, i|
    answer = UserAnswer.create({
        user_id:            lesson.user_id,
        word_id:            word.id,
        lesson_id:          lesson.id,
        order:              i + 1,
        correct:            [true, false].sample,
        question_choice_id: QuestionChoice.where(word_id: word.id).sample.id
      })
  end
end

puts "#{Lesson.count} lessons created together with user answers"

###### ========================================================================

10.times do
  activity = Activity.create({
      user_id:    user_ids.sample,
      type_name:  'learn',
      content:    'learnt 10 words in Basic 500'
    })
end

puts "#{Activity.count} activities created"

###### ========================================================================

puts 'DONE'