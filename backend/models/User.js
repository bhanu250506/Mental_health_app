const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    email : {
        type : String,
        required : true,
        unique : true,
        match: [/.+\@.+\..+/, 'Please fill a valid email address']
    },

    password : {
        type : String,
        required : true,
    },
    savedQuotes : [
        {
            type : mongoose.Schema.Types.ObjectId,
            ref : 'Quote'
        }
    ]
}, {timestamps : true});

module.exports = mongoose.model('User', UserSchema);