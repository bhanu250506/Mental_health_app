const { parse } = require("dotenv");

const positiveWords = ['good', 'great', 'awesome', 'happy', 'joy', 'love', 'excellent', 'fantastic', 'amazing', 'well'];
const negativeWords = ['bad', 'sad', 'terrible', 'awful', 'lonely', 'depressed', 'angry', 'hate', 'overwhelmed', 'anxious', 'not good'];

class CustomSentimentAnalyzer{
    analyze(text){
        const words = text.toLowerCase().match(/\b\w+\b/g) || [];
        if (words.length === 0) return { score: 0, magnitude: 0 };

        const posCount = words.filter(word => positiveWords.includes(word)).length;
        const negCount = words.filter(word => negativeWords.includes(word)).length;

        const totalWords = words.length;
        const score = (posCount - negCount)/ totalWords;
        const magnitude = (posCount + negCount)/ totalWords;

        return {score : parseFloat(score.toFixed(2)), magnitude : parseFloat(magnitude.toFixed(2))};


    }
}

module.exports = {CustomSentimentAnalyzer};