from distutils.command.clean import clean
from flask import Flask, request, jsonify
import pymongo
from pymongo import MongoClient

#app = Flask(__name__)

post1 = {"userid": 'tim-cook'}

userId = 'then-dog-1993'  # then-dog-1993
connectionString = 'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority'

client = MongoClient(connectionString)

db = client['BlindAppDB']
collection = db['Users']

results = collection.find({'userid': 'then-dog-1993'})

for result in results:
    print(result)


# @app.route('/api', methods=['GET'])
# def getOrd():
#   connectionString = 'mongodb+srv://jmarks:Nzsp_C7pagvgm34@cluster0.8kwix.mongodb.net/BlindAppDB?retryWrites=true&w=majority'
#   client = MongoClient(connectionString)
#   dic = {}
#   val = str(request.args['query'])
#   answer = str(val)
#   dic['query'] = answer
#   dic['client'] = client
#   return dic


# if __name__ == '__main__':
# app.run()
