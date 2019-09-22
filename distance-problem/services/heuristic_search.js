const R = require('ramda');
const Stack = require('../structs/stack');

const stackRoutes = new Stack();
const stackValidRoutes = new Stack();

const calcByHeuristicSearch = (grapMapInfo) => {
  const initialCity = grapMapInfo.getOrigin();
  const finalCity = grapMapInfo.getDestiny();

  const neighbourOfInitialCity = grapMapInfo.adjList.get(initialCity);

  // let isRouteFounded = false;

  const pushNeighofFirstCity = route => stackRoutes.pushRoute({ route: [route], citiesInRoute: [initialCity, route.neighbour], totalDistance: route.distance });
  R.forEach(pushNeighofFirstCity, neighbourOfInitialCity);

  while(/* !isRouteFounded && */ !stackRoutes.isEmpty()) {
    const routeBeingTested = stackRoutes.popRoute();

    const positionOfLastCityInRoute = routeBeingTested.route.length - 1;

    const lastCityOfTryRoute = routeBeingTested.route[positionOfLastCityInRoute];

    const tryingCity = lastCityOfTryRoute.neighbour;

    const isDestiny = tryingCity === finalCity;

    if (isDestiny) {
      isRouteFounded = true;
      stackValidRoutes.pushRoute(routeBeingTested);
    } else {
      const nextTryRoutes = grapMapInfo.adjList.get(tryingCity);

      const diffFunction = (a, b) => a.distance - b.distance;
      const nextTryRoutesSorted = R.sort(diffFunction, nextTryRoutes);

      nextTryRoutesSorted.forEach(route => {
        const isEqualToTheOldCityinThisRoute = routeBeingTested.citiesInRoute.find(city => city === route.neighbour);

        if (!Boolean(isEqualToTheOldCityinThisRoute)) {
          const newValidRoute = [];
          const newValidCitiesInRoute = [];
          const newValidDistanceOfRoute = routeBeingTested.totalDistance + route.distance;

          newValidRoute.push(...routeBeingTested.route, route);
          newValidCitiesInRoute.push(...routeBeingTested.citiesInRoute, route.neighbour);
  
          stackRoutes.pushRoute({ route: newValidRoute, citiesInRoute: newValidCitiesInRoute, totalDistance: newValidDistanceOfRoute });
        }
      });

    }
  }
  
  if (stackValidRoutes.routes.length > 0) {
    const diffFunction = (a, b) => a.totalDistance - b.totalDistance;
    const sortedValidRoutes = R.sort(diffFunction, stackValidRoutes.routes);

    return sortedValidRoutes[0];
  }

  return "Route not founded!";
};

module.exports = {
  calcByHeuristicSearch,
};