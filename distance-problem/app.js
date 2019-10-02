const Graph = require('./structs/graph');

const { readTXTFile } = require('./services/input_read');
const { transformStringInGraph } = require('./services/graph_builder');

const { calcByDepthSearch } = require('./services/depth_search');
const { calcByBreadthSearch } = require('./services/breadth_search');
const { calcByHeuristicSearch } = require('./services/heuristic_search');

const graph = new Graph();

const inputCities = readTXTFile('file-01');

const graphMapInfo = transformStringInGraph(inputCities, graph);
console.log('Graph structure: ', graphMapInfo);

console.log('Result: ', calcByDepthSearch(graphMapInfo));
console.log('Result: ', calcByBreadthSearch(graphMapInfo));
console.log('Result: ', calcByHeuristicSearch(graphMapInfo));
