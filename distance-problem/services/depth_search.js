const R = require('ramda');
const Queue = require('../structs/queue');

const queueRoutes = new Queue();

const calcByDepthSearch = (grapMapInfo) => {
  const initialCity = grapMapInfo.getOrigin();
  const finalCity = grapMapInfo.getDestiny();

  const neighbourOfInitialCity = grapMapInfo.adjList.get(initialCity);

  let isRouteFounded = false;
  
  const pushNeighofNeigh = city => queueRoutes.pushRoute({ route: [city], citiesInRoute: [initialCity, city.neighbour] });
  R.forEach(pushNeighofNeigh, neighbourOfInitialCity);

  while(!isRouteFounded && !queueRoutes.isEmpty()) {
    const routeBeingTested = queueRoutes.popRoute();

    const positionOfLastCityInRoute = routeBeingTested.route.length - 1;

    const lastCityOfTryRoute = routeBeingTested.route[positionOfLastCityInRoute];

    const tryingCity = lastCityOfTryRoute.neighbour;

    const isDestiny = tryingCity === finalCity;

    if (isDestiny) {
      return routeBeingTested;
    } else {
      const nextTryRoutes = grapMapInfo.adjList.get(tryingCity);
      nextTryRoutes.forEach(route => {
        const isEqualToTheOldCityinThisRoute = routeBeingTested.citiesInRoute.find(city => city === route.neighbour);

        if (!Boolean(isEqualToTheOldCityinThisRoute)) {
          const newValidRoute = [];
          const newValidCitiesInRoute = [];

          newValidRoute.push(...routeBeingTested.route, route);
          newValidCitiesInRoute.push(...routeBeingTested.citiesInRoute, route.neighbour);
  
          queueRoutes.pushRoute({ route: newValidRoute, citiesInRoute: newValidCitiesInRoute });
        }
      });

    }
  }
  
  return "Route not founded!";
};

module.exports = {
  calcByDepthSearch,
};