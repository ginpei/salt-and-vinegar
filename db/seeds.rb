b = Book.find_by_token('example')
b.destroy if b
b = Book.create(name: 'Example')
b.update(token: 'example')
p = b.papers.create({ title: 'Example' })
p.items.create({ name: 'salt', quantity: '1kg', orderer: 'Alice' })
p.items.create({ name: 'vinegar' })
