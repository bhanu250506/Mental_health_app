const mongoose = require('mongoose');

const MoodSchema = new mongoose.Schema({
   userId : {
    type : mongoose.Schema.Types.ObjectId,
    ref : 'User',
    required : true,
    index : true
   } ,
   mood : {
    type : String,
    required : true,
    enum : ['Happy', 'Okay', 'Sad', 'Anxious', 'Angry']
   },
   date : {
    type : Date,
    required : true
   }
}, {timestamps : true});

module.exports = mongoose.model('Mood', MoodSchema);
