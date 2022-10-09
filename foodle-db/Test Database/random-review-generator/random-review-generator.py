import random, json, threading
from subprocess import Popen, PIPE

def readFile():
    
    meals = []

    with open('meals.csv', 'r') as mealFile:
        text = mealFile.read().strip().split('\n')
        meals = [tuple(m.split(';')) for m in text]

    return meals

def getReviews(meal, retval):
    
    count = random.randint(0, 10)
    if count == 0: return None

    p = Popen(['curl', '-d', f'product={meal[1]}&number={count}', 'https://randommer.io/Text/Review'], stdout=PIPE, stderr=PIPE, stdin=PIPE)
    retval['reviews'].extend(json.loads(p.stdout.read()))

def createQuery(meals):

    data = []

    threads = []

    for m in meals:
        reviews = {
            'mealID': m[0],
            'reviews': []
        }
        data.append(reviews)
        thread = threading.Thread(target=getReviews, args=(m, reviews))
        thread.start()
        threads.append(thread)

    for i, t in enumerate(threads):
        print(f'{i + 1}/{len(threads)}')
        t.join()

    data = list(filter(lambda r: r['reviews'], data))

    with open('reviews.json', 'w') as reviewFile:
        json.dump(data, reviewFile, indent=4)

if __name__ == '__main__':
    meals = readFile()
    createQuery(meals)