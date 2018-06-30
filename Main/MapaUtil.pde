HashMap<Integer, Integer> mapasFitness = null; //new HashMap<Integer, Integer>(); // ordem de maior fitness, indice do mapa em "mapas"
    
void ordenarMapasPorFitness() {
  mapasFitness = new HashMap<Integer, Integer>();
  for (int i = 0; i < 4; i++) {
    Mapa mapaFitness = mapas.get(0);
    for (int k = 0; k < mapas.size(); k++) {
      if (!mapasFitness.containsValue(k)) {
        if (mapas.get(k).fitness > mapaFitness.fitness) {
          mapaFitness = mapas.get(k);
        }
      }
    }
    mapasFitness.put(i, mapas.indexOf(mapaFitness));
  }
}

Mapa gerarNovoMapa(Mapa mapa) {
  return new Mapa(mapa.pers, mapa.inimigos, mapa.coletaveis);
}

HashMap<Integer, Integer> getMelhoresFitness(int qtde) {
  
  HashMap<Integer, Integer> mapIndicesFitness = new HashMap<Integer, Integer>();
  
  for (int i = 0; i < qtde; i++) {
    Mapa mapIndiceFitness = mapas.get(0);
    for (int k = 0; k < mapas.size(); k++) {
      if (!mapIndicesFitness.containsValue(k)) {
        if (mapas.get(k).fitness > mapIndiceFitness.fitness) {
          mapIndiceFitness = mapas.get(k);
        }
      }
    }
    mapIndicesFitness.put(i, mapas.indexOf(mapIndiceFitness));
  }
  return mapIndicesFitness;
}
