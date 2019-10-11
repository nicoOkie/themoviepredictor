"""
The movie DB project
"""


import mysql.connector
import sys

# cnx = None

def connectToDatabase():
    # Initializing connection
    cnx = mysql.connector.connect(user = "movie",
                                password = "movie-pass",
                                host = "127.0.0.1",
                                database = "movie-db")

    # Creating cursor
    cursor = cnx.cursor(named_tuple=True)

    return [cnx, cursor]


def findQuery(table, id):
    return (f"SELECT * FROM {table} WHERE {id}")

def find(table, id):
    cursor.execute(findQuery(table, id))

arguments = sys.argv.copy()
arguments.pop(0)


table = arguments[0]

# print("....{}".format(maVar)) => insert maVar dans les {}
# print(
#     "Argument 1: {}, Argument 2: {}, Argument 3: {}"
#     .format(
#         arguments[0],
#         arguments[1],
#         arguments[2]
#     )
# )

if table == "people":
    if arguments[1] == "find":
        peopleId = arguments[2]
        # print(f"...{maVar}") => insert la veleur de maVar dans les {}

        cnx, cursor = connectToDatabase()
        cursor.execute(findQuery("people", peopleId))

        for person in cursor:
            print(f"#{person.id}: {person.firstname} {person.lastname}")

        cursor.close()
        cnx.close()

    if arguments[1] == "insert":
        firstname = arguments[2]
        lastname= arguments[3]
        
        cursor = connectToDatabase()
        query = (f"INSERT INTO {table} (firstname, lastname) VALUES ('{firstname}', '{lastname}'')")
        cursor.execute(query)
        cnx.commit()

        cursor.close()
        cnx.close()

if table == "movie":
    if arguments[1] == "find":

        cursor = connectToDatabase()
        query = ("SELECT * FROM `movies`")
        cursor.execute(query)

        for movie in cursor:
            print(f"#{movie.id}: {movie.fr_title} | {movie.release_date} | {movie.duration} min.")

        cursor.close()
        cnx.close()

 

"""cnx = mysql.connector.connect(user = "movie",
                              password = "movie-pass",
                              host = "127.0.0.1",
                              database = "movie-db")

cursor = cnx.cursor()

query = ("SELECT id, fr_title, release_date FROM movies")

cursor.execute(query)

for (id, fr_title, release_date) in cursor:
    print("({}) {} was release on {}"
    .format(id, fr_title, release_date))

cursor.close()


cursor = cnx.cursor()

add_movie = ("INSERT INTO `people` "
            "(firstname, lastname) "
            "VALUES "
            "("Bruce", "Willis"), "
            "("Ving", "Rhames"); ")

cursor.execute(add_movie)

cnx.commit()

cursor.close()
cnx.close()"""
