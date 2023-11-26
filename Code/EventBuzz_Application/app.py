from flask import Flask, jsonify
import pymysql as pm

app = Flask(__name__)

def connect_db():
    return pm.connect(host='localhost',
                      user='root',
                      password='Root123!',
                      db='EventBuzz',
                      charset='utf8mb4',
                      cursorclass=pm.cursors.DictCursor)

@app.route('/Events')
def get_events():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            cursor.execute("SELECT * FROM Events")
            events = cursor.fetchall()
            return jsonify(events)
    except pm.Error as e:
        print(f"Database Error: {e}")
        return jsonify({"error": "Database error occurred"}), 500
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
