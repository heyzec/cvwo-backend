# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(id: 1, email: "heyzec-cvwo-tester@example.com", password_digest: "$2a$12$1wo7nIfm5Lz1Am7BCDAKUeQoSekxb5ZzWV61n/L4LkrtXSySRW0uy")

Task.create(id: 1, user_id: 1, text: "Doctors Appointments", day: "2021-12-06T16:12:00.000Z")
Task.create(id: 2, user_id: 1, text: "Meeting at School", day: "2021-12-29T05:30:00.000Z", tags: [2])
Task.create(id: 3, user_id: 1, text: "Coding homework", day: "2021-12-07T21:25:00.000Z", tags: [1,2])
Task.create(id: 4, user_id: 1, text: "Reading Assessment", day: "2021-12-29T09:12:00.000Z", tags: [1,2])
Task.create(id: 5, user_id: 1, text: "Dinner with Family", day: "2021-12-22T10:00:00.000Z", tags: [3])

Tag.create(id: 1, user_id: 1, text: "CS1101S", color: "#8ae234")
Tag.create(id: 2, user_id: 1, text: "NUS", color: "#f2777a")
Tag.create(id: 3, user_id: 1, text: "Family", color: "#ad7fa8")
