require 'virtus'

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

  # Public: Error raised when invalid operations are tried with the Bank.
  # For instance, trying to open an already opened Bank, of trying to close
  # an already closed Bank.
  class InvalidStateError < StandardError
  end

  # Public: Represents a Client in the line of the Bank.
  class Client
    include Virtus

    # Public: The Integer representing the minute the Client arrived
    # at the bank.
    attribute :arrival, Integer

    # Public: The Integer representing the amount of minutes it takes
    # to serve the Client.
    attribute :service_duration, Integer

    # Public: The Integer representing the amount of minutes the Client
    # had to wait in line.
    attribute :waiting_duration, Integer, default: 0
  end

  # Public: Returns the Integer number of tellers.
  attr_reader :tellers

  # Public: Returns the Symbol indicating the current state of the Bank,
  # either :open or :closed
  attr_reader :state

  # Public: Retuns the Array of Clients in the Bank.
  attr_reader :clients

  # Public: Initialize a Bank.
  def initialize
    @state   = :closed
    @tellers = 0
    @clients = Array.new
  end

  # Public: Opens the Bank for the day.
  #
  # tellers - The Integer representing the number of tellers in the
  #           Bank for the day.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already open.
  def open tellers
    if open?
      raise InvalidStateError.new 'You tried to open an already opened Bank'
    end

    @state   = :open
    @tellers = tellers
    @clients.clear
    self
  end

  # Public: Tells if the Bank is open.
  #
  # Returns the Boolean indicating if the Bank is open.
  def open?
    state == :open
  end

  # Public: Closes the bank.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already closed.
  def close
    unless open?
      raise InvalidStateError.new 'You tried to close an already closed Bank'
    end

    @state   = :closed
    self
  end

  # Public: Adds Clients to line in Bank.
  #
  # clients - The Array of Clients to be added to Bank.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already closed.
  def add_clients_to_line clients
    clients.each { |client| add_client_to_line client }
    self
  end

  # Public: Add a Client to line in Bank.
  #
  # client - The Client to be added to Bank.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already closed.
  def add_client_to_line client
    unless open?
      raise InvalidStateError.new 'You tried to add clients to an closed Bank'
    end

    @clients << client
    self
  end
end
