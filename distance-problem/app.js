const Graph = require('./structs/graph');

const { readTXTFile } = require('./services/input_read');
const { transformStringInGraph } = require('./services/graph_builder');
const { calcByDepthSearch } = require('./services/depth_search');

const graph = new Graph();

const inputCities = readTXTFile('file-01');

const graphMapInfo = transformStringInGraph(inputCities, graph);
calcByDepthSearch(graphMapInfo);


console.log('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', calcByDepthSearch(graphMapInfo));