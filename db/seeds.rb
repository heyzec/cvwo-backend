# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Using create! to raise exception in case of failure

tester = User.create!(email: "heyzec-cvwo-tester@example.com", password_digest: "$2a$12$1wo7nIfm5Lz1Am7BCDAKUeQoSekxb5ZzWV61n/L4LkrtXSySRW0uy")

tester.tags.create!(text: "Zoom", color: "#7cabc9")
tester.tags.create!(text: "Urgent", color: "#f5714d")
tester.tags.create!(text: "NUS", color: "#e8b689")
tester.tags.create!(text: "Family", color: "#f0d9b2")
tester.tags.create!(text: "Friends", color: "#fcca65")

dental_list = tester.lists.create!(text: "Dental")

dental_list.tasks.create!(text: "Get referral from polyclinic", day: "2022-01-03T01:30:00.461Z", done: true,  tags: ["Urgent"])
dental_list.tasks.create!(text: "Visit specialist", day: "2022-02-22T06:05:00.011Z")

project_list = tester.lists.create!(text: "Coding Project")
project_list.tasks.create!(text: "First team meeting", day: "2021-12-10T09:00:00.166Z", done: true, tags: ["NUS"])
project_list.tasks.create!(text: "Execution plan submission", day: "2021-12-30T04:00:00.684Z", done: true)
project_list.tasks.create!(text: "Second team meeting", day: "2022-01-19T02:00:00.817Z", tags: ["Zoom"])
project_list.tasks.create!(text: "Final submission", day: "2022-01-25T15:59:00.418Z", tags: ["Urgent"])

personal_list = tester.lists.create!(text: "Personal")
personal_list.tasks.create!(text: "Bake for mom's birthday", day: "2021-12-12T04:12:00.049Z", tags: ["Urgent", "Family"])
personal_list.tasks.create!(text: "Lunch with Esther at UTown", day: "2022-02-11T04:00:00.301Z", tags: ["Friends"])



tester2 = User.create!(email: "heyzec-cvwo-tester2@example.com", password_digest: "$2a$12$1wo7nIfm5Lz1Am7BCDAKUeQoSekxb5ZzWV61n/L4LkrtXSySRW0uy")

tester2.tags.create!(text: "Zoom", color: "#b7758c")
tester2.tags.create!(text: "Urgent", color: "#f0e6e7")
tester2.tags.create!(text: "NUS", color: "#ed9ec9")

cooking_list = tester2.lists.create!(text: "Cooking and Baking")

cooking_list.tasks.create!(text: "Buy new whisking machine", day: "2022-01-29T08:30:00.896Z", tags: ["Urgent"])
cooking_list.tasks.create!(text: "Get flour, eggs, sugar", day: "2022-01-27T11:00:00.223Z", done: true)

project_list.generate_share_hash
tester2.lists << project_list
