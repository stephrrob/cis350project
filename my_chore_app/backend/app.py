from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson import ObjectId
import json

app = Flask(__name__)
app.config['MONGO_URI'] = 'mongodb+srv://robinss3:2601pbnjMONGO@choremate-prod-cluster.zxtvu9f.mongodb.net/?retryWrites=true&w=majority'  # Replace with your MongoDB URI
mongo = PyMongo(app)

# Define a route handler for the root path
@app.route('/')
def index():
    return 'Welcome to ChoreMate!'

# Route to create a new chore
@app.route('/chore', methods=['POST'])
def create_chore():
    data = request.get_json()
    chore_name = data.get('choreName')
    assigned_to = data.get('assignedTo')

    if chore_name and assigned_to:
        chore_id = mongo.db.chores.insert_one({
            'choreName': chore_name,
            'assignedTo': assigned_to,
            'completed': False
        })
        return jsonify({'message': 'Chore created successfully', 'choreId': str(chore_id.inserted_id)}), 201
    else:
        return jsonify({'error': 'Chore name and assigned to are required'}), 400

# Route to get all chores
@app.route('/chores', methods=['GET'])
def get_chores():
    chores = list(mongo.db.chores.find())
    return jsonify(chores), 200

# Route to update the completion status of a chore
@app.route('/chore/<chore_id>', methods=['PUT'])
def update_chore(chore_id):
    data = request.get_json()
    completed = data.get('completed')

    if completed is not None:
        result = mongo.db.chores.update_one(
            {'_id': ObjectId(chore_id)},
            {'$set': {'completed': completed}}
        )

        if result.modified_count == 1:
            return jsonify({'message': 'Chore updated successfully'}), 200
        else:
            return jsonify({'error': 'Chore not found'}), 404
    else:
        return jsonify({'error': 'Completed field is required'}), 400

if __name__ == '__main__':
    app.run(debug=True)
