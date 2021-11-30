interface WorldBuilder {
  void build();
}

class World1 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("terrain.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("cave.png", new Initializer() { 
      public void init() { 
        currentStage = new VariablesCave();
      }
    }
    , 50, 50));
  }
}

class World2 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("islandworld.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("cave.png", new Initializer() { 
      public void init() { 
        currentStage = new VariablesCave();
      }
    }
    , 50, 50));
  }
}

class World3 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("blue_gradient.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("cave.png", new Initializer() { 
      public void init() { 
        currentStage = new VariablesCave();
      }
    }
    , 50, 50));
  }
}

class World4 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("pink_orange_gradient.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("cave.png", new Initializer() { 
      public void init() { 
        currentStage = new VariablesCave();
      }
    }
    , 50, 50));
  }
}

class World5 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("yellow_green_gradient.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("cave.png", new Initializer() { 
      public void init() { 
        currentStage = new VariablesCave();
      }
    }
    , 50, 50));
  }
}

class World6 implements WorldBuilder {
  public void build() {
    worldMapBackground = new Background();
    worldMapBackground.image = loadImage("red_gradient.png");
    worldMapBackground.w = 1920;
    worldMapBackground.h = 1080;

    stageImages = new ArrayList<StageImage>();
    stageImages.add(new StageImage("lighthouse.png", new Initializer() { 
      public void init() { 
        currentStage = new DefaultValueLighthouse();
      }
    }
    , 50, 50));
    
     stageImages.add(new StageImage("shack.png", new Initializer() { 
      public void init() { 
        currentStage = new Polymorphism();
      }
    }
    , 1350, 50));
    stageImages.add(new StageImage("hedge.png", new Initializer() { 
      public void init() { 
        currentStage = new MainMethodsMaze();
      }
    }
    , 200, 550));
    stageImages.add(new StageImage("bridge.png", new Initializer() { 
      public void init() { 
        currentStage = new OOOBridge();
      }
    }
    , 840, 100));
    stageImages.add(new StageImage("volcano.png", new Initializer() { 
      public void init() { 
        currentStage = new CommandLineVolcano();
      }
    }
    , 1700, 215));
    stageImages.add(new StageImage("lighthouse.png", new Initializer() { 
      public void init() { 
        currentStage = new EncapsulatedOrImmutable();
      }
    }
    , 1450, 900));
    stageImages.add(new StageImage("castle.png", new Initializer() { 
      public void init() { 
        currentStage = new MainMethodsMaze();
      }
    }
    , 1200, 500));
    stageImages.add(new StageImage("tornado.png", new Initializer() { 
      public void init() { 
        currentStage = new TernaryTornado();
      }
    }
    , 900, 900));
    stageImages.add(new StageImage("manhole.png", new Initializer() { 
      public void init() { 
        currentStage = new NumberConstantSewer();
      }
    }
    , 500, 250));
    stageImages.add(new StageImage("pond.png", new Initializer() { 
      public void init() { 
        currentStage = new Pond();
      }
    }
    , 100, 950));
  }
}
