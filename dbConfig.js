import mysql from "mysql";

const createDBConnection = () => {
  const dbConfig = {
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "sethnl99",
    database: process.env.DB_NAME || "errandcatcher",
  };

  const connection = mysql.createConnection(dbConfig);

  connection.connect((err) => {
    if (err) {
      console.error("Error connecting to database:", err);
      return;
    }
    console.log("Connected to MySQL database");
  });

  return connection;
};

export default createDBConnection;
