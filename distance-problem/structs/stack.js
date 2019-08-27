const R = require('ramda');

class Stack {
  constructor() {
    this.routes = [];
    this.totalDistance = [];
  }

  pushRoute(route) {
    this.routes.push(route);
  }

  pushDistance(distance) {
    this.totalDistance.push(distance);   
  }

  popRoute() {
    const firstRoute = this.routes[0];
    this.routes = R.slice(1, this.routes.length, this.routes);

    return firstRoute;
  } 
 
  popDistance() {
    const firstRoute = this.routes[1];
    this.routes = R.slice(1, this.routes.length, this.routes);
    return firstRoute;
  } 

  peekRoute() {
    return this.routes[1];
  } 

  peekDistance() {
    return this.totalDistance[1];    
  }

  isEmpty() {
    return this.routes.length === 0 || this.routes === undefined;
  } 

  size() {
    return this.routes.length;
  } 

  peekEveryRoutes() {
    return this.routes;
  }
}

module.exports = Stack;
