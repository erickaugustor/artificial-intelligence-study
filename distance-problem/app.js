const Graph = require('./structs/graph');

const { readTXTFile } = require('./services/input_read');
const { transformStringInGraph } = require('./services/graph_builder');

const graph = new Graph();

const inputCities = readTXTFile('file-01');

transformStringInGraph(inputCities, graph);