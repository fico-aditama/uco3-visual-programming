from flask import Flask, jsonify, request
from flask_cors import CORS
import sqlite3

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Create the example_table if it doesn't exist
def create_table():
    conn = sqlite3.connect('example.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS example_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
        )
    ''')
    conn.commit()
    conn.close()

@app.route('/api/data', methods=['POST'])
def save_data():
    try:
        data = request.json.get('data')  # Assuming the data is sent as JSON
        create_table()  # Ensure the table exists
        conn = sqlite3.connect('example.db')
        c = conn.cursor()
        c.execute('INSERT INTO example_table (data) VALUES (?)', (data,))
        conn.commit()
        conn.close()
        return jsonify({"message": "Data saved successfully"})
    except Exception as e:
        return jsonify({"error": str(e)})

@app.route('/api/data', methods=['GET'])
def get_data():
    try:
        create_table()  # Ensure the table exists
        conn = sqlite3.connect('devapp.db')
        c = conn.cursor()
        c.execute('SELECT * FROM devapp_table')
        data = c.fetchall()
        conn.close()
        return jsonify({"data": data})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    app.run(debug=True)
