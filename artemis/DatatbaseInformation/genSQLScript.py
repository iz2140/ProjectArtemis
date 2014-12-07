import csv

def unicode_csv_reader(utf8_data, dialect=csv.excel, **kwargs):
    csv_reader = csv.reader(utf8_data, dialect=dialect, **kwargs)
    for row in csv_reader:
        yield [unicode(cell, 'utf-8') for cell in row]

def writeProviderPicturesInsert(tablename, infile, outfile):
    rows = []
    reader = unicode_csv_reader(open(infile))
    for row in reader:
        rows.append(row)
    
    fields = rows[0]
    data = rows[1:]
    commands = []
    for datum in data:
        assert len(datum) == len(fields)
        for ind, val in enumerate(datum):
            if not val:
                datum[ind] = 0
            
            else:
                datum[ind] = val.encode('utf-8')

        commands.append('INSERT INTO {table} ({field0}, {field1}, {field2}) VALUES ({val0}, {val1}, "{val2}" );\n'.format(table=tablename,field0=fields[0],
            field1=fields[1], 
            field2=fields[2], 
            val0=datum[0],
            val1=datum[1], 
            val2=datum[2]))
    with open(outfile, 'wb') as f:
        for com in commands:
            f.write(com)



def writeUsersInsert(tablename, infile, outfile):
    rows = []
    reader = unicode_csv_reader(open(infile))
    for row in reader:
        rows.append(row)
    
    fields = rows[0]
    data = rows[1:]
    commands = []
    for datum in data:
        assert len(datum) == len(fields)
        for ind, val in enumerate(datum):
            if not val:
                datum[ind] = 0
            
            else:
                datum[ind] = val.encode('utf-8')

        commands.append('INSERT INTO {table} ({field0}, {field1}, {field2}, {field3}, {field4}) VALUES ("{val0}", "{val1}", {val2}, "{val3}", "{val4}");\n'.format(table=tablename,field0=fields[0],
            field1=fields[1], 
            field2=fields[2], 
            field3=fields[3],
            field4=fields[4],
            val0=datum[0],
            val1=datum[1], 
            val2=datum[2],
            val3=datum[3],
            val4=datum[4]))
    with open(outfile, 'wb') as f:
        for com in commands:
            f.write(com)



def writeReviewsInsert(tablename, infile, outfile):
    rows = []
    reader = unicode_csv_reader(open(infile))
    for row in reader:
        rows.append(row)
    
    fields = rows[0]
    data = rows[1:]
    commands = []
    for datum in data:
        assert len(datum) == len(fields)
        for ind, val in enumerate(datum):
            if not val:
                datum[ind] = 0
            
            else:
                datum[ind] = val.encode('utf-8')

        commands.append('INSERT INTO {table} ({field0}, {field1}, {field2}, {field3}, {field4}, {field5}, {field6}, {field7}) VALUES ("{val0}", "{val1}", "{val2}", "{val3}", "{val4}", {val5}, "{val6}", {val7});\n'.format(table=tablename,field0=fields[0],
            field1=fields[1], 
            field2=fields[2], 
            field3=fields[3],
            field4=fields[4],
            field5=fields[5],
            field6=fields[6],
            field7=fields[7],
            val0=datum[0],
            val1=datum[1], 
            val2=datum[2],
            val3=datum[3],
            val4=datum[4],
            val5=datum[5],
            val6=datum[6],
            val7=datum[7]))
    with open(outfile, 'wb') as f:
        for com in commands:
            f.write(com)



def writeServicesInsert(tablename, infile, outfile):
    rows = []
    reader = unicode_csv_reader(open(infile))
    for row in reader:
        rows.append(row)
    
    fields = rows[0]
    data = rows[1:]
    commands = []
    for datum in data:
        assert len(datum) == len(fields)
        for ind, val in enumerate(datum):
            if not val:
                datum[ind] = 0
            
            else:
                datum[ind] = val.encode('utf-8')
       
        commands.append('INSERT INTO {table} ({field0}, {field1}, {field2}, {field3}, {field4}, {field5}, {field6}, {field7}, {field8}) VALUES ("{val0}", "{val1}", "{val2}", "{val3}", "{val4}", "{val5}", "{val6}", "{val7}", "{val8}");\n'.format(table=tablename,field0=fields[0],
            field1=fields[1], 
            field2=fields[2], 
            field3=fields[3],
            field4=fields[4],
            field5=fields[5],
            field6=fields[6],
            field7=fields[7],
            field8=fields[8],
            val0=datum[0],
            val1=datum[1], 
            val2=datum[2],
            val3=datum[3],
            val4=datum[4],
            val5=datum[5],
            val6=datum[6],
            val7=datum[7],
            val8=datum[8]))
    with open(outfile, 'wb') as f:
        for com in commands:
            f.write(com)

def writeProvidersInsert(tablename, infile, outfile):
    rows = []
    reader = unicode_csv_reader(open(infile))
    for row in reader:
        rows.append(row)
    
    fields = rows[0]
    data = rows[1:]
    commands = []
    for datum in data:
        assert len(datum) == len(fields)
        for ind, val in enumerate(datum):
            if not val:
                datum[ind] = "NULL"
            
            else:
                datum[ind] = val.encode('utf-8')
            datum[6] = 'NY'
       
        commands.append('INSERT INTO {table} ({field0}, {field1}, {field2}, {field3}, {field4}, {field5}, {field6}, {field7}, {field8}, {field9}, {field10}, {field11}, {field12}, {field13}) VALUES ("{val0}", "{val1}", "{val2}", "{val3}", "{val4}", "{val5}", "{val6}", "{val7}", "{val8}", "{val9}", "{val10}", "{val11}", "{val12}", "{val13}");\n'.format(table=tablename,field0=fields[0], 
            field1=fields[1], 
            field2=fields[2], 
            field3=fields[3],
            field4=fields[4],
            field5=fields[5],
            field6=fields[6],
            field7=fields[7],
            field8=fields[8],
            field9=fields[9],
            field10=fields[10],
            field11=fields[11],
            field12=fields[12],
            field13=fields[13],
            val0=datum[0],
            val1=datum[1], 
            val2=datum[2],
            val3=datum[3],
            val4=datum[4],
            val5=datum[5],
            val6=datum[6],
            val7=datum[7],
            val8=datum[8],
            val9=datum[9],
            val10=datum[10],
            val11=datum[11],
            val12=datum[12],
            val13=datum[13],
            ))
    with open(outfile, 'wb') as f:
        for com in commands:
            f.write(com)

if __name__ == "__main__":
   #writeProvidersInsert("providers", "providers.csv", "providerInsert.sql")
   #writeServicesInsert("services", "services.csv", "serviceInsert.sql")
   #writeReviewsInsert("reviews", "reviews.csv", "reviews.sql")
   #writeUsersInsert("users", "users.csv", "users.sql")
   writeProviderPicturesInsert("providerphotos", "providerphotos.csv", "providerphotos.sql")


