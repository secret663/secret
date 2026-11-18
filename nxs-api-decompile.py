# api_server.py — pip install flask
import os
import hashlib
import sqlite3
import subprocess
import tempfile
from flask import Flask, request, jsonify

app = Flask(__name__)
DB_FILE = 'decompile_cache.db'

def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    # Gumawa ng table para sa cache
    c.execute('''CREATE TABLE IF NOT EXISTS cache
                 (hash TEXT PRIMARY KEY, pyc_data BLOB, py_data TEXT)''')
    conn.commit()
    conn.close()

init_db()

@app.route('/api/decompile', methods=['POST'])
def decompile():
    if 'file' not in request.files:
        return jsonify({"error": "No file provided"}), 400

    file = request.files['file']
    file_bytes = file.read()
    
    # Gumawa ng hash para malaman kung na-decompile na natin ito dati
    file_hash = hashlib.sha256(file_bytes).hexdigest()

    # 1. Hanapin sa Database (Cache)
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT py_data FROM cache WHERE hash=?", (file_hash,))
    row = c.fetchone()
    
    if row:
        conn.close()
        return jsonify({"source": row[0], "cached": True})

    # 2. Kung wala sa database, i-decompile gamit ang pycdc (dapat naka-install ito sa server)
    with tempfile.TemporaryDirectory() as temp_dir:
        pyc_path = os.path.join(temp_dir, "target.pyc")
        with open(pyc_path, 'wb') as f:
            f.write(file_bytes)

        try:
            res = subprocess.run(["pycdc", pyc_path], capture_output=True, text=True, timeout=60)
            if res.returncode == 0 and res.stdout.strip():
                source = res.stdout
                
                # 3. I-save sa Database para sa susunod na request
                c.execute("INSERT INTO cache (hash, pyc_data, py_data) VALUES (?, ?, ?)", 
                          (file_hash, file_bytes, source))
                conn.commit()
                conn.close()
                
                return jsonify({"source": source, "cached": False})
        except Exception as e:
            pass

    conn.close()
    return jsonify({"error": "Decompilation failed"}), 500

if __name__ == '__main__':
    # Ang Render ay gumagamit ng PORT env variable
    port = int(os.environ.get('PORT', 10000))
    app.run(host='0.0.0.0', port=port)