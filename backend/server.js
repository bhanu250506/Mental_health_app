const express = require('express');
const connectDB = require('./config/db');
const dotenv = require('dotenv');
const cors = require('cors');


const app = express();
dotenv.config();
connectDB();
app.use(express.json());
app.use(cors());  // ✅ Call the function

app.use('/api/auth', require('./routes/auth'));
app.use('/api/quotes', require('./routes/quotes'));
app.use('/api/chat', require('./routes/chat'));
app.use('/api/moods', require('./routes/moods'));
app.use('/api/exercises', require('./routes/exercises'));

app.get('/', (req, res)=>{
    res.send("AI MENTAL HEALTH BACKEND IS RUNNING");
});


const PORT = process.env.PORT || 5000;

app.listen(PORT, ()=> console.log(`SERVER RUNNING AT PORT ${PORT}`))

