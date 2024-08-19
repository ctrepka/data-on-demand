## get dataset from data.geographic.gov for statewide address points and extract
wget -O address_points_2024.zip https://data.tnris.org/6d9c4a2e-b5bb-49b3-9ceb-0727f4711c5b/resources/stratmap24-addresspoints_48_ap.zip

unzip address_points_2024.zip

ls -la

sleep 5

ogr2ogr /data/stratmap24-addresspoints_48.parquet /data/stratmap24-addresspoints_48.gdb

duckdb -c "INSTALL spatial; LOAD spatial; SELECT geom FROM '/data/stratmap24-addresspoints_48.parquet LIMIT 24;" >> result.txt