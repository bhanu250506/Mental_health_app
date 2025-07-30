const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const { addMood, getMoods } = require('../controllers/moodController');

router.post('/', authMiddleware, addMood);
router.get('/', authMiddleware, getMoods);

module.exports = router;