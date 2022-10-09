data = ''

with open('rest.csv', 'r', encoding='utf-8') as dataFile:
    data = dataFile.read().strip()

data = data.split('\n')[1:]

query = 'INSERT INTO "Restaurant"(name, type, latitude, longitude) VALUES'

for row in data:
    query = query + '\n'
    query = query + '\t' + str(tuple(filter(None, row.split(';')[:4]))) + ','

query = query[:-1] + ';'

with open('query.sql', 'w', encoding='utf-8') as qF:
    qF.write(query)