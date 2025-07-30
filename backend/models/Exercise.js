const mongoose = require('mongoose');

const ExerciseSchema = new mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    category: {
        type: String,
        required: true,
        enum: ['Breathing', 'Mindfulness', 'Daily Task', 'Reflection', 'Movement'] // ✅ Fixed
    },
});

module.exports = mongoose.model('Exercise', ExerciseSchema);
