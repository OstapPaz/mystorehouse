# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
text = 'Sed ut perspiciatis unde omnis iste natus'

products_list = [
    ['Baseball stick', 'Harvey 4A', 100, 1, text],
    ['Ballom', 'Colt 1', 300, 1, text],
    ['Footwear', 'HarvA', 12300, 1, text],
    ['Cubik-Rubik', 'Coup A', 1300, 1, text],
    ['T-Shirt', 'Carr', 500, 1, text],
    ['Uniform', 'Urgh', 14300, 1, text],
    ['Table', 'Vb', 10, 2, text],
    ['Uniform', 'SS', 6700, 2, text],
    ['Ball', 'UPD', 180, 2, text],
    ['Tank', 'Pantera', 3700, 2, text],
    ['Tank', 'Panzer', 540, 2, text],
    ['Tank', 'Tiger 3', 890, 2, text]
]

Category.create!(name: 'Defence')
Category.create!(name: 'Sport')
Category.create!(name: 'Home')

products_list.each do |name, model, price, category_id, text|
    Product.create!(name: name, model: model, price: price, category_id: category_id, adding_information: text)
end

User.create!(
    name: 'Bruce',
    email: "bruce@gnail.com",
    password: "qqqqqq",
    admin_permission: true
)

Discount.create!(name: 'same category', criterion: 3, criterion_second: 0.3)
Discount.create!(name: 'number of all products', criterion: 2, criterion_second: 0.2)
Discount.create!(name: 'price board', criterion: 300, criterion_second: 0.2)

