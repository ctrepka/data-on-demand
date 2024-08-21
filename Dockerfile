FROM ghcr.io/osgeo/gdal:latest

COPY ./frontend /frontend

RUN echo $(ogrinfo --version)

RUN wget https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip

RUN unzip duckdb_cli-linux-amd64.zip

RUN ls -la && mv duckdb /usr/bin/duckdb && duckdb --version

## get dataset from data.geographic.gov for statewide address points and extract
RUN wget -O /data/address_points_2024.zip https://data.tnris.org/6d9c4a2e-b5bb-49b3-9ceb-0727f4711c5b/resources/stratmap24-addresspoints_48_ap.zip

RUN unzip /data/address_points_2024.zip -d /data

RUN ls -la /data && sleep 5

RUN ogr2ogr /data/stratmap24-addresspoints_48.parquet /data/stratmap24-addresspoints_48.gdb

RUN duckdb -c "INSTALL spatial; LOAD spatial; SELECT ST_GeomFromWKB(SHAPE) FROM '/data/stratmap24-addresspoints_48.parquet' LIMIT 24;" >> result.txt

RUN mv /data/stratmap24-addresspoints_48.parquet

EXPOSE 5173