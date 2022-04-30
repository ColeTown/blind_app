from distutils.command.clean import clean
from flask import Flask, request, jsonify
from pymongo import MongoClient, GEO2D
from pprint import pprint
from bson.son import SON
import pandas as pd
import numpy as np

app = Flask(__name__)
app.config['URI_STRING'] = 'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority'


class MatchingGenerator():
    cluster = MongoClient(app.config['URI_STRING'])
    db = cluster['BlindAppDB']

    mainUsrTags = []
    otherUsrTags = []

    main = {}
    other = {}

    query = {}

    def __init__(self, userId) -> None:
        self.userId = userId

    def showDatabases(self) -> None:
        print(self.cluster.list_database_names())

    def showCollections(self) -> None:
        print(self.db.list_collection_names())

    def connectionsCollection(self) -> None:
        collection = self.db['Connections']
        results = collection.find({})
        for result in results:
            pprint(result)

    def interactionsCollection(self) -> None:
        collection = self.db['Interactions']
        results = collection.find({})
        for result in results:
            pprint(result)

    def messagesCollection(self) -> None:
        collection = self.db['Messages']

        results = collection.find({})

        for result in results:
            pprint(result)

    def uLCollection(self) -> None:
        collection = self.db['UserLocations']
        results = collection.find({})
        for result in results:
            pprint(result)

    def userTagsCollection(self) -> None:
        collection = self.db['UserTags']
        results = collection.find({})
        for result in results:
            pprint(result)

    def usersCollection(self) -> None:
        collection = self.db['Users']
        results = collection.find({})
        for result in results:
            pprint(result)

    def userLong(self) -> None:
        results = self.db['UserLocations'].find_one({'userid': self.userId})
        return float(results['location'][0])

    def userLat(self) -> None:
        results = self.db['UserLocations'].find_one({'userid': self.userId})
        return float(results['location'][1])

    # Returns an object of other users in a certain range

    def query(self, distance) -> None:
        self.db['UserLocations'].drop_indexes()
        self.db['UserLocations'].create_index(
            [('location', GEO2D)], name='loc')

        result = {"location": SON(
            [("$near", [self.userLong(), self.userLat()]), ("$maxDistance", distance)])}

        self.query = self.db['UserLocations'].find(result)

        # for doc in self.db['UserLocations'].find({'location': {'$near': [-101.90497, 33.5220282]}}):
        #    pprint(doc)

       # pprint(self.db['UserLocations'].index_information())

        return self.query

    def getUsrTags(self, usrId) -> None:
        results = self.db['UserTags'].find({'userid': usrId})

        self.otherUsrTags = []

        for result in results:
            if result['userid'] == self.userId:
                self.mainUsrTags.append(result['tag'])
            else:
                self.otherUsrTags.append(result['tag'])

        if usrId == self.userId:
            self.main.update({usrId: self.mainUsrTags})
        else:
            self.other.update({usrId: self.mainUsrTags})

    def matchMaker(self):

        i = 0

        columnCount = 0

        userTagsLen = len(self.mainUsrTags)

        user = pd.DataFrame(columns=['t'+str(i) for i in range(userTagsLen)])

        userTagsLen = len(self.mainUsrTags)

        user['userId'] = [self.userId]

        user.set_index('userId', inplace=True)

        for value in self.other.values():

            if len(value) > columnCount:
                print(len(value))
                columnCount = len(value)

        otherUsers = pd.DataFrame(
            columns=['t'+str(i) for i in range(columnCount)])

        otherUsers['userId'] = self.other.keys()

        otherUsers.set_index('userId', inplace=True)

        for value in self.other.values():
            if len(value) < otherUsers.shape[1]:
                nA = [np.NAN] * (otherUsers.shape[1] - len(value))
                value += nA
                otherUsers.iloc[i] = value
            else:
                otherUsers.iloc[i] = value

            i += 1

        user.iloc[0] = self.mainUsrTags

        userScores = user.apply(lambda x: x.str.len())

        otherUserScores = otherUsers.apply(lambda x: x.str.len())

        userScores['sum'] = userScores.sum(axis=1)
        otherUserScores['sum'] = otherUserScores.sum(axis=1)

        otherUserScores.sort_values(by='sum')

        data = otherUserScores.head()

        return list(data.index)

    # merge = pd.merge(userScores, otherUserScores, on=['userId'])

    def printq(self) -> None:
        for doc in self.query:
            pprint(doc)


#a = MatchingGenerator('then-dog-1993')


#b = a.query(100)

# a.printq()


# for doc in b:
#    a.getUsrTags(doc['userid'])

# print(a.matchMaker())


# c = DatingAlgoritm(a.mainUsrTags, a.otherUsrTags)

@ app.route('/api', methods=['GET'])
def getOrd():
    dic = {}
    val = str(request.args['query'])
    a = MatchingGenerator(val)
    b = a.query(100)
    for doc in b:
        a.getUsrTags(doc['userid'])
    dic['output'] = a.matchMaker()
    return dic


if __name__ == '__main__':
    app.run()
