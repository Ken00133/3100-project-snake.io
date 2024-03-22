const express = require('express')
const cors = require('cors')
const app = express()
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const User = require('./userProfile');
const bodyParser = require('body-parser');
//const saltRounds = 10; // For bcrypt
// mongoose.connect('mongodb://127.0.0.1:27017/3100_project_db') // put your own database link here

// const db = mongoose.connection;
// // Upon connection failure
// db.on('error', console.error.bind(console, 'Connection error:'));
// // Upon opening the database successfully

const { Client } = require('pg');
 
const client = new Client({ user: 'postgres', host: 'localhost', database: 'postgres', password: 'csci3100', port: '5432', });
client.connect() .then(() => { console.log('Connected to PostgreSQL database!'); }) .catch((err) => { console.error('Error connecting to the database:', err); });

client.once('open', function () {
    console.log("Connection is open...");

	const corsOptions = {
		origin: "http://localhost:3000",
		credentials: true,
	}

    app.use(bodyParser.urlencoded({extended: false}));
    app.use(bodyParser.json());
	app.use(cors(corsOptions))


    //Event list handle
    app.post('/register', async (req, res) => {

        const { username, password, highScore = 0, highestLength = 0, highestNumberOfKills = 0, masterVolume = 1, soundEffectVolume = 1, snakeSkin = 4, achievement = '{f, f, f}', backgroundTheme = 2 } = req.body;
      
        // Hash the password
        //const hashedPassword = await bcrypt.hash(password, saltRounds);
      
        // SQL query to insert the new user
        const query = `
          INSERT INTO user_profile
          (high_score, highest_length, highest_number_of_kills, master_volume, sound_effect_volume, password, snake_skin, username, achievement, background_theme)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
        `;
      
        const values = [highScore, highestLength, highestNumberOfKills, masterVolume, soundEffectVolume, password, snakeSkin, username, achievement, backgroundTheme];
      
        // Execute the query
        client.query(query, values)
          .then(() => res.status(200).send('User registered successfully'))
          .catch((err) => {
            console.error('Error inserting data into database:', err);
            res.status(500).send('Error registering user');
          });
        });
        const verifyUserQuery = `SELECT * FROM user_profile WHERE username = $1`;
        client.query(verifyUserQuery, [username])
            .then(queryRes => {
            if (queryRes.rows.length > 0) {
                // User exists, send a success message
                res.status(200).json({ message: "User registered successfully", user: queryRes.rows[0] });
            } else {
                // User was not found after insertion, something went wrong
                res.status(500).json({ message: "User registration failed" });
            }
            })
            .catch(err => {
                console.error('Error verifying user in database:', err);
                res.status(500).json({ message: "Error during registration process" });
            });

    // requestssss...

    
    // handle ALL requests with Hello World
    app.all('/*', (req, res) => {
        res.send('Hello World!');
    });

})
// listen to port 4000
const server = app.listen(4000);
