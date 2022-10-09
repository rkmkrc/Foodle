import random

data = ''

with open('meals.csv', 'r', encoding='utf-8') as dataFile:
    data = dataFile.read().strip()

data = data.split('\n')

query = 'INSERT INTO "Meal"(restaurantID, name, price) VALUES'

for row in data:
    row = row.split(';')[:2]
    query = query + '\n'
    query = query + f'\t({random.randint(1, 194)}, \'{row[1]}\', {random.random() * 80 + 20:.1f}{(0, 5)[random.random() > 0.5]}),'

query = query[:-1] + ';'

with open('mealQuery.sql', 'w', encoding='utf-8') as qF:
    qF.write(query)