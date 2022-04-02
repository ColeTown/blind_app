from flask import Flask,request,jsonify

app = Flask(__name__)

@app.route('/api',methods=['GET'])
def helloWorld():
   dic = {} 
   dic['Query'] = str(request.args['Query'])
   return jsonify(dic) 
 
if __name__ == '__main__':
    app.run()


