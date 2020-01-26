require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')


customer1 = Customer.new({'name' => 'Jan', 'funds' => 10.50})
customer1.save()

customer2 = Customer.new({'name' => 'John', 'funds' => 15.50})
customer2.save()

customer3 = Customer.new({'name' => 'Kate', 'funds' => 50})
customer3.save()

customer1.funds = 5
customer1.update()

customer1.delete()

film1 = Film.new({'title' => 'Paranormal Activity 1', 'price' => 2})
film1.save()

film2 = Film.new({'title' => 'Paranormal Activity 2', 'price' => 3.50})
film2.save()

film1.price = 1.50
film1.update()


ticket1 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()



binding.pry
nil
