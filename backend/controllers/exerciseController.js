const Exercise = require('../models/Exercise');


exports.getAllExercises = async (req, res) => {
        console.log("🔍 /api/exercises endpoint hit");

    try {
        const exercises = await Exercise.find();
        res.json(exercises);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
};