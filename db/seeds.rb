p = Paper.find_by_token('example')
p.destroy if p
p = Paper.create({ title: 'Example' })
p.update(token: 'example')
p.items.create({ name: 'salt', quantity: '1kg', orderer: 'Alice' })
p.items.create({ name: 'vinegar' })
