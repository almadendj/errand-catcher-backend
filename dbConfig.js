import mysql from "mysql";

const createDBConnection = () => {
  const dbConfig = {
    host: "localhost",
    user: "root",
    password: "sethnl99",
    database: "errandcatcher",
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
