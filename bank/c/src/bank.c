/*
 * bank.c
 *
 * Solution to the Bank problem.
 *
 * Refer to `README.md` for description of problem.
 *
 * The solution is all in a single file to work in OBI's auto corrector.
 *
 * The logic for the solution is naively simulating the Bank with the passing
 * of time. Clients are tracked while moved to line and served. Afterwords,
 * the amount of unsatisfied Clients is measured.
 *
 * This approach is simple to write and read, also it's not expensive
 * computation with the limits given in the problem.
 */

#include <stdio.h>
#include <stdlib.h>


/*
 * The maximum time a client should wait in line.
 */
#define MAXIMUM_WAITING_TIME 20

/*
 * Client being served by bank.
 */
typedef struct {
  /*
   * Time when the Client arrives at the bank.
   */
  int arrival;

  /*
   * How long it takes to serve a Client.
   */
  int total_serving_duration;

  /*
   * How long the Client has waited in line.
   */
  int waiting_duration;

  /*
   * How long the teller has been serving the Client.
   */
  int serving_duration;
} client_t;

/*
 * An array of Clients.
 */
typedef struct {
  /*
   * The Clients in the array.
   */
  client_t** clients;

  /*
   * The size of the array of Clients.
   */
  int size;
} clients_t;

/*
 * The Bank that serves the clients.
 */
typedef struct {
  /*
   * Quantity of tellers working in the Bank.
   */
  int tellers;

  /*
   * The amount of tellers busy serving clients.
   *
   * This number should never be greater than `tellers`.
   */
  int occupied_tellers;

  /*
   * Clients outside the Bank, before getting in line.
   */
  clients_t* outside;

  /*
   * Clients in line waiting to be served.
   */
  clients_t* line;

  /*
   * Clients being served.
   */
  clients_t* serving;

  /*
   * Clients that have finished being served.
   */
  clients_t* served;
} bank_t;

/*
 * Read Bank information from `stdin`.
 *
 * Returns the Bank with proper information.
 */
bank_t* read_bank_information();

/*
 * Serve Clients in Bank.
 *
 * bank - The Bank with clients to serve.
 */
void serve_clients(bank_t* bank);

/*
 * Count clients that waited in line more than a threshold.
 *
 * clients   - The line of Clients.
 * threshold - The maximum amount of time a Client should wait in line.
 *
 * Returns the amount of Clients that waited more than the `threshold`.
 */
int clients_exceeded_waiting(clients_t* clients, int threshold);

/*
 * Add Client to array.
 *
 * Addition is performed in the end. This way, if the array is traversed
 * is ascending order, it behaves as a queue.
 *
 * clients - The Clients array in which the Client is added.
 * client  - The Client to be added.
 */
void add_client(clients_t* clients, client_t* client);

/*
 * Remove Client from array.
 *
 * clients  - The Clients array from which the Client is removed.
 * position - The position of the Client being removed. The position is
 *            zero-indexed.
 */
void remove_client(clients_t* clients, int position);

/*
 * Check if all Clients were served.
 *
 * This means the Bank can close.
 *
 * bank - The bank in which the test should be performed.
 */
int all_clients_served(bank_t* bank);

/*
 * Initialize the Client struct.
 *
 * arrival                - The time when the Client arrives at the bank.
 * total_serving_duration - The time it takes to serve a Client.
 *
 * Retuns the initialized Client.
 */
client_t* init_client(int arrival, int total_serving_duration);

/*
 * Free the Client struct.
 *
 * client - The Client to be freed.
 */
void free_client(client_t* client);

/*
 * Initialize Clients array.
 *
 * maximum_size - The maximum amount of Clients in array.
 *
 * Retuns the initialized Clients array.
 */
clients_t* init_clients(int maximum_size);

/*
 * Free Clients array.
 *
 * clients - The Clients array to be freed.
 */
void free_clients(clients_t* clients);

/*
 * Initialize the Bank struct.
 *
 * tellers - The amount of tellers working in the Bank.
 * clients - The amount of Clients the Bank is going to serve.
 *
 * Returns the initialized Bank.
 */
bank_t* init_bank(int tellers, int clients);

/*
 * Free Bank.
 *
 * bank - The Bank to be freed.
 */
void free_bank(bank_t* bank);

int main(int argc, char const *argv[]) {
  int unhappy_customers;
  bank_t* bank;

  bank = read_bank_information();
  serve_clients(bank);
  unhappy_customers = clients_exceeded_waiting(bank->served,
                                               MAXIMUM_WAITING_TIME);
  printf("%d", unhappy_customers);
  free_bank(bank);

  return 0;
}

bank_t* read_bank_information() {
  int c, n, t, d, i;
  bank_t* bank;

  fscanf(stdin, "%d %d", &c, &n);
  bank = init_bank(c, n);

  for (i = 0; i < n; ++i) {
    fscanf(stdin, "%d %d", &t, &d);
    add_client(bank->outside, init_client(t, d));
  }

  return bank;
}

void serve_clients(bank_t* bank) {
  int time, i;
  client_t* client;

  time = 0;

  for (time = 0; ! all_clients_served(bank); ++time) {
    for (i = 0; i < bank->outside->size; ++i) {
      client = bank->outside->clients[i];
      if(client->arrival == time) {
        remove_client(bank->outside, i); --i;
        add_client(bank->line, client);
      }
    }

    for (i = 0; i < bank->line->size; ++i) {
      client = bank->line->clients[i];
      if (bank->occupied_tellers < bank->tellers) {
        remove_client(bank->line, i); --i;
        add_client(bank->serving, client);
        ++bank->occupied_tellers;
      }
      else {
        ++client->waiting_duration;
      }
    }

    for (i = 0; i < bank->serving->size; ++i) {
      client = bank->serving->clients[i];
      ++client->serving_duration;
      if (client->serving_duration == client->total_serving_duration) {
        remove_client(bank->serving, i); --i;
        add_client(bank->served, client);
        --bank->occupied_tellers;
      }
    }
  }
}

int clients_exceeded_waiting(clients_t* clients, int threshold) {
  int i;
  int count;

  count = 0;
  for (i = 0; i < clients->size; ++i) {
    if (clients->clients[i]->waiting_duration > threshold) {
      ++count;
    }
  }

  return count;
}

void add_client(clients_t* clients, client_t* client) {
  clients->clients[clients->size] = client;
  ++clients->size;
}

void remove_client(clients_t* clients, int position) {
  int i;

  --clients->size;
  for (i = position; i < clients->size; ++i) {
    clients->clients[i] = clients->clients[i + 1];
  }
}

int all_clients_served(bank_t* bank) {
  return bank->outside->size +
         bank->line->size +
         bank->serving->size == 0;
}

client_t* init_client(int arrival, int total_serving_duration) {
  client_t* client;

  client = (client_t*) malloc(sizeof(client));
  client->arrival = arrival;
  client->total_serving_duration = total_serving_duration;
  client->waiting_duration = 0;
  client->serving_duration = 0;

  return client;
}

void free_client(client_t* client) {
  free(client);
}

clients_t* init_clients(int maximum_size) {
  clients_t* clients;

  clients = (clients_t*) malloc(sizeof(clients_t));
  clients->clients = (client_t**) calloc(maximum_size, sizeof(client_t*));
  clients->size = 0;

  return clients;
}

void free_clients(clients_t* clients) {
  int i;

  for (i = 0; i < clients->size; ++i) {
    free_client(clients->clients[i]);
  }

  free(clients);
}

bank_t* init_bank(int tellers, int clients) {
  bank_t* bank;

  bank = (bank_t*) malloc(sizeof(bank_t));
  bank->tellers = tellers;
  bank->occupied_tellers = 0;
  bank->outside = init_clients(clients);
  bank->line = init_clients(clients);
  bank->serving = init_clients(clients);
  bank->served = init_clients(clients);

  return bank;
}

void free_bank(bank_t* bank) {
  free_clients(bank->outside);
  free_clients(bank->line);
  free_clients(bank->serving);
  free_clients(bank->served);
  free(bank);
}

