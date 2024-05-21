const mongoose = require('mongoose');

// Define the schema
const dataSchema = new mongoose.Schema({
    'pname': {
        type: String,
        required: true
    },
    'pprice': {
        type: Number,
        required: true
    },
    'pdescription': {
        type: String,
        required: true
    }
});

// Create the model
const Product = mongoose.model("node_js", dataSchema);

module.exports = Product;
