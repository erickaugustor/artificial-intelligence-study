const R = require('ramda');
const Stack = require('../structs/stack');

const stackRoutes = new Stack();

const calcByBreadthSearch = (grapMapInfo) => {
  const initialCity = grapMapInfo.getOrigin();
  const finalCity = grapMapInfo.getDestiny();

  const neighbourOfInitialCity = grapMapInfo.adjList.get(initialCity);

  let isRouteFounded = false;

  const pushNeighofFirstCity = route => stackRoutes.pushRoute({ route: [route], citiesInRoute: [initialCity, route.neighbour] });
  R.forEach(pushNeighofFirstCity, neighbourOfInitialCity);

  while(!isRouteFounded && !stackRoutes.isEmpty()) {
    const routeBeingTested = stackRoutes.popRoute();

    const positionOfLastCityInRoute = routeBeingTested.route.length - 1;

    const lastCityOfTryRoute = routeBeingTested.route[positionOfLastCityInRoute];

    const tryingCity = lastCityOfTryRoute.neighbour;

    const isDestiny = tryingCity === finalCity;

    if (isDestiny) {
      isRouteFounded = true;
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
  
          stackRoutes.pushRoute({ route: newValidRoute, citiesInRoute: newValidCitiesInRoute });
        }
      });

    }
  }
  
  return "Route not founded!";
};

module.exports = {
  calcByBreadthSearch,
};