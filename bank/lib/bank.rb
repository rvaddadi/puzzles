require 'virtus'
require 'set'

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

  # Public: A Client in the line of the Bank.
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

    # Public: The Integer representing the amount of minutes a teller
    # has been serving the Client.
    attribute :serving_duration, Integer, default: 0

    # Public: Tells if the Client is served.
    #
    # Returns the Boolean indicating if the Client is served.
    def served?
      serving_duration == service_duration
    end
  end

  # Public: Returns the Integer number of tellers.
  attr_reader :tellers

  # Public: Returns the Symbol indicating the current state of the Bank,
  # either :open or :closed
  attr_reader :state

  # Public: Returns the Array of Clients in the Bank.
  attr_reader :clients

  # Public: Initialize a Bank.
  def initialize
    @state   = :closed
    @tellers = 0
    @clients = Array.new
  end

  # Public: Open the Bank for the day.
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
    clients.clear
    self
  end

  # Public: Tell if the Bank is open.
  #
  # Returns the Boolean indicating if the Bank is open.
  def open?
    state == :open
  end

  # Public: Close the bank.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already closed.
  def close
    unless open?
      raise InvalidStateError.new 'You tried to close an already closed Bank'
    end

    @state = :closed
    calculate_wating_times unless clients.empty?
    self
  end

  # Public: Add Clients to line in Bank.
  #
  # clients - The Client or Array of Clients to be added.
  #
  # Returns the Bank itself, useful for chaining.
  # Raises Bank::InvalidStateError if the Bank is already closed.
  def add_to_line clients
    unless open?
      raise InvalidStateError.new 'You tried to add clients to an closed Bank'
    end

    self.clients.push(*clients)
    self
  end

  # Public: Count how many Clients waited more then a given time.
  #
  # time - The Integer threshold.
  #
  # Returns the Integer quantity of Clients that waited more then the given
  #   time.
  # Raises Bank::InvalidStateError if the Bank is open.
  def clients_that_waited_more_than time
    if open?
      raise InvalidStateError.new 'You tried to count clients in an open Bank'
    end

    clients.count { |client| client.waiting_duration > time }
  end

  private

  # Internal: Calculate how long Clients wait in line. The information is
  # stored in Clients themselves.
  #
  # Returns nothing.
  def calculate_wating_times
    time              = 0
    available_tellers = tellers
    clients_serving   = Set.new

    clients_in_line = -> {
      clients.reject { |client|
        client.served? ||
          client.arrival > time ||
          clients_serving.include?(client)
      }
    }

    next_client = -> { clients_in_line[].shift }

    takes_one_minute = -> {
      clients_in_line[].each { |client| client.waiting_duration += 1 }
      time += 1
    }

    serve_clients = -> {
      takes_one_minute[]
      clients_serving.each { |client| client.serving_duration += 1 }
    }

    say_goodbye_to_served_clients = -> {
      clients_serving.select(&:served?).each do |client|
        clients_serving.delete client
        available_tellers += 1
      end
    }

    call_clients_from_line = -> {
      while available_tellers > 0 && ! (client = next_client[]).nil?
        clients_serving << client
        available_tellers -= 1
      end
    }

    until clients.all?(&:served?)
      call_clients_from_line []
      serve_clients[]
      say_goodbye_to_served_clients[]
    end
  end
end
