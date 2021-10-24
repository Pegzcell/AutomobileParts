import subprocess as sp
import pymysql
import pymysql.cursors
import pprint
#from insert import *
from delete import *
from update import *
from select_project import *

def cls():
    print('\033c')
#######################################    #####################################
def insertFn():
    print("Insert into")
    relation = input("Relation : ")
    q1 = "DESCRIBE {}".format(relation)
    cur.execute(q1)
    for i in cur.fetchall():
        input("{} :".format(i['field']))
    """
    fields = ', '.join((input("Fields(space separated, * = all fields) : ").strip()).split())
    print(fields)
    c = input("Enter conditions? [Y/N] ")
    conditions =""
    if c.upper() == 'Y':
        conditions += 'WHERE '
        i=1
        while c.upper() == 'Y':
            conditions += input("Condition {}: ".format(i))
            conditions += ' AND '
            c = input("More conditions? [Y/N] ")
    query ="INSERT INTO {} VALUES FROM {} {}".format(relation, conditions[:-5] if conditions else '')
    print(query)
    return query"""

##########################    ############################################3##
queries = [insertFn, deleteFn, updateFn, select_projectFn]

from tabulate import tabulate

#username = input("Username: ")
#password = input("Password: ")

con = pymysql.connect(host="localhost",
                             user="root", password="chill", db="test",
                             cursorclass=pymysql.cursors.DictCursor)

if(con.open):
    print("Connected")
else:
    print("Failed to connect")
    exit()

def menu():
    cls()
    print("""<< Query types Menu >> 
    1. Insert
    2. Delete
    3. Update
    4. Select / Project
    5. Aggregate
    6. Search
    7. Analyze
    ____________________""")
with con.cursor() as cur:
    # cur.execute("SELECT * FROM STU;")
    # print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql'))  
    menu()
    print("-------------")
    while(1):  
        ch = int(input("Enter query number: > "))
        cls()
        try:
            cur.execute(queries[ch-1]())
            print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql'))  
        except Exception as e:
            print(e)
                 
