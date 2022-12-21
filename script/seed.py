from flask import Flask
import sqlite3


app = Flask(__name__)


def init():
    """
    Used to seed the petazon database with seed data from schema.sql
    """

    sql_script = None

    with open("./script/schema.sql", "r") as sql_file:
        sql_script = sql_file.read()

    db = sqlite3.connect("petazon.db")
    cursor = db.cursor()
    cursor.executescript(sql_script)

    db.commit()
    db.close()


init()
