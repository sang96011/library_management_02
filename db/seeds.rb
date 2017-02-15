User.create! name: "Le Tat Tung", email: "letattungtb@gmail.com",
  password: "tung123", password_confirmation: "tung123", is_admin: true

20.times do
  name = Faker::Book.genre
  Category.create! name: name
end

20.times do
  name = Faker::Name.name
  date_of_birth = Faker::Date.between("1/1/1950", "31/12/1970")
  Author.create! name: name, date_of_birth: date_of_birth, body: "lorem is pull dea but"
end

20.times do
  name = Faker::Name.name
  Publisher.create! name: name
end

20.times do
  title = Faker::Book.genre
  description = Faker::Lorem.sentence(3, true, 4)
  pages = rand(500..1000)
  price = rand(10000..200000)
  quantity = rand(10..100)
  publisher_id = rand(1..20)
  publish_date = Faker::Date.between("1/1/1980", "31/12/2015")
  Book.create! title: title, pages: pages, price: price,
  quantity: quantity, publish_date: publish_date, publisher_id: publisher_id
end

20.times do
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  permission = "user"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, permission: permission
end

20.times do
  book_id = rand(1..10)
  category_id = rand(1..20)
  BookCategory.create! book_id: book_id, category_id: category_id
end

20.times do
  book_id = rand(1..20)
  author_id = rand(1..20)
  BookAuthor.create! book_id: book_id, author_id: author_id
end

20.times do
  book_id = rand(1..20)
  user_id = rand(1..20)
  body = Faker::Lorem.sentence(3, true, 4)
  Comment.create! book_id: book_id, user_id: user_id, body: body
end

20.times do
  book_id = rand(1..20)
  user_id = rand(1..20)
  point = rand(1..5)
  Rate.create! book_id: book_id, user_id: user_id, point: point
end
