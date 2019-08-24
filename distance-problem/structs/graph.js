class Graph {
  constructor(isDirected = true) {
    this.isDirected = isDirected;
    this.vertices = [];
    this.adjList = new Map();
  }

  addVertex(vertice) {
    if (!this.vertices.includes(vertice)) {
      this.vertices.push(vertice);
      this.adjList.set(vertice, []);
    }
  } 

  addEdge(vertice, neighbour, distance) {
    if (!this.adjList.get(vertice)) {
      this.addVertex(vertice);
    }

    let obj = {};
    obj.neighbour = neighbour;
    obj.distance = distance;
    
    this.adjList.get(vertice).push(obj);
  }

  getVertices() {
    return this.vertices;
  }

  getAdjList() {
    return this.adjList;
  } 
}

module.exports = Graph;
