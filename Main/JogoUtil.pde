HashMap<Integer, Integer> mapasFitness = null; //new HashMap<Integer, Integer>(); // ordem de maior fitness, indice do mapa em "mapas"
    
void ordenarMapasPorFitnessAtual() {
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

void ordenarMapasPorFitness() { //<>//
  if (mapasFitness != null) {
    mapasFitness.clear();
  } else {
    mapasFitness = new HashMap<Integer, Integer>();
  }
  
  ArrayList<Integer> indicesLivresMapas = new ArrayList<Integer>();
  for (int i = 0; i < mapas.size(); i++) {
    indicesLivresMapas.add(i);
  }
  for (int i = 0; i < 4; i++) {
    
    Mapa mapaFitness = mapas.get(indicesLivresMapas.get(0));
    for (int k = 1; k < indicesLivresMapas.size(); k++) {
      if (mapas.get(indicesLivresMapas.get(k)).fitnessTotal > mapaFitness.fitnessTotal) {
        mapaFitness = mapas.get(indicesLivresMapas.get(k));
      }
    }
    //println(mapas.indexOf(mapaFitness));
    
    mapasFitness.put(i, mapas.indexOf(mapaFitness));
    indicesLivresMapas.remove(new Integer(mapas.indexOf(mapaFitness))); // nao esta removendo corretamente
  }
  mapaAtual = mapas.get(mapasFitness.get(0));
  indiceMapa = mapasFitness.get(0);
  //println(mapasFitness.toString());
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

void movimentar(PVector posicao, int movimento) {
  if (movimento == 1) {
    posicao.x += -1;
    posicao.y += -1;
  } else if (movimento == 2) {
    posicao.y += -1;
  } else if (movimento == 3) {
    posicao.x += 1;
    posicao.y += -1;
  } else if (movimento == 4) {
    posicao.x += -1;
  } else if (movimento == 5) {
    return;
  } else if (movimento == 6) {
    posicao.x += 1;
  } else if (movimento == 7) {
    posicao.x += -1;
    posicao.y += 1;
  } else if (movimento == 8) {
    posicao.y += 1;
  } else if (movimento == 9) {
    posicao.x += 1;
    posicao.y += 1;
  }
}
