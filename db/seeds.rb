# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tester = User.create(id: 1, email: "heyzec-cvwo-tester@example.com", password_digest: "$2a$12$1wo7nIfm5Lz1Am7BCDAKUeQoSekxb5ZzWV61n/L4LkrtXSySRW0uy")

tester.tags.create(id: 1, text: "Zoom", color: "#8ae234")
tester.tags.create(id: 2, text: "NUS", color: "#f2777a")
tester.tags.create(id: 3, text: "Family", color: "#ad7fa8")

dental_list = tester.lists.create(id: 1, text: "Dental")

dental_list.tasks.create(id: 1, text: "Get referral from polyclinic", day: "2021-12-06T16:12:00.000Z")
dental_list.tasks.create(id: 2, text: "Visit specialist", day: "2021-12-06T16:12:00.000Z")

project_list = tester.lists.create(id: 2, text: "Coding Project")
project_list.tasks.create(id: 3, text: "First team meeting", day: "2021-12-06T16:12:00.000Z")
project_list.tasks.create(id: 4, text: "Execution plan submission", day: "2021-12-06T16:12:00.000Z")
project_list.tasks.create(id: 5, text: "Second team meeting", day: "2021-12-06T16:12:00.000Z")
project_list.tasks.create(id: 6, text: "Final submission", day: "2021-12-06T16:12:00.000Z")


tester2 = User.create(id: 2, email: "heyzec-cvwo-tester2", password_digest: "$2a$12$1wo7nIfm5Lz1Am7BCDAKUeQoSekxb5ZzWV61n/L4LkrtXSySRW0uy")
cooking_list = tester2.lists.create(id: 3, text: "Cooking and Baking")

cooking_list.tasks.create(id: 7, text: "Get flour, eggs, sugar", day: "2021-12-06T16:12:00.000Z")
cooking_list.tasks.create(id: 8, text: "Buy new whisking machine", day: "2021-12-06T16:12:00.000Z")
cooking_list.tasks.create(id: 9, text: "Bake cake", day: "2021-12-06T16:12:00.000Z")
cooking_list.tasks.create(id: 10, text: "Cook ramen", day: "2021-12-06T16:12:00.000Z")

