from distutils.command.clean import clean
from flask import Flask, request, jsonify
from pymongo import MongoClient, GEO2D
from pprint import pprint

app = Flask(__name__)
app.config['URI_STRING'] = 'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority'


class MatchingGenerator():
    cluster = MongoClient(app.config['URI_STRING'])
    db = cluster['BlindAppDB']

    query = {}

    def __init__(self, userId):
        self.userId = userId

    def showDatabases(self):
        print(self.cluster.list_database_names())

    def showCollections(self):
        print(self.db.list_collection_names())

    def connectionsCollection(self):
        collection = self.db['Connections']
        results = collection.find({})
        for result in results:
            pprint(result)

    def interactionsCollection(self):
        collection = self.db['Interactions']
        results = collection.find({})
        for result in results:
            pprint(result)

    def messagesCollection(self):
        collection = self.db['Messages']

        results = collection.find({})

        for result in results:
            pprint(result)

    def uLCollection(self):
        collection = self.db['UserLocations']
        results = collection.find({})
        for result in results:
            pprint(result)

    def userTagsCollection(self):
        collection = self.db['UserTags']
        results = collection.find({})
        for result in results:
            pprint(result)

    def usersCollection(self):
        collection = self.db['Users']
        results = collection.find({})
        for result in results:
            pprint(result)

    def userLong(self):
        pass

    def userLat(self):
        pass

    def query(self, long, lat):
        self.db['UserLocations'].drop_indexes()
        self.db['UserLocations'].create_index(
            [('location', GEO2D)], name='loc')

        self.result = self.db['UserLocations'].find(
            {'location': {'$near': [long, lat]}})

        # for doc in self.db['UserLocations'].find({'location': {'$near': [-101.90497, 33.5220282]}}):
        #    pprint(doc)

       # pprint(self.db['UserLocations'].index_information())

        return self.result

    def printq(self):

        for doc in self.result:
            pprint(doc)


#a = MatchingGenerator('then-dog-1993')

# b = a.query(
#    -101.90498, 33.5220283)

# a.printq()

@app.route('/api', methods=['GET'])
def getOrd():
    dic = {}
    val = str(request.args['query'])
    answer = str(val)
    dic['output'] = app.config['URI_STRING']
    return dic


if __name__ == '__main__':
    app.run()
