import random, sys

def createQuery(count):
    
    queryText = 'INSERT INTO "UserReviewVote"(reviewID, userID, "type") VALUES'

    data = set()

    for i in range(count):
        data.add((random.randint(1, 9043), random.randint(1000, 10999)))

    for d in data:
        queryText += f'\n\t({d[0]}, {d[1]}, {str(random.random() > 0.5).upper()}),'

    queryText = queryText[:-1] + ';'

    with open('urvquery.sql', 'w') as queryFile:
        queryFile.write(queryText)

if __name__ == '__main__':
    createQuery(int(sys.argv[1]))