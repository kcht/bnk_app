# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.where(id: 1, name:'MOJE PODRÓŻE', description: 'Audycje z osobistymi relacjami z podróży').first_or_create
Tag.where(id: 2, name:'CIEKAWOSTKI', description: 'Powinieneś przesłuchać, jeśli niedługo wybierasz się na wakacje').first_or_create
Tag.where(id: 3, name:'ASTRONOMIA', description: 'Kosmiczna muzyka i podróże poza Ziemię').first_or_create
Tag.where(id: 4, name:'MUZYKA Z...', description: 'W tych odcinkach dominowała muzyka danego regionu...').first_or_create
Tag.where(id: 5, name:'MOTYW PRZEWODNI', description: 'Audycje z motywem przewodnim - luźno związanym z podróżami').first_or_create
Tag.where(id: 6, name:'OKOLICZNOŚCIOWE', description: 'Odcinki specjalne na święta, rocznice i inne okazje specjalne').first_or_create
Tag.where(id: 7, name:'CYKL', description: 'Te audycje były częścią kilkuodcinkowych cykli').first_or_create

User.create!(name:  "Example User",
             email: "example@user.org",
             password:              "foobar",
             password_confirmation: "foobar")

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@user.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end