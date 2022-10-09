import json, random, faker

def createQuery():

    dateGenerator = faker.Faker()

    data = []
    
    with open('reviews.json', 'r') as reviewFile:
        data = json.load(reviewFile)
    
    queryText = 'INSERT INTO "Review"(userID, mealID, text, date, rate) VALUES'

    for d in data:
        for r in d['reviews']:
            r = r.replace("'", "''")

            queryText += f"\n\t({random.randint(1000, 10999)}, {d['mealID']}, '{r}', '{str(dateGenerator.date_time_between(start_date='-1y', end_date='now'))}', {random.randint(1, 5)}),"

    queryText = queryText[:-1] + ';'

    with open('query.sql', 'w') as queryFile:
        queryFile.write(queryText)

if __name__ == '__main__':
    createQuery()