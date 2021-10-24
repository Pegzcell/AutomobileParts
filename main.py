import pymysql
import pymysql.cursors
import pprint
import time
from tabulate import tabulate

username = input("Username: ")
password = input("Password: ")

con = pymysql.connect(host="localhost", user=username, password=password, db="AUTOMOBILE_PARTS", cursorclass=pymysql.cursors.DictCursor)

if(con.open):
    print("Connected")
    time.sleep(1)
else:
    print("Failed to connect")
    exit()

############################################################################

def menu():
    for i in range(len(queries)):
        print(i+1, '. ', queries[i], sep ='')

############################################################################

def clear_screen():
    print('\033c')
    menu()

############################################################################

def db():
    cur.execute("SHOW TABLES;")
    f = cur.fetchall()
    for i in f:
        table = i['Tables_in_AUTOMOBILE_PARTS']
        print(table)
        query = "SELECT * FROM {};".format(table)
        cur.execute(query)
        print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql')) 
        print()

############################################################################
def insertFn():
    relation = input("into Relation : ")
    q1 = "DESCRIBE {}".format(relation)
    cur.execute(q1)
    f = cur.fetchall()
    c= 'Y'
    while c.upper() == 'Y':
        fields = []
        values = []
        print("Enter values")
        for i in f:
            field = i['Field']
            value = (input("{} : ".format(field))).strip()
            if value:
                fields.append(field)
                values.append(value if (value.isnumeric() and len(value) < 7) else "'{}'".format(value))
        query = "INSERT INTO {}({}) VALUES({});".format(relation, ', '.join(fields), ', '.join(values))
        print(query)
        cur.execute(query)
        c = input("Insert more tuples? [Y/N] ")


###########################################################################

def select_projectFn():
    relation = input("from Relation : ")
    fields = ', '.join((input("Fields(space separated, * = all fields) : ").strip()).split())
    c = input("Enter conditions? [Y/N] ")
    conditions = []
    i=1
    while c.upper() == 'Y':
        conditions.append(input("Condition {}: ".format(i)))
        i+=1
        c = input("More conditions? [Y/N] ")
    query ="SELECT {} FROM {} {}".format(fields, relation, 'WHERE ' + ' AND '.join(conditions) if conditions else '')
    print(query)
    cur.execute(query)
    print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql')) 

###########################################################################

def ex():
    cur.execute(input("Enter SQL query: "))
    print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql')) 

###########################################################################

def quit():
    exit(0)

###########################################################################

def analyzeFn():
    print("""1. Corporate profit made by the factory last month
    """)
    c = input("Enter analysis number: ")
    if c == 1:
        pass

###########################################################################
queryFns = [menu, clear_screen, db, insertFn, select_projectFn, analyzeFn, ex, quit]
queries = ['Menu', 'Clear Screen' , 'Print Database', 'Insert', 'Select / Project', 'Analyze', 'SQL','Quit']
###########################################################################

with con.cursor() as cur:
    print("<< ",queries[0]," >>")
    clear_screen()
    while(1):
        print('_'*23,'\n')  
        ch = int(input("Enter query number: > "))
        try:
            print("<< ",queries[ch -1]," >>")
            queryFns[ch-1]() 
        except Exception as e:
            print(e)
                 
