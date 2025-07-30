const mongoose = require('mongoose');
const Quote = require('../models/Quote');
const Exercise = require('../models/Exercise');

const connectDB = async () => {
    try {
        await mongoose.connect(process.env.MONGO_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('✅ MongoDB Connected');
        await seedQuotes();
        await seedExercises(); // ✅ Add this

    } catch (error) {
        console.error('❌ MongoDB Connection Error:', error.message);
        process.exit(1);
    }
};

// 🔁 Quote Seeder (Clears and inserts all 30)
const seedQuotes = async () => {
    try {
        await Quote.deleteMany(); // Clear existing quotes

        const quotes = [
            { text: "The only way to do great work is to love what you do.", author: "Steve Jobs" },
            { text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt" },
            { text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt" },
            { text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius" },
            { text: "The sun is a daily reminder that we too can rise again from the darkness, that we too can shine our own light.", author: "S. Ajna" },
            { text: "You are braver than you believe, stronger than you seem, and smarter than you think.", author: "A.A. Milne" },
            { text: "It is never too late to be what you might have been.", author: "George Eliot" },
            { text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill" },
            { text: "Your time is limited, so don’t waste it living someone else’s life.", author: "Steve Jobs" },
            { text: "Hardships often prepare ordinary people for an extraordinary destiny.", author: "C.S. Lewis" },
            { text: "Happiness can be found even in the darkest of times if one only remembers to turn on the light.", author: "Albus Dumbledore" },
            { text: "Act as if what you do makes a difference. It does.", author: "William James" },
            { text: "You miss 100% of the shots you don’t take.", author: "Wayne Gretzky" },
            { text: "Keep your face always toward the sunshine—and shadows will fall behind you.", author: "Walt Whitman" },
            { text: "The best way to predict the future is to create it.", author: "Peter Drucker" },
            { text: "Do what you can, with what you have, where you are.", author: "Theodore Roosevelt" },
            { text: "What lies behind us and what lies before us are tiny matters compared to what lies within us.", author: "Ralph Waldo Emerson" },
            { text: "The mind is everything. What you think you become.", author: "Buddha" },
            { text: "Don’t watch the clock; do what it does. Keep going.", author: "Sam Levenson" },
            { text: "The harder you work for something, the greater you'll feel when you achieve it.", author: "Unknown" },
            { text: "Push yourself, because no one else is going to do it for you.", author: "Unknown" },
            { text: "Great things never come from comfort zones.", author: "Unknown" },
            { text: "Dream bigger. Do bigger.", author: "Unknown" },
            { text: "Don’t stop when you’re tired. Stop when you’re done.", author: "Marilyn Monroe" },
            { text: "Wake up with determination. Go to bed with satisfaction.", author: "George Lorimer" },
            { text: "Little things make big days.", author: "Isabel Marant" },
            { text: "It's going to be hard, but hard does not mean impossible.", author: "Art Williams" },
            { text: "Don’t wait for opportunity. Create it.", author: "George Bernard Shaw" },
            { text: "Sometimes later becomes never. Do it now.", author: "Unknown" },
            { text: "Success doesn’t just find you. You have to go out and get it.", author: "T. Harv Eker" }
        ];

        await Quote.insertMany(quotes);
        console.log("✅ Quotes seeded successfully");
    } catch (error) {
        console.error('❌ Seeding Error:', error.message);
    }
};

const seedExercises = async () => {
    try {
  await Exercise.deleteMany();         console.log('Seeding exercises...');

        const exercises = [
            // Breathing
            {
                title: "5-Minute Box Breathing",
                description: "Inhale for 4s, hold for 4s, exhale for 4s, hold for 4s. Repeat for 5 minutes to calm your nervous system.",
                category: "Breathing"
            },
            {
                title: "4-7-8 Breathing",
                description: "Breathe in for 4 seconds, hold for 7 seconds, and exhale slowly for 8 seconds. Great before bed.",
                category: "Breathing"
            },
            {
                title: "3 Deep Belly Breaths",
                description: "Place a hand on your belly. Inhale deeply through the nose, feeling your belly rise. Exhale slowly. Repeat 3 times.",
                category: "Breathing"
            },

            // Mindfulness
            {
                title: "Mindful Gratitude",
                description: "Write down three specific things you are grateful for today. This helps shift your focus to the positive.",
                category: "Mindfulness"
            },
            {
                title: "5 Senses Check-In",
                description: "Pause and notice: 5 things you see, 4 you feel, 3 you hear, 2 you smell, 1 you taste. Brings you to the present.",
                category: "Mindfulness"
            },
            {
                title: "1-Minute Awareness Pause",
                description: "Sit quietly and observe your breath and thoughts without judgment for just 1 minute. Builds inner calm.",
                category: "Mindfulness"
            },

            // Reflection
            {
                title: "Journaling: Name Your Feeling",
                description: "Write down what you're feeling right now and try to label it (e.g., 'anxious', 'lonely'). Naming helps tame.",
                category: "Reflection"
            },
            {
                title: "Stress Dump",
                description: "Write down everything on your mind without filtering. Get it all out on paper to reduce overwhelm.",
                category: "Reflection"
            },
            {
                title: "Self-Compassion Letter",
                description: "Write a kind, forgiving note to yourself as if you were a friend going through the same situation.",
                category: "Reflection"
            },

            // Daily Task
            {
                title: "Set One Small Goal",
                description: "Plan one small, achievable task for today or tomorrow. Completing it builds momentum and self-trust.",
                category: "Daily Task"
            },
            {
                title: "Tidy One Small Space",
                description: "Clean or organize a small area like your desk or drawer. A clear space often brings a clear mind.",
                category: "Daily Task"
            },
            {
                title: "Digital Detox Break",
                description: "Take a 30-minute break from all screens. Use the time to reflect, walk, or read a physical book.",
                category: "Daily Task"
            },

            // Movement
            {
                title: "Stretch for 5 Minutes",
                description: "Do a full-body stretch: neck, shoulders, arms, back, and legs. Releases tension and resets your body.",
                category: "Movement"
            },
            {
                title: "Take a Nature Walk",
                description: "Spend 10–15 minutes walking outside. Focus on the air, sounds, and colors around you. It clears the mind.",
                category: "Movement"
            },
            {
                title: "Mini Dance Break",
                description: "Put on your favorite upbeat song and move freely. Moving to music lifts mood and reduces stress.",
                category: "Movement"
            }
        ];

        await Exercise.insertMany(exercises);
        console.log('✅ Exercises seeded successfully.');
    } catch (error) {
        console.error('❌ Error seeding exercises:', error);
    }
};


module.exports = connectDB;
