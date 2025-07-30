const mongoose = require('mongoose');

 const ConversationSchema = new mongoose.Schema({
    userId : {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'User',
        required : true,
        index : true
    },

    messages : [
        {
            sender : {
                type : String,
                enum : ['user', 'bot'],
                required : true
            },
            text : {
                type : String,
                required : true
            },
            timeStamp : {
                type : Date,
                default : Date.now
            },
            sentiment : {
                score : {type : Number},
                magnitude : {type : Number}
            }
        }
    ]
 }, {timestamps : true});

 module.exports = mongoose.model('Conversation', ConversationSchema);