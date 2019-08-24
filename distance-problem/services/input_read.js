const fs = require('fs');
const R = require('ramda');

const removeSpacesInText = text => R.replace(/ /g, '', text);
const removeNewLines = text => R.replace(/\r?\n|\r/g, '', text);

const readTXTFile = (fileName) => {
  try {
    const text = fs.readFileSync(__dirname + `\\inputs\\${fileName}.txt`, 'utf8');
    let finalText = removeSpacesInText(text.toString());
    finalText = removeNewLines(finalText);

    return finalText;
  } catch (e) {
    console.log('Error:', e.stack);
  };
};

module.exports = {
  readTXTFile,
}