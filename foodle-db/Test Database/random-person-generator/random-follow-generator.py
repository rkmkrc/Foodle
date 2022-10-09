import random, sys

def createQuery(count):
    

    queryText = 'INSERT INTO "UserFollow"(followerID, followingID) VALUES'
    values = set()

    while len(values) != count:
        entry = (random.randint(1000, 10999), random.randint(1000, 10999))
        values.add(entry)

    for e in values:
        queryText += f'\n\t{e},'

    queryText = queryText[:-1] + ';'

    with open('userFollowQuery.sql', 'w') as queryFile:
        queryFile.write(queryText)

if __name__ == '__main__':
    createQuery(int(sys.argv[1]))