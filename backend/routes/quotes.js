const express = require('express');
const router = express.Router();
const authMiddleware = require("../middleware/authMiddleware");
const {getAllQuotes, saveQuote, getSavedQuotes} = require('../controllers/quoteController');


// access public 
router.get('/', getAllQuotes);

// saved a quotes to user profile
router.post('/save/:quoteId', authMiddleware, saveQuote);

// saved post get
router.get('/saved', authMiddleware, getSavedQuotes);

module.exports = router;