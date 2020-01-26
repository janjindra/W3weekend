require('minitest/autorun')
require('minitest/reporters')
require_relative('../customer.rb')
require_relative('../film.rb')
require_relative('../ticket.rb')

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

class TestCustomer < MiniTest::Test


  def setup
    @customer1 = Customer.new({'name' => 'Jan', 'funds' => 10.50})
    @customer2 = Customer.new({'name' => 'John', 'funds' => 15.50})
    @customer3 = Customer.new({'name' => 'Kate', 'funds' => 50})

    @film1 = Film.new({'title' => 'Paranormal Activity 1', 'price' => 2})
    @film2 = Film.new({'title' => 'Paranormal Activity 2', 'price' => 3.50})

    @ticket1 = Ticket.new({'customer_id' => @customer3.id, 'film_id' => @film1.id})
    @ticket2 = Ticket.new({'customer_id' => @customer2.id, 'film_id' => @film2.id})
    @ticket3 = Ticket.new({'customer_id' => @customer2.id, 'film_id' => @film1.id})

  end

  #methods

  def test_decrease_customer_funds_by_film_price
    assert_equal(48,@customer3.decrease_customer_funds_by_film_price(@film1))
    assert_equal(12,@customer2.decrease_customer_funds_by_film_price(@film2))
  end

  def test_add_tickets_to_a_customer
    @customer1.add_tickets_to_a_customer(@ticket1)
    @customer1.add_tickets_to_a_customer(@ticket2)
    @customer1.add_tickets_to_a_customer(@ticket3)
    assert_equal(3,@customer1.tickets_list.count)
  end


end
