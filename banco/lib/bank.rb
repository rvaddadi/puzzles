# Public: Handle clients in a Bank.
#
# Examples
#
#   clients = [
#     Bank::Client.new(arrival: 1,  service_duration: 5 ),
#     Bank::Client.new(arrival: 0,  service_duration: 10),
#     Bank::Client.new(arrival: 0,  service_duration: 10),
#     Bank::Client.new(arrival: 1,  service_duration: 10),
#     Bank::Client.new(arrival: 2,  service_duration: 10),
#     Bank::Client.new(arrival: 30, service_duration: 10),
#   ]
#
#   Bank.new
#       .open(1)
#       .add_clients_to_line(clients)
#       .close
#       .clients_that_waited_more_than(20)
#   # => 1
class Bank

  # Public: Error raised when trying to open an already opened Bank.
  class AlreadyOpen < StandardError
  end

  # Public: Returns the Integer number of tellers.
  attr_reader :tellers

  # Public: Returns the Symbol indicating the current state of the Bank,
  # either :open or :closed
  attr_reader :state

  # Public: Initialize a Bank.
  def initialize
    @state = :closed
  end

  # Public: Opens the bank for the day.
  #
  # tellers - The Integer representing the number of tellers in the
  #           Bank for the day.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::AlreadyOpen if the Bank is already open.
  def open tellers
    raise AlreadyOpen if open?
    @state = :open
    self
  end

  # Public: Tels if the bank is open.
  #
  # Returns the Boolean indicating if the Bank is open.
  def open?
    state == :open
  end
end
