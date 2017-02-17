User.create! name: "Le Tat Tung", email: "letattungtb@gmail.com",
  password: "tung123", password_confirmation: "tung123", is_admin: true

publisher = Publisher.create! name: "Le Tat Tung"
publisher.books.create! title: "Harry potter", pages: 500, price: 20000,
  quantity:10, publish_date: "2001-02-17"
Category.create! name: "Literature book"
Category.create! name: "Detective book"
Category.create! name: "science book"
BookCategory.create! book_id: 1, category_id: 1
BookCategory.create! book_id: 1, category_id: 2
BookCategory.create! book_id: 1, category_id: 3

10.times do
  name = Faker::Name.name
  date_of_birth = Faker::Date.between("1/1/1950", "31/12/1970")
  Author.create! name: name, date_of_birth: date_of_birth, body: "lorem is pull dea but"
end

10.times do
  name = Faker::Name.name
  Publisher.create! name: name
end

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end
