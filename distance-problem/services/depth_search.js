const R = require('ramda');
const Queue = require('../structs/queue');

const queueRoutes = new Queue();

const calcByDepthSearch = (grapMapInfo) => {
  console.log('grapMap ', grapMapInfo, '\n');
  const initialCity = 'Cidade1';
  const finalCity = 'Cidade4';

  const totalCities = grapMapInfo.vertices.length;
  const citiesInMap = grapMapInfo.vertices;

  const neighbourOfInitialCity = grapMapInfo.adjList.get(initialCity);
  console.log('neighbourOfInitialCity ', neighbourOfInitialCity, '\n');

  const routeFounded = [];
  let isRouteFounded = false;
  
  const pushNeighofNeigh = city => queueRoutes.pushRoute({ route: [city], citiesInRoute: [initialCity, city.neighbour] });
  R.forEach(pushNeighofNeigh, neighbourOfInitialCity);

  console.log('queueRoutes', JSON.stringify(queueRoutes));

  while(!isRouteFounded && !queueRoutes.isEmpty()) {
    const routeBeingTested = queueRoutes.popRoute();
    console.log('routeBeingTested ', routeBeingTested, '\n');
    const positionOfLastCityInRoute = routeBeingTested.route.length - 1;

    const lastCityOfTryRoute = routeBeingTested.route[positionOfLastCityInRoute];
    console.log('lastCityOfTryRoute ', lastCityOfTryRoute, '\n');

    const tryingCity = lastCityOfTryRoute.neighbour;

    console.log('tryingCity', JSON.stringify(tryingCity));

    const isDestiny = tryingCity === finalCity;

    if (isDestiny) {
      return routeBeingTested;
    } else {
      const nextTryRoutes = grapMapInfo.adjList.get(tryingCity);
      console.log('nextTryRoutes', JSON.stringify(nextTryRoutes));

      console.log('routeBeingTested ', JSON.stringify(routeBeingTested), '\n');

      // const isEqualToTheOldCity = cityInformation => R.find(cityInformation.neighbour)(routeBeingTested.citiesInRoute);
      // R.forEach()

      nextTryRoutes.forEach(route => {
        console.log(route.neighbour);
        console.log(routeBeingTested.citiesInRoute);

        const isEqualToTheOldCityinThisRoute = routeBeingTested.citiesInRoute.find(city => city === route.neighbour);

        console.log('isEqualToTheOldCityinThisRoute ', isEqualToTheOldCityinThisRoute);

        if (!Boolean(isEqualToTheOldCityinThisRoute)) {
          const newValidRoute = [];
          const newValidCitiesInRoute = [];

          newValidRoute.push(...routeBeingTested.route, route);
          newValidCitiesInRoute.push(...routeBeingTested.citiesInRoute, route.neighbour);
  
          queueRoutes.pushRoute({ route: newValidRoute, citiesInRoute: newValidCitiesInRoute });
        }
      });

    }
    console.log('\n', JSON.stringify(queueRoutes))
    console.log('\n END OF WHILEEEEEE \n');
  }
  
  return "Route not founded!";
};

module.exports = {
  calcByDepthSearch,
};