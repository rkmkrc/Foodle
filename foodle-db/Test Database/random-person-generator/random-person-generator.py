import random, sys, string, faker

def read_files():
    first_names = []
    last_names = []

    with open('firstNames.csv', 'r') as first_names_file:
        data = first_names_file.read()

        data = data.strip().split('\n')
        data = [tuple(e.strip().split(',', maxsplit=2)[:2]) for e in data]

        first_names = data

    with open('lastNames.csv', 'r') as last_names_file:
        data = last_names_file.read()

        data = data.strip().split('\n')
        data = [e.strip().split(',', maxsplit=1)[0] for e in data]

        last_names = data

    return {
        'firstNames': first_names,
        'lastNames': last_names
    }

def create_person(data, count):

    mailProviders = ('gmail', 'outlook')
    seperators = ('.', '_')
    base64alphabet = string.digits + string.ascii_uppercase + string.ascii_lowercase + '+/'
    areaCodes = (501, 505, 506, 507, 551, 552, 553, 554, 555, 559,
                516, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 561,
                541, 542, 543, 544, 545, 546, 547, 548, 549)
    dateGenerator = faker.Faker()

    people = []
    
    for i in range(count):
        person = {
            'userID': i + 1000,
            'username': '',
            'email': '',
            'phoneNumber': '',
            'hashedPassword': '',
            'name': '',
            'surname': '',
            'birthdate': '',
            'sex': '',
        }

        firstName, gender = random.choice(data['firstNames'])
        lastName = random.choice(data['lastNames'])

        person['name'] = firstName
        person['surname'] = lastName
        person['sex'] = gender

        username = f'{firstName}{random.choice(seperators)}{lastName}'.lower()
        
        while list(filter(lambda p: p['username'] == username, people)):
            username += str(random.randint(0, 9))

        person['username'] = username
        person['email'] = username + f'@{random.choice(mailProviders)}.com'
        person['hashedPassword'] = ''.join((random.choice(base64alphabet) for i in range(16)))

        people.append(person)

        birthdate = dateGenerator.date_time_between(start_date='-65y', end_date='-18y')
        birthdate = f'{birthdate.year}-{birthdate.month:02}-{birthdate.day:02}'

        person['birthdate'] = birthdate
        person['phoneNumber'] = f'+90{random.choice(areaCodes)}{random.randint(100,999)}{random.randint(0, 9999):04}'
        
    return people

def createQueries(people):

    queryText = ''

    for p in people:
        queryText += 'INSERT INTO "UserCredentials"(userID, username, email, phoneNumber, hashedPassword) VALUES\n'
        queryText += f'\t(\'{p["userID"]}\', \'{p["username"]}\', \'{p["email"]}\', \'{p["phoneNumber"]}\', \'{p["hashedPassword"]}\');\n'
        queryText += 'INSERT INTO "UserInfo"(userID, name, surname, birthdate, sex) VALUES\n'
        queryText += f'\t(\'{p["userID"]}\', \'{p["name"]}\', \'{p["surname"]}\', \'{p["birthdate"]}\', \'{p["sex"]}\');\n\n'

    with open('peopleQuery.sql', 'w') as peopleQueryFile:
            peopleQueryFile.write(queryText)

if __name__ == '__main__':
    data = read_files()

    people = create_person(data, int(sys.argv[1]))

    createQueries(people)