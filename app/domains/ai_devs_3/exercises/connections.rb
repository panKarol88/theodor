# S03E05 - Zadanie 1

module AiDevs3
  module Exercises
    class Connections < Exercise
      def initialize(data_link: nil, destination_link: nil, task: nil)
        super(data_link: data_link, destination_link: destination_link, task: task)

        @graph_db_client = GraphDb::Client.new
      end

      attr_reader :graph_db_client

      def connections
        [{'user1_id': 1, 'user2_id': 5},
         {'user1_id': 1, 'user2_id': 20},
         {'user1_id': 1, 'user2_id': 54},
         {'user1_id': 2, 'user2_id': 14},
         {'user1_id': 2, 'user2_id': 45},
         {'user1_id': 3, 'user2_id': 6},
         {'user1_id': 3, 'user2_id': 31},
         {'user1_id': 3, 'user2_id': 77},
         {'user1_id': 4, 'user2_id': 2},
         {'user1_id': 4, 'user2_id': 34},
         {'user1_id': 4, 'user2_id': 83},
         {'user1_id': 6, 'user2_id': 95},
         {'user1_id': 7, 'user2_id': 51},
         {'user1_id': 8, 'user2_id': 17},
         {'user1_id': 8, 'user2_id': 20},
         {'user1_id': 8, 'user2_id': 79},
         {'user1_id': 9, 'user2_id': 29},
         {'user1_id': 11, 'user2_id': 21},
         {'user1_id': 11, 'user2_id': 78},
         {'user1_id': 13, 'user2_id': 5},
         {'user1_id': 13, 'user2_id': 24},
         {'user1_id': 13, 'user2_id': 40},
         {'user1_id': 13, 'user2_id': 75},
         {'user1_id': 13, 'user2_id': 76},
         {'user1_id': 14, 'user2_id': 26},
         {'user1_id': 14, 'user2_id': 67},
         {'user1_id': 17, 'user2_id': 21},
         {'user1_id': 17, 'user2_id': 30},
         {'user1_id': 17, 'user2_id': 40},
         {'user1_id': 18, 'user2_id': 83},
         {'user1_id': 18, 'user2_id': 95},
         {'user1_id': 19, 'user2_id': 87},
         {'user1_id': 20, 'user2_id': 40},
         {'user1_id': 20, 'user2_id': 86},
         {'user1_id': 22, 'user2_id': 22},
         {'user1_id': 22, 'user2_id': 28},
         {'user1_id': 22, 'user2_id': 92},
         {'user1_id': 24, 'user2_id': 2},
         {'user1_id': 25, 'user2_id': 15},
         {'user1_id': 25, 'user2_id': 31},
         {'user1_id': 27, 'user2_id': 75},
         {'user1_id': 28, 'user2_id': 3},
         {'user1_id': 28, 'user2_id': 6},
         {'user1_id': 28, 'user2_id': 17},
         {'user1_id': 28, 'user2_id': 83},
         {'user1_id': 28, 'user2_id': 84},
         {'user1_id': 29, 'user2_id': 87},
         {'user1_id': 31, 'user2_id': 3},
         {'user1_id': 31, 'user2_id': 7},
         {'user1_id': 31, 'user2_id': 66},
         {'user1_id': 32, 'user2_id': 97},
         {'user1_id': 33, 'user2_id': 8},
         {'user1_id': 34, 'user2_id': 51},
         {'user1_id': 34, 'user2_id': 63},
         {'user1_id': 36, 'user2_id': 59},
         {'user1_id': 37, 'user2_id': 31},
         {'user1_id': 37, 'user2_id': 68},
         {'user1_id': 37, 'user2_id': 80},
         {'user1_id': 38, 'user2_id': 27},
         {'user1_id': 38, 'user2_id': 78},
         {'user1_id': 39, 'user2_id': 46},
         {'user1_id': 40, 'user2_id': 14},
         {'user1_id': 40, 'user2_id': 17},
         {'user1_id': 40, 'user2_id': 39},
         {'user1_id': 40, 'user2_id': 47},
         {'user1_id': 40, 'user2_id': 52},
         {'user1_id': 40, 'user2_id': 82},
         {'user1_id': 41, 'user2_id': 75},
         {'user1_id': 42, 'user2_id': 11},
         {'user1_id': 42, 'user2_id': 20},
         {'user1_id': 42, 'user2_id': 30},
         {'user1_id': 42, 'user2_id': 72},
         {'user1_id': 43, 'user2_id': 92},
         {'user1_id': 44, 'user2_id': 6},
         {'user1_id': 44, 'user2_id': 95},
         {'user1_id': 45, 'user2_id': 18},
         {'user1_id': 45, 'user2_id': 54},
         {'user1_id': 45, 'user2_id': 62},
         {'user1_id': 46, 'user2_id': 36},
         {'user1_id': 47, 'user2_id': 95},
         {'user1_id': 48, 'user2_id': 52},
         {'user1_id': 49, 'user2_id': 16},
         {'user1_id': 49, 'user2_id': 18},
         {'user1_id': 49, 'user2_id': 65},
         {'user1_id': 50, 'user2_id': 34},
         {'user1_id': 51, 'user2_id': 9},
         {'user1_id': 51, 'user2_id': 53},
         {'user1_id': 51, 'user2_id': 70},
         {'user1_id': 52, 'user2_id': 63},
         {'user1_id': 54, 'user2_id': 20},
         {'user1_id': 56, 'user2_id': 19},
         {'user1_id': 56, 'user2_id': 21},
         {'user1_id': 57, 'user2_id': 43},
         {'user1_id': 57, 'user2_id': 62},
         {'user1_id': 58, 'user2_id': 15},
         {'user1_id': 59, 'user2_id': 25},
         {'user1_id': 59, 'user2_id': 37},
         {'user1_id': 59, 'user2_id': 70},
         {'user1_id': 60, 'user2_id': 5},
         {'user1_id': 62, 'user2_id': 54},
         {'user1_id': 63, 'user2_id': 29},
         {'user1_id': 63, 'user2_id': 80},
         {'user1_id': 64, 'user2_id': 73},
         {'user1_id': 65, 'user2_id': 89},
         {'user1_id': 68, 'user2_id': 55},
         {'user1_id': 68, 'user2_id': 91},
         {'user1_id': 71, 'user2_id': 3},
         {'user1_id': 72, 'user2_id': 6},
         {'user1_id': 72, 'user2_id': 74},
         {'user1_id': 72, 'user2_id': 84},
         {'user1_id': 73, 'user2_id': 3},
         {'user1_id': 73, 'user2_id': 14},
         {'user1_id': 75, 'user2_id': 8},
         {'user1_id': 75, 'user2_id': 28},
         {'user1_id': 76, 'user2_id': 27},
         {'user1_id': 76, 'user2_id': 28},
         {'user1_id': 76, 'user2_id': 75},
         {'user1_id': 77, 'user2_id': 39},
         {'user1_id': 77, 'user2_id': 73},
         {'user1_id': 78, 'user2_id': 71},
         {'user1_id': 79, 'user2_id': 11},
         {'user1_id': 79, 'user2_id': 62},
         {'user1_id': 80, 'user2_id': 10},
         {'user1_id': 81, 'user2_id': 51},
         {'user1_id': 82, 'user2_id': 26},
         {'user1_id': 82, 'user2_id': 33},
         {'user1_id': 82, 'user2_id': 47},
         {'user1_id': 83, 'user2_id': 2},
         {'user1_id': 83, 'user2_id': 12},
         {'user1_id': 83, 'user2_id': 82},
         {'user1_id': 84, 'user2_id': 18},
         {'user1_id': 84, 'user2_id': 74},
         {'user1_id': 85, 'user2_id': 29},
         {'user1_id': 86, 'user2_id': 93},
         {'user1_id': 88, 'user2_id': 32},
         {'user1_id': 88, 'user2_id': 71},
         {'user1_id': 89, 'user2_id': 85},
         {'user1_id': 91, 'user2_id': 57},
         {'user1_id': 91, 'user2_id': 65},
         {'user1_id': 91, 'user2_id': 82},
         {'user1_id': 92, 'user2_id': 51},
         {'user1_id': 93, 'user2_id': 27},
         {'user1_id': 93, 'user2_id': 56},
         {'user1_id': 94, 'user2_id': 37},
         {'user1_id': 95, 'user2_id': 17},
         {'user1_id': 95, 'user2_id': 21},
         {'user1_id': 95, 'user2_id': 40},
         {'user1_id': 96, 'user2_id': 4},
         {'user1_id': 96, 'user2_id': 85},
         {'user1_id': 97, 'user2_id': 84}]
      end

      # AiDevs3::Exercises::Connections.new.send_query('select * from users;')
      def users
        [{'id': 1, 'username': 'Adrian', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-12'},
         {'id': 2, 'username': 'Monika', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-29'},
         {'id': 3, 'username': 'Azazel', 'access_level': 'removed', 'is_active': '0', 'lastlog': '2026-11-05'},
         {'id': 4, 'username': 'Robert', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-11-06'},
         {'id': 5, 'username': 'Aleksandra', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-27'},
         {'id': 6, 'username': 'Michał', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-10'},
         {'id': 7, 'username': 'Katarzyna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-20'},
         {'id': 8, 'username': 'Mateusz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-23'},
         {'id': 9, 'username': 'Zofia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-07-10'},
         {'id': 10, 'username': 'Jan', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-09'},
         {'id': 11, 'username': 'Julia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-09'},
         {'id': 12, 'username': 'Tomasz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-17'},
         {'id': 13, 'username': 'Anna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-31'},
         {'id': 14, 'username': 'Piotr', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-04-17'},
         {'id': 15, 'username': 'Natalia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-09'},
         {'id': 16, 'username': 'Paweł', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-02'},
         {'id': 17, 'username': 'Maria', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-06'},
         {'id': 18, 'username': 'Krzysztof', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-17'},
         {'id': 19, 'username': 'Emilia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-05'},
         {'id': 20, 'username': 'Marcin', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-01-30'},
         {'id': 21, 'username': 'Maja', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-01'},
         {'id': 22, 'username': 'Łukasz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-25'},
         {'id': 23, 'username': 'Amelia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-01-15'},
         {'id': 24, 'username': 'Grzegorz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-25'},
         {'id': 25, 'username': 'Alicja', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-14'},
         {'id': 26, 'username': 'Adam', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-01-10'},
         {'id': 27, 'username': 'Martyna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-17'},
         {'id': 28, 'username': 'Rafał', 'access_level': 'user', 'is_active': '0', 'lastlog': '2029-05-11'},
         {'id': 29, 'username': 'Ewelina', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-06'},
         {'id': 30, 'username': 'Maciej', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-29'},
         {'id': 31, 'username': 'Zygfryd', 'access_level': 'admin', 'is_active': '1', 'lastlog': '2238-11-21'},
         {'id': 32, 'username': 'Jakub', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-05'},
         {'id': 33, 'username': 'Agnieszka', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-24'},
         {'id': 34, 'username': 'Hubert', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-11'},
         {'id': 35, 'username': 'Gabriela', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-13'},
         {'id': 36, 'username': 'Dawid', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-04-25'},
         {'id': 37, 'username': 'Lena', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-07-25'},
         {'id': 38, 'username': 'Szymon', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-11'},
         {'id': 39, 'username': 'Barbara', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-11'},
         {'id': 40, 'username': 'Oliwier', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-19'},
         {'id': 41, 'username': 'Nikola', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-25'},
         {'id': 42, 'username': 'Wojciech', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-05-03'},
         {'id': 43, 'username': 'Karolina', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-02'},
         {'id': 44, 'username': 'Wiktor', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-19'},
         {'id': 45, 'username': 'Kinga', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-01-13'},
         {'id': 46, 'username': 'Artur', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-04-22'},
         {'id': 47, 'username': 'Oliwia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-14'},
         {'id': 48, 'username': 'Patryk', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-08-25'},
         {'id': 49, 'username': 'Joanna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-20'},
         {'id': 50, 'username': 'Damian', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-16'},
         {'id': 51, 'username': 'Patrycja', 'access_level': 'user', 'is_active': '0', 'lastlog': '2023-05-04'},
         {'id': 52, 'username': 'Filip', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-17'},
         {'id': 53, 'username': 'Sandra', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-26'},
         {'id': 54, 'username': 'Sebastian', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-01'},
         {'id': 55, 'username': 'Izabela', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-20'},
         {'id': 56, 'username': 'Daniel', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-30'},
         {'id': 57, 'username': 'Beata', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-05-26'},
         {'id': 58, 'username': 'Konrad', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-07'},
         {'id': 59, 'username': 'Klaudia', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-12'},
         {'id': 60, 'username': 'Bartłomiej', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-04'},
         {'id': 61, 'username': 'Renata', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-15'},
         {'id': 62, 'username': 'Igor', 'access_level': 'user', 'is_active': '0', 'lastlog': '2023-10-28'},
         {'id': 63, 'username': 'Edyta', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-28'},
         {'id': 64, 'username': 'Kamil', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-23'},
         {'id': 65, 'username': 'Magdalena', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-08'},
         {'id': 66, 'username': 'Bartosz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-25'},
         {'id': 67, 'username': 'Małgorzata', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-02'},
         {'id': 68, 'username': 'Witold', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-27'},
         {'id': 69, 'username': 'Justyna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-27'},
         {'id': 70, 'username': 'Marian', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-25'},
         {'id': 71, 'username': 'Iwona', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-10-06'},
         {'id': 72, 'username': 'Jerzy', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-05-12'},
         {'id': 73, 'username': 'Dorota', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-09-11'},
         {'id': 74, 'username': 'Leszek', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-13'},
         {'id': 75, 'username': 'Zuzanna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-13'},
         {'id': 76, 'username': 'Cezary', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-14'},
         {'id': 77, 'username': 'Aleksander', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-01-25'},
         {'id': 78, 'username': 'Oskar', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-15'},
         {'id': 79, 'username': 'Halina', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-16'},
         {'id': 80, 'username': 'Leon', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-17'},
         {'id': 81, 'username': 'Elżbieta', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-05-04'},
         {'id': 82, 'username': 'Kazimierz', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-28'},
         {'id': 83, 'username': 'Weronika', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-02'},
         {'id': 84, 'username': 'Andrzej', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-02-11'},
         {'id': 85, 'username': 'Grażyna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-29'},
         {'id': 86, 'username': 'Jacek', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-19'},
         {'id': 87, 'username': 'Michalina', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-08'},
         {'id': 88, 'username': 'Przemysław', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-17'},
         {'id': 89, 'username': 'Hanna', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-16'},
         {'id': 90, 'username': 'Bogdan', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-12-24'},
         {'id': 91, 'username': 'Sylwia', 'access_level': 'user', 'is_active': '0', 'lastlog': '2024-02-06'},
         {'id': 92, 'username': 'Borys', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-03-14'},
         {'id': 93, 'username': 'Ludwika', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-01-19'},
         {'id': 94, 'username': 'Norbert', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-11-01'},
         {'id': 95, 'username': 'Roksana', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-06-28'},
         {'id': 96, 'username': 'Fryderyk', 'access_level': 'user', 'is_active': '1', 'lastlog': '2024-02-11'},
         {'id': 97, 'username': 'Jolanta', 'access_level': 'user', 'is_active': '1', 'lastlog': '2023-07-28'}]
      end

      def list_of_connections_for(username)
        id = users.select{|user| user[:username] == username }[0][:id]
        conns = connections.select{|connection| connection[:user1_id] == id }
        conns.map do |conn|
          {
            id: conn[:user2_id],
            username: users.select{|u| u[:id] == conn[:user2_id]}[0][:username]
          }
        end
      end

      def send_query(query)
        payload = {
          task: 'database',
          apikey: ENV.fetch('AI_DEVS_API_KEY', nil),
          query:
        }.to_json

        JSON.parse(send_post_request('https://centrala.ag3nts.org/apidb', payload))['reply']
      end

      def create_node_for_each_person
        users.each do |person|
          graph_db_client.create_node(label: 'Person', properties: person.slice(:id, :username))
        end
      end

      def create_connections
        connections.each do |connection|
          p connection
          n_element_id = graph_db_client.nodes_where(label: 'Person', id: connection[:user1_id])[0]['data'][0]['meta'][0]['elementId']
          m_element_id = graph_db_client.nodes_where(label: 'Person', id: connection[:user2_id])[0]['data'][0]['meta'][0]['elementId']

          graph_db_client.create_relationship(n_element_id:, m_element_id:, relation: 'CONTACT')
        end
      end

      def answer
        n_element_id = graph_db_client.nodes_where(label: 'Person', username: 'Rafał')[0]['data'][0]['meta'][0]['elementId']
        m_element_id = graph_db_client.nodes_where(label: 'Person', username: 'Barbara')[0]['data'][0]['meta'][0]['elementId']

        path = graph_db_client.shortest_path(n_element_id: n_element_id, m_element_id: m_element_id)
        path['results'][0]['data'][0]['row'][0].map { |node| node['username'] }.join(', ')
      end
    end
  end
end

# AiDevs3::Exercises::Connections.new.list_of_connections_for('Borys')
# AiDevs3::Exercises::Connections.new.create_node_for_each_person
# AiDevs3::Exercises::Connections.new.create_connections
# AiDevs3::Exercises::Connections.new.answer

# AiDevs3::Exercises::Connections.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'CONNECTIONS').send_answer
