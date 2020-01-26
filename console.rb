require('pry')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all
Screening.delete_all

customer1 = Customer.new({'name' => "Jan", 'funds' => 10.50})
customer1.save()

customer2 = Customer.new({'name' => "John", 'funds' => 15.50})
customer2.save()

customer3 = Customer.new({'name' => "Kate", 'funds' => 50})
customer3.save()



film1 = Film.new({'title' => "Paranormal Activity 1", 'price' => 2})
film1.save()

film2 = Film.new({'title' => "Paranormal Activity 2", 'price' => 3.50})
film2.save()


screening1 = Screening.new({'show_time' => "18:00", 'film_id' => film1.id})
screening1.save()

screening2 = Screening.new({'show_time' => "19:00", 'film_id' => film1.id})
screening2.save()

screening3 = Screening.new({'show_time' => "22:00", 'film_id' => film2.id})
screening3.save()

screening4 = Screening.new({'show_time' => "23:00", 'film_id' => film2.id})
screening4.save()


ticket1 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id, 'screening_id' => screening2.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening2.id})
ticket4.save()




binding.pry
nil
