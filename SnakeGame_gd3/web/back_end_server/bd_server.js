const express = require('express')
const cors = require('cors')
const app = express()
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const User = require('./userProfile');
const bodyParser = require('body-parser');

mongoose.connect('mongodb://127.0.0.1:27017/3100_project_db') // put your own database link here
const db = mongoose.connection;
// Upon connection failure
db.on('error', console.error.bind(console, 'Connection error:'));
// Upon opening the database successfully
db.once('open', function () {
    console.log("Connection is open...");

	const corsOptions = {
		origin: "http://localhost:3000",
		credentials: true,
	}

    app.use(bodyParser.urlencoded({extended: false}));
    app.use(bodyParser.json());
	app.use(cors(corsOptions))

    //Event list handle
    app.get('/location/:venueid', (req, res) => {
        //TODO: some stuff
    });


    // requestssss...

    
    // handle ALL requests with Hello World
    app.all('/*', (req, res) => {
        res.send('Hello World!');
    });

})
// listen to port 4000
const server = app.listen(4000);
