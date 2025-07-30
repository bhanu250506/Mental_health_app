const Mood = require('../models/Mood');

exports.addMood = async(req, res) => {
    const {mood, date} = req.body;
    const userId = req.user.id;

    try {
        const newMood = new Mood({userId, mood, date : new Date(date) });
        await newMood.save();
        res.status(201).json(newMood);
        
    } catch (error) {
         console.error(err.message);
        res.status(500).send('Server Error');
        
    }
};

exports.getMoods = async (req, res) => {
    try {
        const moods = await Mood.find({userId : req.user.id}).sort({date: -1 });
                res.json(moods);

        
    } catch (error) {
        console.error(err.message);
        res.status(500).send('Server Error');
        
    }
}