// FILE: routes/chat.js

const express = require('express');
const router = express.Router();

// Import the authentication middleware to protect the route
const authMiddleware = require('../middleware/authMiddleware');

const { handleChatMessage } = require('../controllers/chatController');


router.post('/', authMiddleware, handleChatMessage);


module.exports = router;