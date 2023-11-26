from flask import Flask, jsonify
import pymysql as pm
import json
from datetime import timedelta

app = Flask(__name__)

# Custom encoder to handle timedelta objects
class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, timedelta):
            return str(obj)
        # Let the base class default method raise the TypeError
        return json.JSONEncoder.default(self, obj)

app.json_encoder = CustomJSONEncoder

def connect_db():
    try:
        connection = pm.connect(host='localhost',
                                user='root',
                                password='Root123!',
                                db='EventBuzz',
                                charset='utf8mb4',
                                cursorclass=pm.cursors.DictCursor)
        return connection
    except pm.Error as e:
        print(f"Error connecting to the database: {e}")
        return None

@app.route('/GetEvents')
def get_events():
    conn = connect_db()
    if conn is None:
        return jsonify({"status": "Failed to connect to the database"}), 500
    else:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM EventBuzz.Events")
            result = cursor.fetchall()

            # Convert the result set to a JSON serializable format
            events = []
            for row in result:
                event = {key: str(value) if isinstance(value, timedelta) else value for key, value in row.items()}
                events.append(event)

            return jsonify(events)
        finally:
            conn.close()

@app.route('/CheckDBConnection')
def check_db_connection():
    conn = connect_db()
    if conn is None:
        return jsonify({"status": "Failed to connect to the database"}), 500
    else:
        conn.close()
        return jsonify({"status": "Successfully connected to the database"}), 200

if __name__ == '__main__':
    app.run(debug=True)
