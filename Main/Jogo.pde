int posicaoYTexto;

void desenharTexto() {
  textSize(15);
  text("mapa: " + (indiceMapa), 10, 530);
  text("fitness: " + mapas.get(indiceMapa).fitness, 10, 550);
  text("geracao: " + geracao, 10, 570);
  text("qtde de mapas: " + mapas.size(), 10, 590);
  text("contador de movimentos: " + mapaAtual.pers.indiceMovimento, 10, 610);
  //text("Simulacao Automatica: " + (autoSimulate ? "ligada" : "desligada"), 10, 630);
  text("tempo de atualização: " + (int)tempoAtualizacao, 10, 630);
}

void atualizarGUI() {
  checkBoxAutoSimulate.setSelected(autoSimulate);
  checkBoxPause.setSelected(pause);
  checkboxDesenharGrid.setSelected(desenharGrid);
  
  lblContMov.setText("" + mapaAtual.pers.indiceMovimento);
  lblFitness.setText("" + mapas.get(indiceMapa).fitness);
  lblGeracao.setText("" + geracao);
  lblIndiceMapa.setText("" + indiceMapa);
  lblQtdeMapas.setText("" + mapas.size());
  
  btnIniciar.moveTo(mapaAtual.posicaoGrid.x, mapaAtual.getGridY2() + 20);
}

void customGUI() {
  panelOpcoes.setLocalColorScheme(6);
  checkBoxAutoSimulate.setLocalColorScheme(3);
  checkBoxPause.setLocalColorScheme(3);
  checkboxDesenharGrid.setLocalColorScheme(3);
  
  panelOpcoes.moveTo(tabelaMapas.posicaoGrid.x, tabelaMapas.posicaoGrid.y + tabelaMapas.altura);
  panelInformacoes.moveTo(panelOpcoes.getX() + panelOpcoes.getWidth(), panelOpcoes.getY());
  btnVisualizar1.moveTo(tabelaMapas.posicaoGrid.x + 300, tabelaMapas.posicaoGrid.y); 
  btnVisualizar2.moveTo(tabelaMapas.posicaoGrid.x + 300, tabelaMapas.posicaoGrid.y + 95); 
  btnVisualizar3.moveTo(tabelaMapas.posicaoGrid.x + 300, tabelaMapas.posicaoGrid.y + 2 * 95); 
  btnVisualizar4.moveTo(tabelaMapas.posicaoGrid.x + 300, tabelaMapas.posicaoGrid.y + 3 * 95);
  panelOpcoes.setDraggable(false);
  panelInformacoes.setDraggable(false);
  
  surface.setTitle("Algoritmo Genético");
  GButton.useRoundCorners(false);
  //btnLenta.useRoundCorners(false);
  //btnMedia.useRoundCorners(false);
  //btnRapida.useRoundCorners(false);
}

void criarAmbiente() {
  geracao = 0;
  mapas = new ArrayList<Mapa>();
  mapas.add(new Mapa());
  mapaAtual = mapas.get(0);
  preverFitness(mapas.get(0));
  posicaoInicialPersonagem.x = mapas.get(0).pers.posicao.x;
  posicaoInicialPersonagem.y = mapas.get(0).pers.posicao.y;
  for (int numMapa = 1; numMapa < 10; numMapa++) {
    mapas.add(new Mapa(mapaAtual));
    mapas.get(numMapa).id = numMapa;
    preverFitness(mapas.get(numMapa));
  }
  ordenarMapasPorFitness();
}

void gerarNovaGeracao() {
  adicionarPontosGrafico();
  crossOver();
  geracao++;
  novaGeracao = false;
  ordenarMapasPorFitness();
  for (Mapa mapa : mapas) {
    preverFitness(mapa);
  }
  ordenarMapasPorFitness();
}

void atualizarJogo() {
  // mapa esta sendo atualizado a todo instante, 
  // verificar a necessidade de separar essa 
  // funcionalidade apenas quando for necessario
  mapaAtual = mapas.get(indiceMapa);
  if ((tempoAtualizacao > 5 || mousePressed) && mapaAtual.pers.emMovimento == false) {
    tempoAtualizacao = 0;
    for (Mapa mapa : mapas) {
      mapa.pers.emMovimento = true;
      //mapa.resetarValores();
    }
  }
  if (tempoMovimentacao >= tempoMovLimite) {
    for (Mapa mapa : mapas) {
      mapa.atualizar();
    }
    tempoMovimentacao = 0;
  }
  
  // realizar a nova geração
  if(novaGeracao) {
    gerarNovaGeracao();
  }
  
  if (mapaAtual.pers.emMovimento == false && autoSimulate) {
    tempoAtualizacao += 0.1;
  }
  
  tempoMovimentacao += 0.1;
}

void keyPressed() {
  if (key == 'p') {
    pause = !pause;
  } else if (key == 'd') {
    desenharGrid = !desenharGrid; 
  } else if (key == 'g') {
    alternarGrafico = !alternarGrafico;  
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (indiceMapa > 0) {
        indiceMapa--;
        mapaAtual = mapas.get(indiceMapa);
      }
    } else if (keyCode == RIGHT) {
      if (indiceMapa < mapas.size() - 1) {
        indiceMapa++;
        mapaAtual = mapas.get(indiceMapa);
      }
    } else if (keyCode == UP) {
      novaGeracao = true;
    } else if (keyCode == DOWN) {
      autoSimulate = !autoSimulate;
      tempoAtualizacao = 0;
    }
  }
}

public void regenerarJogo() {
  criarAmbiente();
}

int contPontosGrafico = 0;

public void configurarGrafico() {
  grafico = new GPlot(this);
  pontosFitness = new GPointsArray();
  contPontosGrafico = 0;
}

public void adicionarPontosGrafico() {
  //pontosFitness.set(pontosFitness.getNPoints(), new GPoint(geracao, mapas.get(mapasFitness.get(0)).fitnessTotal));
  grafico.addPoint(geracao, mapas.get(mapasFitness.get(0)).fitnessTotal);
  contPontosGrafico++;
}

public void desenharGrafico() {
  grafico.setPos(mapaAtual.posicaoGrid.x, mapaAtual.getGridY2() + 60);
  grafico.beginDraw();
  grafico.drawBackground();
  //grafico.activateZooming();
  //grafico.activatePanning();
  grafico.drawXAxis();
  grafico.drawYAxis();
  grafico.drawBox();
  grafico.drawGridLines(2);
  if (contPontosGrafico < 20) {
    grafico.drawPoints(); 
  }
  grafico.drawLabels();
  grafico.drawFilledContours(GPlot.HORIZONTAL, 0.05);
  grafico.drawLines();
  grafico.endDraw();
}

public void importar() {}

public void exportar() {
  JSONObject mapaJson = new JSONObject(); 
  JSONObject inimigoJson = new JSONObject();
  JSONObject coletavelJson = new JSONObject();
  JSONObject persJson = new JSONObject();
  JSONObject posicaoJson = new JSONObject();
  JSONArray inimigosJson = new JSONArray();
  JSONArray coletaveisJson = new JSONArray();
  int i = 0;
    
  for (Mapa m : mapas) {
    mapaJson = new JSONObject();
    mapaJson.setInt("largura", m.largura);
    mapaJson.setInt("altura", m.altura);
    mapaJson.setInt("fitness", m.fitness);
    mapaJson.setInt("fitnessTotal", m.altura);
    mapaJson.setFloat("tamanhoCelula", m.tamanhoCelula);
    
    i = 0;
    inimigosJson = new JSONArray();
    for (Inimigo inim : m.inimigos) {
      inimigoJson = new JSONObject();
      inimigoJson.setInt("cor", inim.cor);
      inimigoJson.setString("etiqueta", inim.etiqueta);
     
      posicaoJson = new JSONObject();
      posicaoJson.setFloat("x", inim.posicao.x);
      posicaoJson.setFloat("y", inim.posicao.x);
      
      inimigoJson.setJSONObject("posicao", posicaoJson);
      inimigosJson.setJSONObject(i, inimigoJson);
      i++;
    }
    mapaJson.setJSONArray("inimigos", inimigosJson);
    
    i = 0;
    coletaveisJson = new JSONArray();
    for (Coletavel col : m.coletaveis) {
      coletavelJson = new JSONObject();
      coletavelJson.setInt("cor", col.cor);
      coletavelJson.setString("etiqueta", col.etiqueta);
      
      posicaoJson = new JSONObject();
      posicaoJson.setFloat("x", col.posicao.x);
      posicaoJson.setFloat("y", col.posicao.x);
      coletavelJson.setJSONObject("posicao", posicaoJson);
      coletaveisJson.setJSONObject(i, coletavelJson);
      i++;
    }
    mapaJson.setJSONArray("coletaveis", coletaveisJson);

    saveJSONObject(mapaJson,"AG_export_data.json");
  }
}
