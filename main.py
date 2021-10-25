import pymysql
import pymysql.cursors
import pprint
import time
from datetime import datetime as dt
from tabulate import tabulate

username = input("Username: ")
password = input("Password: ")

try:
    con = pymysql.connect(host="localhost", user=username, password=password, db="AUTOMOBILE_PARTS", cursorclass=pymysql.cursors.DictCursor)
    print("Connected")
    time.sleep(1)
except:
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
    print("""1. Corporate profit made by the factory in a month
    """)
    c = int(input("Enter choice: "))
    if c == 1:
        l = input("Month MM (YYYY): ").split()
        days = int(input("Number of business days: "))
        rpu = int(input("Electricity rate per unit: "))
        if len(l) == 1:
            l.append(dt.now().year)
        l[0] = int(l[0])
        l[1] = int(l[1])
        m1 = dt(l[1],l[0],1)
        m = "'{}-{}-%'".format(l[1],l[0])
        m2 = "'{}-{}-01'".format(l[1],l[0])
        print("""
Profit Analysis for {}
===================================""".format(m1.strftime("%B %Y")))
        ##
        expenditure = 0
        print("Expenditure")

        query = "SELECT SUM(salary) AS P FROM SALARIED, EMPLOYEE WHERE id = e_id AND date_of_joining < {};".format(m2)
        cur.execute(query)
        p=cur.fetchone()['P']
        p=p if p else 0
        expenditure+= p
        print("\tEmployee salaries: ", p)
        #
        query = "SELECT SUM(pay_scale*hours_of_work) AS P from HOURLY_PAID WHERE date_of_work LIKE {};".format(m)
        cur.execute(query)
        p=cur.fetchone()['P']
        p=p if p else 0
        expenditure+= p
        print("\tDaliy wages: ", p)
        #
        query = "SELECT SUM(t) AS P FROM (SELECT sum(power_consumed)*hours_active*{}*{} as t FROM MACHINE, ASSEMBLY_LINE WHERE l_no=num GROUP BY l_no) as U;".format(days, rpu)
        cur.execute(query)
        p=cur.fetchone()['P']
        p=p if p else 0
        expenditure+=p
        print("\tMachinery: ", p)
        #
        query = "SELECT SUM(T) AS P FROM (SELECT (S.quantity*price) AS T FROM SUPPLY AS S, RAW_MATERIAL WHERE id =r_id AND date_of_purchase like {}) AS U;".format(m)
        cur.execute(query)
        p=cur.fetchone()['P']
        p=p if p else 0
        expenditure+=p
        print("\tRaw Material: ", p)  

        print('\t', "_"*27,sep='')
        print('\t'*3, expenditure)    
        ##
        query = "SELECT SUM(T) AS P FROM (SELECT (P.quantity*price) AS T FROM PURCHASE AS P, PRODUCT WHERE NUM =p_id AND date_of_purchase like {}) AS U;".format(m)
        cur.execute(query)
        sale=cur.fetchone()['P']
        sale = sale if sale else 0
        print("Sale")
        print('\t'*3, sale)   
        ##
        profit= sale - expenditure
        print("Profit\n\t\t\t{:.2f}".format(profit))
        if expenditure:
            print("Profit percentage\n\t\t\t{:.2f} %".format((profit/expenditure) *100))
###########################################################################
queryFns = [menu, clear_screen, db, insertFn, select_projectFn, analyzeFn, ex, quit]
queries = ['Menu', 'Clear Screen' , 'Print Database', 'Insert', 'Select / Project', 'Analyze', 'SQL','Quit']
###########################################################################

with con.cursor() as cur:
    print("<<",queries[0],">>")
    clear_screen()
    while(1):
        print('_'*100,'\n')  
        ch = int(input("Enter query number: > "))
        try:
            print("<< ",queries[ch -1]," >>")
            queryFns[ch-1]() 
        except Exception as e:
            print(e)
                 
