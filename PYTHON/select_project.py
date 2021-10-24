def select_projectFn():
    print("View from")
    relation = input("Relation : ")
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
    query ="SELECT {} FROM {} {}".format(fields, relation, conditions[:-5] if conditions else '')
    print(query)
    return query