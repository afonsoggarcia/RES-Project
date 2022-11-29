# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Cleaning DB'
users = User.where(admin: false)
users.destroy_all
puts "Users not admin deleted"
Article.destroy_all
Topic.destroy_all
Category.destroy_all
puts "DB cleaned, starting new seed ..."
neil = User.create(first_name: 'Neil', last_name: 'Degrasse', nickname: 'Mr. Degrasse', email: 'degrasse@science.com',
                   password: '123123', believer: true, publisher: true,
                   description: 'Born October 5, 1958 I am an American astrophysicist, author, and science communicator.
                                 I studied at Harvard University, the University of Texas at Austin, and Columbia
                                 University.')
bibi = User.create(first_name: 'Gabriela', last_name: 'Balais', nickname: 'Bibi Balais', email: 'bibi@science.com',
                   password: '123123', believer: true, publisher: true,
                   description: 'Divulgadora científica, Fisica de particulas e amante de pokemon. Cientista brasileira
                                graduada em física e PhD em física teórica de partículas. Atualmente, reside e trabalha
                                no Japão junto a Universidade de Tsukuba. Além do seu trabalho como pesquisadora, onde
                                publicou diversos artigos científicos na área de Física, realiza divulgação científica
                                no YouTube através do canal Física e Afins. ')
puts '2 Publishers created ...'
Category.create(name: 'Round-earth')
Category.create(name: 'Global warming')
Category.create(name: 'Evolution')
Category.create(name: 'Conspiracy theory')
Category.create(name: 'Alternative Medical treatment')
puts '5 categories created'
# categories = ['Round-earth', 'Global warming', 'Evolution', 'Conspiracy theory', 'Alternative Medical treatment']
15.times do |i|
  article_neil = Article.new(
    title: Faker::Book.title,
    subtitle: Faker::Quote.matz,
    content: Faker::Lorem.paragraph(sentence_count: 80),
    accepted: true,
    category_id: rand(1..5),
    source_url: 'https://pt.wikipedia.org/wiki/Neil_deGrasse_Tyson',
    sources: Faker::Science.scientist
  )
  article_neil.user = neil
  article_neil.save
  Topic.create(
    title: Faker::Science.element_subcategory,
    description: Faker::Lorem.sentence(word_count: 125),
    user_id: neil.id
  )
  puts "#{i + 1} articles and topics created"
  article_bibi = Article.new(
    title: Faker::Book.title,
    subtitle: Faker::Quote.matz,
    content: Faker::Lorem.paragraph(sentence_count: 80),
    accepted: true,
    category_id: rand(1..5),
    source_url: 'https://pt.wikipedia.org/wiki/Bibi_Bailas',
    sources: Faker::Science.scientist
  )
  Topic.create(
    title: Faker::Science.element_subcategory,
    description: Faker::Lorem.sentence(word_count: 125),
    user_id: bibi.id
  )
  article_bibi.user = bibi
  article_bibi.save
  puts "#{i + 2} articles and topics created"
end
