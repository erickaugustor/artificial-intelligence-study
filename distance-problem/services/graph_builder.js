const R = require('ramda');

const splitSemicolon = fileName => R.split(';', fileName);
const splitComma = fileName => R.split(',', fileName);

const transformStringInGraph = (text, graph) => {
  const arrayRoutes = splitSemicolon(text);
  
  arrayRoutes.forEach(route => {
    const splitedRoute = splitComma(route);
    
    if (splitedRoute.length === 2) {
      graph.addEdge(splitedRoute[0], splitedRoute[1], 0);
      graph.addEdge(splitedRoute[1], splitedRoute[0], 0);
    }

    if (splitedRoute.length === 1 && splitedRoute[0] !== '') {
      // console.log(splitedRoute);
    }
  });

  return graph;
}

module.exports = {
  transformStringInGraph,
};