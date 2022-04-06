from flask import Flask,request,jsonify

app = Flask(__name__)

@app.route('/api',methods=['GET'])
def getOrd():
   dic = {} 
   val = str(request.args['query'])
   answer = str(val) 
   dic['query'] = answer
   return dic 
  
if __name__ == '__main__':
    app.run()


