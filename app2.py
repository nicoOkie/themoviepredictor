import mysql.connector
import sys
import argparse
import csv


def connectToDatabase():
    return mysql.connector.connect(user='movie', password='movie-pass',
                              host='127.0.0.1',
                              database='movie-db')

def disconnectDatabase(cnx):
    cnx.close()

def createCursor(cnx):
    return cnx.cursor(dictionary=True)

def closeCursor(cursor):    
    cursor.close()

def findQuery(table, id):
    return ("SELECT * FROM {} WHERE id = {}".format(table, id))

def findAllQuery(table):
    return ("SELECT * FROM {}".format(table))

def find(table, id):
    cnx = connectToDatabase()
    cursor = createCursor(cnx)
    cursor.execute(findQuery(table, id))
    results = cursor.fetchall()
    closeCursor(cursor)
    disconnectDatabase(cnx)
    return results

def findAll(table):
    cnx = connectToDatabase()
    cursor = createCursor(cnx)
    cursor.execute(findAllQuery(table))
    results = cursor.fetchall()
    closeCursor(cursor)
    disconnectDatabase(cnx)
    return results  

parser = argparse.ArgumentParser(description='Process MoviePredictor data')
parser = argparse.ArgumentParser(description='Process MoviePredictor Data')
# arguments positionels
parser.add_argument('context' , choices=['people','movies'],help='contexte dans lequel nous allons travailler')
subparsers = parser.add_subparsers(dest='action',required=True)
parser_list = subparsers.add_parser('list')
parser_find = subparsers.add_parser('find')

parser_find.add_argument('id', metavar='id', type=int)
parser.add_argument('--export', metavar='file.csv')

# parser.add_argument('context', choices=['people', 'movies'], help='Le contexte dans lequel nous allons travailler')
# parser.add_argument('action', choices=['list', 'find'], help='L\'action à effectuer dans le contexte')

# parser.add_argument('--id', type=int, help='L\'identifiant à rechercher')
# parser.add_argument('--export' , help='Chemin du fichier exporté')

args = parser.parse_args()

if args.context == "people":
    if args.action == "list":
        people = findAll("people")
        for person in people:
            print("#{}: {} {}".format(person['id'], person['firstname'], person['lastname']))
        if args.export:
            csvfile = open(args.export, 'w', newline='\n', encoding='utf-8')
            writer = csv.writer(csvfile)
            writer.writerow(people[0].keys())
            for person in people:
                writer.writerow(person.values())
            csvfile.close()

    if args.action == "find":
        peopleId = args.id
        people = find("people", peopleId)
        for person in people:
            print("#{}: {} {}".format(person['id'], person['firstname'], person['lastname']))

if args.context == "movies":
    if args.action == "find":  
        movieId = args.id
        movies = find("movies", movieId)
        for movie in movies:
            print("#{}: {} released on {}".format(movie['id'], movie['fr_title'], movie['release_date']))
