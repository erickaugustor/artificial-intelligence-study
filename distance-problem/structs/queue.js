class Queue {
  constructor() {
    this.rotas = [];
    this.distanciaTotal = [];
  }

  pushRotas(rota, distancia) {
    this.rotas.push(rota);
  }

  pushDistania(distancia) {
    this.distanciaTotal.push(distancia);   
  }

  popRotas() {
    return this.rotas.pop();
  } 
 
  popDistancia() {
    return this.distanciaTotal.pop();
  } 

  peekRota() {
    return this.rotas[this.rotas.length - 1];
  } 

  peekDistancia() {
    return this.distanciaTotal[this.distanciaTotal.length - 1];    
  }

  isEmpty() {
    return this.rotas.length === 0 || this.rotas === undefined;
  } 

  size() {
    return this.rotas.length;
  } 

  peekEverything() {
    return this.rotas;
  }
}

module.exports = Queue;
