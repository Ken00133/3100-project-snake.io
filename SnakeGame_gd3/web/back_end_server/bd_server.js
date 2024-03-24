const express = require('express')
const cors = require('cors')
const app = express()
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
// const User = require('./userProfile');
// const bodyParser = require('body-parser');
//const saltRounds = 10; // For bcrypt
// mongoose.connect('mongodb://127.0.0.1:27017/3100_project_db') // put your own database link here

// const db = mongoose.connection;
// // Upon connection failure
// db.on('error', console.error.bind(console, 'Connection error:'));
// // Upon opening the database successfully

// Configure CORS
app.use(cors({
origin: 'http://localhost:3000',
credentials: true,
}));
// Body parsing middleware setup
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
const { Client } = require('pg');
 
const client = new Client({ user: 'postgres', host: 'localhost', database: 'postgres', password: 'csci3100', port: '5432', });
client.connect() .then(() => { console.log('Connected to PostgreSQL database!');

    //Event list handle
    // Query to select all data from the 'user_profile' table
    // const query = 'SELECT * FROM user_profile;';
    // client.query(query)
    //     .then(res => {
    //         console.log("Data from 'user_profile' table:");
    //         console.log(res.rows); // This will print the rows fetched from the table
    //     })
    //     .catch(err => {
    //         console.error('Error executing query:', err.stack);
    //     });
    
    app.get('/api/usernames', async (req, res) => {
        try {
            const result = await client.query('SELECT username FROM user_profile');
            const usernames = result.rows.map(row => row.username);
            res.json(usernames);
        } catch (err) {
            console.error('Error fetching usernames:', err);
            res.status(500).json({ message: "Error fetching usernames" });
        }
    });

    app.post('/api/register', async (req, res) => {
        const {
          username,
          password, 
          high_score,
          highest_length,
          highest_number_of_kills,
          master_volume,
          sound_effect_volume,
          snake_skin,
          achievement,
          background_theme,
        } = req.body;
        
            // Validation for empty username or password
        if (!username.trim() || !password.trim()) {
            return res.status(400).json({ message: "Username and password are required" });
        }
        const hashedPassword = await bcrypt.hash(password, 12);
        
        const query = `
          INSERT INTO user_profile
          (username, password, high_score, highest_length, highest_number_of_kills, master_volume, sound_effect_volume, snake_skin, achievement, background_theme)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
        `;
    
        const values = [username, hashedPassword, high_score, highest_length, highest_number_of_kills, master_volume, sound_effect_volume, snake_skin, achievement, background_theme];
    
        try {
            await client.query(query, values);
            res.status(200).json({ message: "User registered successfully" });
        } catch (err) {
            console.error('Error inserting data into database:', err);
            res.status(500).json({ message: "Error registering user" });
        }
    });

    app.post('/api/login', async (req, res) => {
        const { username, password } = req.body;
        
        if (!username.trim() || !password.trim()) {
            return res.status(400).json({ message: "Username and password are required" });
        }
        
        const query = 'SELECT * FROM user_profile WHERE username = $1';
      
        try {
          const result = await client.query(query, [username]);
      
          if (result.rows.length > 0) {
            const user = result.rows[0];
      
            // Check if the password matches
            const match = await bcrypt.compare(password, user.password);
      
            if (match) {
              // Passwords match
              return res.status(200).json({ message: "Login successful" });
            } else {
              // Passwords do not match
              return res.status(401).json({ message: "Invalid username or password" });
            }
          } else {
            // No user found with that username
            return res.status(401).json({ message: "Invalid username or password" });
          }
        } catch (err) {
          console.error('Error during login:', err);
          res.status(500).json({ message: "Error during login process" });
        }
      });
    // requestssss...

    
    // handle ALL requests with Hello World
    app.all('/*', (req, res) => {
        res.send('Hello World!');
    });

    // listen to port 4000
    const server = app.listen(4000);
})

.catch((err) => {
    console.error('Error connecting to the database:', err);
  });