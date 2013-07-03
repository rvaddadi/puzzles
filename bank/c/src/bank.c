#include <stdio.h>
#include <stdlib.h>

#define MAXIMUM_WAITING_TIME 20

typedef struct {
  int arrival;
  int total_serving_duration;
  int waiting_duration;
  int serving_duration;
} client_t;

typedef struct {
  client_t** clients;
  int size;
} clients_t;

typedef struct {
  int tellers;
  int occupied_tellers;
  clients_t* outside;
  clients_t* line;
  clients_t* serving;
  clients_t* served;
} bank_t;

bank_t* read_bank_information();

void serve_clients(bank_t* bank);

int clients_exceeded_waiting(clients_t* clients, int threshold);

void add_client(clients_t* clients, client_t* client);

void remove_client(clients_t* clients, int position);

int all_clients_served(bank_t* bank);

client_t* init_client(int arrival, int total_serving_duration);

void free_client(client_t* client);

clients_t* init_clients(int maximum_size);

void free_clients(clients_t* clients);

bank_t* init_bank(int tellers, int clients);

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

