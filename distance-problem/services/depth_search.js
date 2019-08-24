const R = require('ramda');
const Queue = require('../structs/queue');

const queueRoutes = new Queue();

const calcByDepthSearch = (grapMapInfo) => {
  const initialCity = 'Cidade1';
  const finalCity = 'Cidade4';

  const totalCities = grapMapInfo.vertices.length;
  const cities = grapMapInfo.vertices;

  let routeFounded = false;

  const neighbourCities = grapMapInfo.adjList.get(initialCity);
  console.log(neighbourCities);
  
  const pushNeighofNeigh = city => queueRoutes.pushRoute([city]);
  R.forEach(pushNeighofNeigh, neighbourCities);
  
  console.log('queueRoutes', queueRoutes);
  console.log(queueRoutes.isEmpty());

  while(!routeFounded && !queueRoutes.isEmpty()) {
    const tryRoute = queueRoutes.popRoute();
    const positionOfLastCityInRoute = tryRoute.length - 1;

    console.log(tryRoute);;

    const lastCityOfTryRoute = tryRoute[positionOfLastCityInRoute];
    console.log('aaaaa', lastCityOfTryRoute);
    const tryingCity = lastCityOfTryRoute.neighbour;

    const isDestiny = tryingCity === finalCity;

    if (!isDestiny) {
      const nextRoutes = grapMapInfo.adjList.get(tryingCity);

      if (nextRoutes.length > 1) {

        console.log(' ----- ', queueRoutes);
        /*
        const a = neighbourRoute => {
          
        }

        R.forEach(, nextRoutes);
        */

      } else {
        const finalRoute = [];
        finalRoute.push(...tryRoute, nextRoutes[0].vizinho);

        queueRoutes.pushRoute(finalRoute);
      }
    } else {
      return tryRoute;
    }

    console.log('tryRoute', tryRoute);

  };
};

module.exports = {
  calcByDepthSearch,
};