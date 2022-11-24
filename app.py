import os

from flask import Flask, render_template
from flask_wtf.csrf import CSRFProtect


app = Flask(__name__)
csrf = CSRFProtect()
csrf.init_app(app)


@app.route('/')
def index():
    return render_template('index.html', envvar=os.environ.items() )

if __name__ == "__main__":
    app.run(host='0.0.0.0')
