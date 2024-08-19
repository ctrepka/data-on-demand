const duckdb = require("duckdb");
const db = new duckdb.Database(
  ":memory:",
  {
    access_mode: "READ_WRITE",
  },
  (err) => {
    if (err) {
      console.error(err);
    }
  }
);


// example query
db.all("SELECT 42 AS fortytwo", function (err, res) {
  if (err) {
    console.warn(err);
    return;
  }
  console.log(res[0].fortytwo);
});
