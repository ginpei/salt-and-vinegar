# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p = Paper.find_by_token('example')
p.destroy if p
p = Paper.create({ title: 'Example' })
p.update(token: 'example')
p.items.create({ name: 'salt', quantity: '1kg', orderer: 'Alice' })
p.items.create({ name: 'vinegar' })
