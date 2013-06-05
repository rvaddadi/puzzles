require 'virtus'
require 'set'

# Public: Handle Clients in a Bank.
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

  # Public: A Client of the Bank.
  class Client
    include Virtus

    # Public: The Integer minute the Client arrived at the Bank.
    attribute :arrival, Integer

    # Public: The Integer amount of minutes it takes to serve the Client.
    attribute :service_duration, Integer

    # Public: The Integer amount of minutes the Client had to wait in line
    # (default: 0).
    attribute :waiting_duration, Integer, default: 0

    # Public: The Integer amount of minutes a teller has been serving the
    # Client (default: 0).
    attribute :serving_duration, Integer, default: 0

    # Public: The Symbol state in which the Client is.
    # Allowed states are :before_line, :in_line, :being_served and :served
    # (default: :before_line).
    attribute :state, Symbol, default: :before_line

    # Public: Helper method to access state of Client.
    #
    # Returns the Boolean of whether the Client is before the line.
    def before_line?
      state == :before_line
    end

    # Public: Helper method to access state of Client.
    #
    # Returns the Boolean of whether the Client is in line.
    def in_line?
      state == :in_line
    end

    # Public: Helper method to access state of Client.
    #
    # Returns the Boolean of whether the Client is being served.
    def being_served?
      state == :being_served
    end

    # Public: Helper method to access state of Client.
    #
    # Returns the Boolean of whether the Client is already served.
    def served?
      state == :served
    end

    # Public: Helper method to access state of Client.
    #
    # Returns the Boolean of whether the Client just finished being served.
    def finished_serving?
      being_served? && service_duration == serving_duration
    end
  end

  # Public: Returns the Integer number of tellers.
  attr_reader :tellers

  # Public: Returns the Symbol current state of the Bank. Allowed states are
  # :open and :closed.
  attr_reader :state

  # Public: Returns the Array of Clients of the Bank.
  attr_reader :clients

  # Public: Initialize a Bank.
  def initialize
    @state   = :closed
    @tellers = 0
    @clients = Array.new
  end

  # Public: Open the Bank for the day.
  #
  # tellers - The Integer number of tellers in the Bank for the day.
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

  # Public: Close the Bank.
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
      raise InvalidStateError.new 'You tried to add Clients to an closed Bank'
    end

    self.clients.push(*clients)
    self
  end

  # Public: Count how many Clients waited more then a given time.
  #
  # time - The Integer time threshold.
  #
  # Returns the Integer quantity of Clients that waited more then the given
  #   time.
  # Raises Bank::InvalidStateError if the Bank is open.
  def clients_that_waited_more_than time
    if open?
      raise InvalidStateError.new 'You tried to count Clients in an open Bank'
    end

    clients.count { |client| client.waiting_duration > time }
  end

  protected

  # Internal: Gets/Sets the Integer representing the clock on the wall.
  attr_accessor :time

  # Internal: Gets/Sets the Integer representing the quantity of available
  # tellers.
  attr_accessor :available_tellers

  # Internal: Calculate how long Clients wait in line. The information is
  # stored in Clients themselves.
  #
  # Returns nothing.
  def calculate_wating_times
    self.time              = 0
    self.available_tellers = tellers

    serve_clients and wait_for_time_to_pass until clients.all?(&:served?)
  end

  # Internal: Serve the Clients in the Bank.
  #
  # Returns nothing.
  def serve_clients
    clients_arrive
    say_hello_to_clients
    perform_tasks_asked_by_clients
    while_other_clients_wait_in_line
    say_goodbye_to_clients
  end

  # Internal: Step of serving Clients when they arrive at the Bank.
  #
  # Returns nothing.
  def clients_arrive
    clients.select(&:before_line?).each do |client|
      client.state = :in_line if client.arrival == time
    end
  end

  # Internal: Step of serving Clients when they end waiting in line and
  # start getting served.
  #
  # Returns nothing.
  def say_hello_to_clients
    while available_tellers > 0 && (next_client = clients.find(&:in_line?))
      allocate_teller
      next_client.state = :being_served
    end
  end

  # Internal: Step of serving Clients when they are in line waiting for a
  # teller to be available.
  #
  # Returns nothing.
  def while_other_clients_wait_in_line
    clients.select(&:in_line?).each do |client|
      client.waiting_duration += 1
    end
  end

  # Internal: Step of serving Clients when they are being served by teller.
  #
  # Returns nothing.
  def perform_tasks_asked_by_clients
    clients.select(&:being_served?).each do |client|
      client.serving_duration += 1
    end
  end

  # Internal: Step of serving Clients when they are done being served by
  # teller.
  #
  # Returns nothing.
  def say_goodbye_to_clients
    clients.select(&:finished_serving?).each do |client|
      free_teller
      client.state = :served
    end
  end

  # Internal: Increase the time passing while serving Clients in Bank.
  #
  # Returns nothing.
  def wait_for_time_to_pass
    self.time += 1
  end

  # Internal: Allocate a teller when it starts serving Client.
  #
  # Returns nothing.
  def allocate_teller
    self.available_tellers -= 1
  end

  # Internal: Free a teller when it finishes serving Client.
  #
  # Returns nothing.
  def free_teller
    self.available_tellers += 1
  end
end
