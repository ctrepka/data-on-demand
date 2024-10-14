from flask import Flask
from flask import request
import duckdb
import pandas as pd

app = Flask("duckdb_query")

@app.route("/duckdb")
def duckdb_query():
    query = request.args.get("sql")

    # select * from 's3://txgio-copc-test/address_points_2024_county/*/*.parquet' WHERE County IN ('Midland', 'Upton');
    con = duckdb.connect()
    
    con.install_extension("spatial")
    con.load_extension("spatial")

    res = con.sql(f"{query}")
    res.show()
    return f"<p>{res}</p>"
