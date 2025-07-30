const Exercise = require('../models/Exercise');

async function buildChatPrompt(message, sentimentScore){
    let exerciseSuggestion ='';
    //if user sentiments is -ve fetch a relevant exercise to improve mood
    if(sentimentScore < -0.1){
        const exercise = await Exercise.findOne({category : 'Mindfulness'}); // Example logic
        if(exercise){
            exerciseSuggestion = `\n\nAs a gentle suggestion, you might find this helpful later:
                        **${exercise.title}**: ${exercise.description}`;

        }
    }

     // The core prompt for Gemini
    const prompt = `You are a compassionate AI assistant named Aura. Your goal is to listen and provide comfort.
    NEVER give medical advice. Always suggest users consult a professional for diagnosis.

    RULES:
    1.  **CRISIS DETECTION (MOST IMPORTANT):** If the user's message indicates self-harm or severe crisis (e.g., "I want to die"), your ONLY response MUST be: "CRISIS: It sounds like you are in significant distress. Please know that help is available. You can contact a crisis hotline immediately. You are not alone."
    2.  For all other messages, provide a short, empathetic, and supportive response (2-3 sentences).
    3.  Validate their feelings. Do not be overly cheerful if they are sad.
    
    User's message: "${message}"

    Your response:`;

    return prompt + exerciseSuggestion;
}

module.exports = { buildChatPrompt };
