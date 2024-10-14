FROM postgis/postgis:17-3.4

RUN mkdir /duckdb-flask

WORKDIR /duckdb-flask

RUN python3 -m venv .venv
RUN bash .venv/bin/activate && pip install Flask

