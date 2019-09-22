const R = require('ramda');

const splitSemicolon = fileName => R.split(';', fileName);
const splitComma = fileName => R.split(',', fileName);

const transformStringInGraph = (text, graph) => {
  const arrayRoutes = splitSemicolon(text);
  let countUniqueCities = 0;
  
  arrayRoutes.forEach(route => {
    const splitedRoute = splitComma(route);
    
    if (splitedRoute.length === 3) {
      graph.addEdge(splitedRoute[0], splitedRoute[1], parseInt(splitedRoute[2]));
      graph.addEdge(splitedRoute[1], splitedRoute[0], parseInt(splitedRoute[2]));
    }

    if (splitedRoute.length === 1 && splitedRoute[0] !== '') {
      countUniqueCities === 0 ? graph.addOrigin(splitedRoute[0]) : graph.addDestiny(splitedRoute[0]);
      countUniqueCities++;
    }
  });

  return graph;
}

module.exports = {
  transformStringInGraph,
};