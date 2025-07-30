const User = require('../models/User');
const bcrypt = require('bcryptjs'); 
const jwt = require('jsonwebtoken');


exports.signup = async (req, res) =>{
    const {email, password} = req.body;

    try{
        let user = await User.findOne({email});
        if(user){
            return res.status(400).json({msg : 'User already exists'});
        }
user = new User({ email, password }); 

        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(password, salt);

        await user.save();

        const payload = {user : {id : user.id}};
        const token = jwt.sign(payload, process.env.JWT_SECRET, {expiresIn : "30d"});

        res.status(201).json({
  token,
  user: {
    email: user.email,
    password: user.password // ⚠️ not recommended in production
  }
});
;
    }catch(err){
        console.error(err.message);
        res.status(500).json({msg : 'Server error'});
    }
};

exports.login = async(req, res) => {
    const {email, password} = req.body;
    try {
        let user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg : "Invalid credentials"});
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg : 'Invalid credentials'});
        }

        const payload = {user : {id : user.id}};
        const token = jwt.sign(payload, process.env.JWT_SECRET, {expiresIn : "30d"});

      //  res.json({token});

        res.json({
  token,
  user: {
    email: user.email,
    password: password // ⚠️ not recommended in production
  }
});

    } catch(err){
        console.error(err.message);
        res.status(500).send('Server Error');
    }
};