const { GoogleGenerativeAI } = require("@google/generative-ai");
const Conversation = require('../models/Conversation');
const  {CustomSentimentAnalyzer} = require('../utils/customAnalyzers');
const {buildChatPrompt} = require('../utils/promptBuilder');

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const sentimentAnalyzer = new CustomSentimentAnalyzer();

exports.handleChatMessage = async(req, res) => {
    const {message} = req.body;
    const userId = req.user.id;

    if(!message) return res.status(400).json({msg : 'Message is required'});

    try {
        // 1. Analyze sentiment locally
        const sentiment = sentimentAnalyzer.analyze(message);

        // 2. Build promt
        const prompt = await buildChatPrompt(message, sentiment.score);

        // call Gemini api
        const model = genAI.getGenerativeModel({model : "gemini-2.5-flash"});
        const result = await model.generateContent(prompt);
        const response = await result.response;
        let responseText = response.text();

         if (responseText.startsWith("CRISIS:")) {
            responseText = responseText.replace("CRISIS: ", "");
        }

        // Save professional converstion log
         await Conversation.findOneAndUpdate(
            { userId },
            {
                $push: {
                    messages: [
                        { sender: 'user', text: message, sentiment: sentiment },
                        { sender: 'bot', text: responseText }
                    ]
                }
            },
            { upsert: true, new: true, setDefaultsOnInsert: true }
        );

        res.json({ reply: responseText });


        
    } catch (error) {
        console.error('Chat Controller Error:', error);
        res.status(500).send('Error processing your message.');
        
    }
}