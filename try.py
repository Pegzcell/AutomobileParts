import pymysql
import pymysql.cursors
import pprint
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

############################################################################

def clear_screen():
    print('\033c')

############################################################################

def insertFn():
    print("Insert into")
    relation = input("Relation : ")
    q1 = "DESCRIBE {}".format(relation)
    cur.execute(q1)
    c= 'Y'
    while c.upper() == 'Y':
        fields = []
        values = []
        print("Enter values")
        for i in cur.fetchall():
            field = i['field']
            value = (input("{} : ".format(field))).strip()
            if value:
                fields.append(field)
                values.append(value)
        query = "INSERT INTO {}({}) VALUES({});".format(relation, ', '.join(fields), ', '.join(values))
        print(query)
        cur.execute(query)

###########################################################################

def select_projectFn():
    print("View from")
    relation = input("Relation : ")
    fields = ', '.join((input("Fields(space separated, * = all fields) : ").strip()).split())
    print(fields)
    c = input("Enter conditions? [Y/N] ")
    conditions = []
    if c.upper() == 'Y':
        i=1
        while c.upper() == 'Y':
            conditions.append(input("Condition {}: ".format(i)))
            c = input("More conditions? [Y/N] ")
    query ="SELECT {} FROM {} {}".format(fields, relation, 'WHERE' + ' AND '.JOIN(conditions) if conditions else '')
    print(query)
    cur.execute(query)
    print(tabulate(cur.fetchall(), headers="keys", tablefmt='psql')) 

###########################################################################

def quit():
    exit(0)

###########################################################################
queries = [clear_screen, insertFn, select_projectFn, quit]
###########################################################################

def menu():
    clear_screen()
    print('<< Query types Menu >>')
    for i in range(1,len(queries)+1):
        print(i, '. ', ' '.join((queries[i].rstrip('Fn')).split('_')).title())
    print('_'*20)

with con.cursor() as cur:
    menu()
    print("-------------")
    while(1):  
        ch = int(input("Enter query number: > "))
        try:
            queries[ch-1]() 
        except Exception as e:
            print(e)
                 
