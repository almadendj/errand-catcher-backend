const mysql = require('mysql');

const dbUrl = process.env.JAWSDB_URL || "mysql://root:sethnl99@localhost/errandcatcher";
const url = new URL(dbUrl);

const dbConfig = {
  host: url.hostname,
  user: url.username,
  password: url.password,
  database: url.pathname.replace('/', ''),
};

const connection = mysql.createConnection(dbConfig);

connection.connect((err) => {
  if (err) {
    console.error("Error connecting to database:", err);
    return;
  }
  console.log("Connected to MySQL database");
});

module.exports = connection;
