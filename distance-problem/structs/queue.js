class Queue {
  constructor() {
    this.routes = [];
    this.totalDistance = [];
  }

  pushRoute(route, distance) {
    this.routes.push(route);
  }

  pushDistance(distance) {
    this.totalDistance.push(distance);   
  }

  popRoute() {
    return this.routes.pop();
  } 
 
  popDistance() {
    return this.totalDistance.pop();
  } 

  peekRoute() {
    return this.routes[this.routes.length - 1];
  } 

  peekDistance() {
    return this.totalDistance[this.totalDistance.length - 1];    
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

module.exports = Queue;
