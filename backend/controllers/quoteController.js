const Quote = require('../models/Quote');
const User = require('../models/User');
const mongoose = require('mongoose');



exports.getAllQuotes = async(req, res) => {
    try{
        const quotes = await Quote.find();
        res.json(quotes);
    } catch(err){
        console.error(err.message);
        res.status(500).send('Server Error');
    }
};

exports.saveQuote = async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    const quoteId = req.params.quoteId.trim(); // Remove whitespace

    // ✅ Check if quoteId is a valid ObjectId
    if (!mongoose.Types.ObjectId.isValid(quoteId)) {
      return res.status(400).json({ error: 'Invalid Quote ID' });
    }

    // ✅ Check if quote exists
    const quote = await Quote.findById(quoteId);
    if (!quote) {
      return res.status(404).json({ error: 'Quote not found' });
    }

    if (!user.savedQuotes.includes(quoteId)) {
      user.savedQuotes.push(quoteId);
      await user.save();
    }

    res.json(user.savedQuotes);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};


exports.getSavedQuotes = async (req,res)=> {
    try{
        const user = await User.findById(req.user.id).populate('savedQuotes') 
;
        res.json(user.savedQuotes);
    } catch(err){
        console.error(err.message);
        res.status(500).send('Server Error');
    }
};
