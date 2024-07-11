const fs = require('fs');
const path = require('path');

// Directory to read files from
const directoryPath = path.join(__dirname, 'your-directory-name');

// Output JSON file path
const outputFilePath = path.join(__dirname, 'output.json');

// Function to read files from the directory and create JSON object
function createJsonFromFiles(directoryPath) {
    const files = fs.readdirSync(directoryPath);
    const jsonObject = {};

    files.forEach(file => {
        const fileName = path.parse(file).name; // Get file name without extension
        jsonObject[fileName] = "";
    });

    return jsonObject;
}

// Function to write JSON object to file
function writeJsonToFile(jsonObject, outputFilePath) {
    const jsonContent = JSON.stringify(jsonObject, null, 2);

    fs.writeFileSync(outputFilePath, jsonContent, 'utf8', (err) => {
        if (err) {
            console.log('Error writing JSON to file', err);
        } else {
            console.log('JSON file has been saved.');
        }
    });
}

// Create JSON object from files
const jsonObject = createJsonFromFiles(directoryPath);

// Write JSON object to file
writeJsonToFile(jsonObject, outputFilePath);

console.log('JSON object created:', jsonObject);
