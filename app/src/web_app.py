from flask import Flask, render_template, redirect
import os

app = Flask(__name__, template_folder=os.path.join(os.path.dirname(__file__), '..', 'templates'))

@app.route('/')
def index():
    return render_template('index.html')

@app.route("/part1")
def serve_tableau():
    return render_template('part1.html')

@app.route("/part2")
def redirect_to_jupyter():
    return redirect(f"http://localhost:{os.getenv('JUPYTER_PORT', '8888')}/lab/tree/work/part2.ipynb", code=302)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=int(os.getenv("FLASK_PORT", 4444)), debug=True)
