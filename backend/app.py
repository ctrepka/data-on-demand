from flask import Flask
from flask import request
import duckdb
import pandas as pd

app = Flask("duckdb_query")

""" @app.route("/duckdb")
def duckdb_query():
    query = request.args.get("sql")
    # fetch('localhost:5000/duckdb?query=...)
    # select * from 's3://txgio-copc-test/address_points_2024_county/*/*.parquet' WHERE County IN ('Midland', 'Upton');
    con = duckdb.connect()
    
    con.install_extension("spatial")
    con.load_extension("spatial")

    res = con.sql(f"{query}")
    res.show()
    return f"<p>{res}</p>"
"""

# TODO: describe table at s3 url
# @app.route("/data_dictionary"):


# TODO: preview data limiting to 25 results
# @app.route("/preview"):