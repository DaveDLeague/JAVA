final String[] WORD_LIST = {"abeam", "abide", "abiding", "ablaze", "able", "abloom", "above", "absolute", "absolutely", "absolve", "absolved", "abundance", "abundant", "accelerate", "accelerated", "accelerating", "accept", "acceptable", "acceptance", "accepting", "accessibility", "accessible", "acclaim", "acclaimed", "accommodate", "accommodating", "accommodative ", "accomplish", "accomplished", "accomplishing", "accomplishment", "accountability", "accountable", "ace", "aced", "achieve", "achievement", "achiever", "acknowledged", "acquaint", "acquire", "act", "action", "activate", "active", "admirable", "admire", "adore", "adored", "adoring", "advance", "advanced", "advantage", "advantaged", "adventure", "adventurous", "advertise", "advertisement", "advisable", "aesthetic", "aesthetically", "affability", "affable", "affect", "affection", "affectionate", "affirm", "affirmation", "affluent", "alive", "allure", "alluring", "amaze", "amazement", "amazing", "anticipate", "anticipation", "appeal", "appealing", "appreciate", "appreciation", "approval", "approve", "assertive", "astute", "attitude", "attitude", "attract", "attractive", "audacious", "authentic", "automate", "autonomous", "awesome", "ballsy", "beam", "beam", "beaming", "beautiful", "beautify", "beauty", "becoming", "believable", "believe", "believing", "beneficial", "benefits", "best", "best", "beyond", "beyond", "big", "blasting", "blazing", "bless", "blessed", "blessed", "blessings", "bliss", "blockbuster", "blossom", "bold", "bold", "bombastic", "bonafide", "bonus", "bonus", "bonzer", "boost", "booster", "booster", "boss", "bounce", "boundless", "bountiful", "bountiful", "bounty", "brain", "brainpower", "brainstorm", "brainy", "brainy", "bravado", "brave", "bravely", "bravery", "bravo", "breakout", "breakthrough", "breathless", "breathtaking", "breeze", "breeze", "breezy", "bright", "brighten", "brightly", "brightly", "brilliance", "brilliant", "brilliantly", "brimming", "broadminded", "bubble", "build", "builder", "building", "bundle", "buoyant", "buoyantly", "bustling", "calculate", "calculated", "calm", "calmative", "calming", "calmness", "campaigner", "can", "candid", "candidly", "capability", "capable", "capture", "carefree", "careful", "carefully", "caring", "celebrate", "celebration", "centre", "ceremony", "challenge", "champion", "charisma", "chase", "chaser", "cheer", "cheerful", "cheerio", "cheers", "cheery", "cherish", "childish", "chivalry", "chummy", "civil", "clarity", "classic", "classical", "classy", "clear", "clever", "climb", "climber", "climbing", "cognizant", "coherent", "collector", "collegial", "color", "colossal", "colourful", "comfort", "comfortable", "comforter", "command", "commanding", "commit", "commitment", "compassion", "compassionate", "compelling", "competence", "competent", "compliment", "complimentary", "comprehensive", "comrades", "concert", "concise", "concrete", "confidant", "confidence", "confidence", "confidently", "constant", "constantly", "content", "contribute", "contributor", "convince", "convincing", "cool", "coolest", "cooperate", "cooperatively", "cornerstone", "countless", "courage", "courageousness", "courteous", "courtesy", "coziness", "cozy", "crank", "create", "creating", "creative", "credibility", "credible", "credit", "cuddle", "cultivated", "cute", "cutely", "cuteness", "dance", "dancer", "dandy", "dapper", "dashing", "dazzle", "dazzled", "dear", "dearly", "debonair", "dedicated", "dedication", "deep", "deeper", "deeply", "defiant", "defiantly", "define", "definite", "deliberate", "delicate", "delicately", "delicious", "delight", "delightful", "delightfully", "desirability", "desirable", "determine", "determined", "develop", "developed", "developing", "devoted", "devotee", "devoutly", "dexterity", "diamond", "different", "distinguished", "diverse", "diverting", "divine", "doable", "doer", "dumbfounded", "durability", "durable", "dutiful", "duty", "dynamic", "dynamite", "dynamo", "eager", "eagerly", "early", "earnest", "earnestly", "easing", "easy", "economic", "edit", "educate", "educated", "efficiency", "efficient", "efficiently", "effortless", "effortlessly", "electric", "electricity", "electrify", "electrifying", "elevate", "emotional", "empathetic", "empathy", "empowered", "empowering", "encore", "encourage", "encouraging", "endow", "endowed", "endurance", "endure", "enduring", "energetic", "energize", "energized", "energy", "engage", "engaged", "enriching", "entertain", "entertaining", "entertainment", "enthusiasm", "enthusiastic", "enthusing", "entice", "enticed", "enticing", "entire", "entirely", "especially", "establish", "established", "eternal", "eternally", "ethical", "ethically", "excel", "excellence", "excellent", "excitable", "excite", "excitement", "exclusive", "exclusivity", "exquisite", "extensive", "fabulous", "fabulously", "fair", "fairness", "fame", "family", "fanatic", "fantastic", "fantastical", "fascinate", "fast", "faultless", "favour", "favourite", "fearlessly", "feasible", "feedback", "feel", "fellow", "ferocious", "fertile", "fervently", "festive", "festivity", "fetch", "fetching", "finances", "fine", "finesse", "firm", "firmer", "fitness", "flash", "flaunting", "flirty", "fluency", "fluent", "flutter", "flyer", "flying", "focus", "focused", "fond", "fondly", "foolproof", "forerunner", "foresight", "forever", "fortunate", "fresh", "friend", "friendly", "fulfil", "fulfilled", "full", "fully", "fun", "fundamental", "funny", "future", "futuristic", "gained", "gainfully", "gains", "gallant", "galore", "game", "gamer", "generosity", "generous", "gentle", "gently", "genuine", "genuinely", "giddy", "giddy", "gift", "gifted", "giggle", "giggling", "giver", "giving", "glad", "gladly", "glam", "glamorous", "glee", "gleeful", "glimmer", "glimmering", "glorification", "glorious", "gloriously", "glow", "glowing", "glutinous", "goal", "good", "gorgeousness", "gourmet", "grace", "graced", "gracious", "grateful", "gratifying", "gratitude", "great", "grounded", "grounding", "grow", "growing", "guarantee", "guardian", "guest", "guidance", "guide", "guided", "guiding", "gumption", "gusto", "habit", "hallelujah", "hallmark", "handy", "happiness", "happy", "hardier", "harmonic", "harmonious", "harmonize", "harmony", "harness", "health", "healthy", "heart", "heaven", "high", "highly", "hilarious", "hilarity", "homely", "honest", "honestly", "honesty", "honorable", "honored", "hopeful", "hopefully", "hopefulness", "hospitable", "host", "hottest", "hug", "huge", "humanely", "humanitarian", "hypersonic", "hypnotic", "hypnotically", "idea", "ideal", "idealism", "idealistic", "ideally", "idolized", "illustrate", "illustrious", "imagination", "imaginative", "imaginatively", "imagine", "immortal", "immune", "impartially", "impassioned", "impress", "impressing", "impressively", "improve", "improvement", "inciting", "increase", "increased", "incredible", "incredibly", "independent", "indomitable", "industrious", "industriously", "informed", "initiate", "initiator", "inner", "innocent", "innovate", "innovation", "innovative", "inquisitive", "insightful", "inspiration", "inspirational", "inspire", "inspired", "inspiring", "intellect", "intelligence", "intelligent", "intent", "intention", "intently", "interact", "intrigue", "intriguingly", "invaluable", "inventor", "invested", "investor", "invite", "inviting", "involve", "involved", "irrefutable", "irreplaceable", "irrepressible", "irresistible", "jest", "jesting", "jointly", "jolly", "jovial", "joy", "joyful", "joyfully", "joyous", "judicious", "juggler", "juggling", "jump", "justice", "justified", "justify", "justly", "keen", "keenly", "keep", "keeper", "kept", "kind", "kindliness", "kindly", "kindred", "kinetic", "king", "kiss", "knowing", "knowingly", "knowledge", "knowledgeable", "kosher", "kudos", "large", "lasting", "laugh", "laughter", "leader", "leads", "learn", "legend", "legit", "legitimate", "lenient", "let", "level", "leverage", "liberating", "liberty", "life", "lift", "lifting", "light", "lighten", "limitless", "live", "lively", "living", "love", "loved", "lovely", "loving", "loyal", "lucidly", "luck", "luckiest", "luckily", "lucky", "lucrative", "lucratively", "luminate", "luminously", "lush", "maestro", "magic", "magical", "magically", "magnetic", "magnetically", "magnificent", "magnify", "magnitude", "major", "majority", "manoeuvrability", "manoeuvrable", "marvel", "marvellous", "massive", "masterful", "mastery", "match", "mature", "maturely", "meaning", "meaningful", "meant", "meditation", "meditative", "melodious", "melody", "memorable", "mercy", "merit", "merit able", "mesmerizing", "metaphysical", "meteoric", "meteorically", "methodical", "meticulous", "meticulously", "mighty", "mindset", "miracle", "miraculous", "momentous", "momentum", "motion", "motivate", "motivating", "motivation", "move", "movement", "mover", "mucho", "mutual", "mutually", "myriad", "namaste", "narrative", "natural", "naturalize", "navigate", "navigated", "navigation", "neat", "neatly", "necessary", "neutral", "nice", "nicely", "nipper", "nirvana", "noble", "nonchalant", "normal", "noted", "noticeably", "notorious", "novel", "novelty", "nurse", "nurture", "nurtured", "nurturing", "nutritious", "objective", "objectively", "obliged", "obliging", "observe", "obsess", "obsessed", "obsession", "obtain", "obtained", "offer", "offering", "official", "onward", "oodles", "oomph", "ooze", "open", "opportune", "optimism", "optimistic", "optimize", "optimized", "optimum", "opulent", "opulently", "order", "orderly", "organic", "organized", "outgoing", "outlasting", "outstanding", "outwit", "outwitted", "ovation", "overjoyed", "overtake", "overtaking", "overtook", "overture", "owner", "owning", "pacifist", "pacify", "painless", "palatable", "participate", "participated", "participation", "partner", "passion", "passionate", "passionately", "pathfinder", "patience", "patient", "peace", "peaceful", "perception", "perceptive", "perkiness", "perky", "perseverance", "persevere", "persevered", "personable", "perspective", "persuasion", "persuasively", "phenomenal", "phenomenally", "picturesque", "pioneer", "pioneering", "planner", "player", "playful", "playfully", "poetic", "poetry", "polite", "politeness", "popular", "popularity", "positive", "possibilities", "possible", "power", "powered", "powerful", "powerfully", "pragmatic", "premier", "premium", "prepare", "prepared", "presence", "present", "prestigious", "presto", "prevail", "pride", "privilege", "privileged", "produce", "productive", "productivity", "prominent", "protect", "protection", "proud", "provocative", "provocatively", "pumped", "punctual", "pure", "purely", "purify", "purpose", "purposeful", "purposefully", "purveyor", "quaint", "qualitative", "quality", "quantifiable", "quantity", "que", "queen", "quest", "quester", "question", "questioning", "quick", "quicken", "quietly", "quintessential", "quip", "quirk", "quite", "quiz", "quotation", "quote", "radiance", "radiant", "radiantly", "radical", "rank", "rapid", "rapidly", "ravenous", "ravish", "ravishing", "reappear", "rebellious", "reclaim", "recognition", "recommend", "recommendations", "recommended", "recover", "redo", "relationship", "relaxing", "reliable", "reliant", "relish", "renew", "renewed", "renovate", "renown", "repeat", "repent", "replenish", "replenishing", "replenishment", "represent", "reputable", "reputation", "research", "resilient", "resiliently", "resonate", "resonating", "resounding", "respect", "respectfully", "rest", "rested", "restful", "restore", "revere", "review", "revived", "revolution", "revolutionize", "revolutionized", "reward", "rewardable", "rewarding", "rhapsody", "rich", "richness", "ridiculous", "ridiculously", "rigorous", "robust", "robustly", "romance", "romantic", "runner", "sacred", "saintly", "salient", "sassy", "satisfied", "satisfies", "satisfy", "satisfying", "scope", "secure", "secured", "security", "seductive", "seek", "seeker", "select", "selection", "selective", "self", "sensational", "sensibility", "sentiment", "sentimental", "sentimentally", "serendipitous", "serendipity", "sexy", "shining", "size", "skilled", "skillful", "skills", "sleek", "smile", "sparkle", "sparkling", "spiritual", "spirituality", "splendid", "spouse", "steadfast", "strong", "success", "successful", "sufficiency", "sufficient", "superb", "superbly", "support", "supported", "supporting", "supportive", "surprise", "surrounded", "surrounding", "swankiest", "swanky", "sway", "sweep", "sweet", "sweetly", "sympathetic", "symptoms", "synergy", "system", "systematic", "tactful", "talent", "talented", "tantalizing", "taught", "teach", "teacher", "teaching", "team", "teammate", "teamwork", "temperate", "tempt", "tenacious", "terrific", "test", "thankful", "thanks", "think", "thinker", "thinking", "thorough", "thought", "thoughtful", "thoughts", "thrifty", "thrillingly", "thrive", "thriving", "time", "tingle", "tirelessly", "together", "totally", "touchingly", "traction", "tradition", "trailblazer", "tranquil", "tranquility", "transcend", "transform", "transformation", "transformational", "treasure", "treat", "treaty", "trendy", "triumph", "triumphant", "triumphantly", "trophy", "truly", "trust", "trusted", "trustee", "trustful", "trusting", "tutor", "twinkle", "uber", "ultimate", "unabashed", "unafraid", "unarguable", "unassuming", "unbelievable", "uncommon", "undaunted", "understand", "understood", "undivided", "undoubted", "unfazed", "unfeigned", "unforgettable", "unhampered", "unicorn", "unification", "unified", "unimpaired", "unimpeachable", "unique", "unite", "united", "unmatched", "unmistakable", "unobtrusive", "unopposed", "unparalleled", "unpretentious", "unquestionable", "unrestricted", "unshakeable", "unwavering", "upcoming", "upgraded", "upholder", "uplift", "uplifted", "uplifting", "upliftment", "upright", "upward", "usable", "utilize", "utmost", "valid", "validate", "validator", "value", "valued", "values", "vanish", "vary", "vast", "vehemently", "veraciously", "verified", "verify", "versatile", "versatile", "versatility", "veteran", "viable", "vibrant", "victory", "vigor", "vindicate", "vintage", "virile", "vital", "vitality", "viva", "vivacious", "vogue", "voila", "voyage", "vroom", "vulnerability", "valuable", "value", "wake", "waken", "want", "wanted", "warm", "warm", "warmly", "warmth", "wash", "watch", "water", "wave", "wealth", "wealthiness", "welfare", "well", "whimsical", "whip", "whirl", "whiz", "whole", "wholeness", "wholesome", "whoopee", "whopper", "whopping", "wiggle", "willingly", "windfall", "winners", "winning", "wins", "wise", "wishful", "within", "wizardly", "wonder", "wonderful", "wonderfully", "wonderment", "wonderous", "wonders", "wondrous", "wondrously", "wooer", "work", "workable", "worked", "worth", "worthily", "worthiness", "worthwhile", "worthy", "wowed", "wowing", "wrap", "xenagogue", "xenial", "xenium", "x_factor", "x_ray", "yah", "yearn", "yearning", "yes", "yield", "yippee", "young", "younger", "youth", "youthful", "yum", "yummy", "zaniness", "zany", "zappy", "zealous", "zest", "zestful", "zesty", "zing", "zippy"};
final String[] JAVA_KEYWORDS = {"abstract", "continue", "for", "new", "switch", "assert", "default", "goto", "package", "synchronized", "boolean", "do", "if", "private", "this", "break", "double", "implements", "protected", "throw", "byte", "else", "import", "public", "throws", "case", "enum", "instanceof", "return", "transient", "catch", "extends", "int", "short", "try", "char", "final", "interface", "static", "void", "class", "finally", "long", "strictfp", "volatile", "const", "float", "native", "super", "while"};
final char[] CURRENCY_SYMBOLS = {'$', '¢', '£', '€', '¥'};
float dialogChoiceYPos = resolutionHeight - resolutionHeight / 4;
final float dialogChoiseYIncrement = 60;
final color defaultDialogBoxOffColor = color(50, 100, 200, 196);
final color defaultDialogBoxOnColor = color(105, 155, 255, 196);
final color defaultDialogTextOffColor = color(255);
final color defaultDialogTextOnColor = color(255, 255, 0);

float textBoxYPos = resolutionHeight / 4;
final float textBoxYIncrement = 60;
final float textBoxTextSize = 24;

boolean canInteract = true;
boolean interaction;
boolean canEnterInput = true;
boolean enterInput = false;
boolean resetDialogMax;
int highlightededDialogChoice = 0;
int totalDialogChoices;
int dialogMax;

enum GameStates {
  TITLE_STATE, WORLD_MAP_STATE, VARIABLES_CAVE_STATE, IMPORTS_SHACK_STATE, MAIN_METHODS_MAZE_STATE, 
    HOW_TO_PLAY_STATE, CHARACTER_SELECT_STATE
}

static class SaveState implements Serializable {
  int player;
}

void saveGame(SaveState s) {
  try {
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(dataFolderPath + "/save_data"));
    oos.writeObject(s);
    oos.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
}

SaveState loadGame() {
  SaveState s = null;
  try {
    ObjectInputStream ois = new ObjectInputStream(new FileInputStream(dataFolderPath + "/save_data"));
    s = (SaveState)ois.readObject();
    ois.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  catch(ClassNotFoundException e) {
    e.printStackTrace();
  }
  return s;
}

class Background {
  PImage image;
  color clr;
  float w;
  float h;

  public Background() {
  }
  public Background(float w, float h) {
    this.w = w;
    this.h = h;
  }
}

class StageImage {
  PImage image;
  GameStates state;
  float x; 
  float y;
  boolean completed;

  public StageImage(String file, GameStates state, float x, float y) {
    this.image = loadImage(file);
    this.state = state;
    this.x = x;
    this.y = y;
  }
}

class Player {
  PImage image;
  String name;
  float maxSpeed = 7;
  float acceleration = 1;
  float friction = 0.5;

  float x;
  float y;
  float w;
  float h;
  float xSpeed;
  float ySpeed;

  boolean up;
  boolean down;
  boolean left;
  boolean right;

  void update() {
    if (up) {
      ySpeed -= acceleration;
      if (ySpeed < -maxSpeed) {
        ySpeed = -maxSpeed;
      }
    }
    if (down) {
      ySpeed += acceleration;
      if (ySpeed > maxSpeed) {
        ySpeed = maxSpeed;
      }
    }
    if (left) {
      xSpeed -= acceleration;
      if (xSpeed < -maxSpeed) {
        xSpeed = -maxSpeed;
      }
    }
    if (right) {
      xSpeed += acceleration;
      if (xSpeed > maxSpeed) {
        xSpeed = maxSpeed;
      }
    }
    if (xSpeed > 0) {
      xSpeed -= friction;
    } else if (xSpeed < 0) {
      xSpeed += friction;
    }
    if (ySpeed > 0) {
      ySpeed -= friction;
    } else if (ySpeed < 0) {
      ySpeed += friction;
    }

    x += xSpeed;
    y += ySpeed;

    if (x < 0) x = 0;
    else if (x > resolutionWidth - w) x = resolutionWidth - w;
    if (y < 0) y = 0;
    else if (y > resolutionHeight - h) y = resolutionHeight - h;
  }

  void setImage(PImage image) {
    this.image = image;
    this.w = image.width;
    this.h = image.height;
  }
}

class Camera {
  public float x;
  public float y;
  public float xMargin;
  public float yMargin;

  void update() {
    if (x < currentBackground.w - resolutionWidth && player.x > resolutionWidth - xMargin) {
      x += player.x - (resolutionWidth - xMargin);
      player.x = resolutionWidth - xMargin;
    } else if (x > 0 && player.x + player.w < xMargin) {
      x += player.x + player.w - xMargin;
      player.x = xMargin - player.w;
    }
    if (y < currentBackground.h - resolutionHeight && player.y > resolutionHeight - yMargin) {
      y += player.y - (resolutionHeight - yMargin);
      player.y = resolutionHeight - yMargin;
    } else if (y > 0 && player.y + player.h < yMargin) {
      y += player.y + player.h - yMargin;
      player.y = yMargin - player.h;
    }

    if (x < 0) x = 0;
    else if (x > currentBackground.w - resolutionWidth) x = currentBackground.w - resolutionWidth;
    if (y < 0) y = 0;
    else if (y > currentBackground.h - resolutionHeight) y = currentBackground.h - resolutionHeight;
  }
}

class SolidBlock {
  float x;
  float y;
  float w;
  float h;

  public SolidBlock() {
  }
  public SolidBlock(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

class PushBox {
  float x;
  float y;
  float w;
  float h;

  public PushBox() {
  }
  public PushBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

boolean checkInteraction() {
  if (interaction && canInteract) {
    canInteract = false; 
    return true;
  }else if(!interaction){
    canInteract = true; 
  }

  return false;
}

boolean checkEnterInput(){
  if(enterInput && canEnterInput){
    canEnterInput = false;
    return true;
  }else if(!enterInput){
    canEnterInput = true; 
  }
  
  return false;
}

void drawCheck(float xp, float yp) {
  strokeWeight(7);
  stroke(0);
  line(xp - 5, yp - 5, xp, yp);
  line(xp, yp, xp + 10, yp - 10);
  strokeWeight(3);
  stroke(0, 255, 0);
  line(xp - 5, yp - 5, xp, yp);
  line(xp, yp, xp + 10, yp - 10);
  strokeWeight(1);
  stroke(0);
}

String generateRandomNumberString(int maxDigits) {
  String num = "";
  int digits = (int)random(maxDigits) + 1;
  for (int i = 0; i < digits; i++) {
    num += (int)random(10);
  }
  return num;
}

boolean checkIntersection(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1 + w1 < x2 || x1 > x2 + w2 || y1 + h1 < y2 || y1 > y2 + h2) {
    return false;
  }

  return true;
}

boolean handleSolidBlockCollision(SolidBlock block) {
  boolean ret = false;

  float bx = block.x - camera.x;
  float by = block.y - camera.y;

  float nx = player.x + player.xSpeed;
  float ny = player.y + player.ySpeed;

  if (player.xSpeed > 0) {
    if (nx + player.w > bx && nx < bx && ny + player.h > by && ny < by + block.h) {
      player.xSpeed = 0;
      player.x = bx - player.w;
      ret = true;
    }
  } else if (player.xSpeed < 0) {
    if (nx < bx + block.w && nx + player.w > bx + block.w && ny + player.h > by && ny < by + block.h) {
      player.xSpeed = 0;
      player.x = bx + block.w;
      ret = true;
    }
  }
  if (player.ySpeed > 0) {
    if (ny + player.h > by && ny < by && player.x + player.w > bx && player.x < bx + block.w) {
      player.ySpeed = 0;
      player.y = by - player.h;
      ret = true;
    }
  } else if (player.ySpeed < 0) {
    if (ny < by + block.h && ny + player.h > by + block.h && player.x + player.w > bx && player.x < bx + block.w) {
      player.ySpeed = 0;
      player.y = by + block.h;
      ret = true;
    }
  }
  return ret;
}

boolean handlePushBoxCollision(PushBox box) {
  boolean ret = false;

  float bx = box.x - camera.x;
  float by = box.y - camera.y;

  float nx = player.x + player.xSpeed;
  float ny = player.y + player.ySpeed;

  if (player.xSpeed > 0 && nx < bx && nx + player.w > bx && ny + player.h > by && ny < by + box.h) {
    box.x += player.xSpeed;
    if (box.x + box.w > currentBackground.w) {
      box.x = currentBackground.w - box.w;
      player.xSpeed = 0;
      player.x = box.x - player.w - camera.x;
    }
    ret = true;
  } else if (player.xSpeed < 0 && nx + player.w > bx + box.w && nx < bx + box.w && ny + player.h > by && ny < by + box.h) {
    box.x += player.xSpeed;
    if (box.x < 0) {
      box.x = 0;
      player.xSpeed = 0;
      player.x = box.x + box.w;
    }
    ret = true;
  }

  if (player.ySpeed > 0 && ny < by && ny + player.h > by && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y + box.h > currentBackground.h) {
      box.y = currentBackground.h - box.h;
      player.ySpeed = 0;
      player.y = box.y - box.h - camera.y;
    }
    ret = true;
  } else if (player.ySpeed < 0 && ny + player.h > by + box.h && ny < by + box.h && nx < bx + box.w && nx + player.w > bx) {
    box.y += player.ySpeed;
    if (box.y < 0) {
      box.y = 0;
      player.ySpeed = 0;
      player.y = box.y + box.h;
    }
    ret = true;
  }

  return ret;
}

boolean checkMouseInBounds(float x, float y, float w, float h) {
  boolean ret = false;
  if (scaledMouseX > x && scaledMouseX < x + w && scaledMouseY > y && scaledMouseY < y + h) {
    ret = true;
  }
  return ret;
}

void resetDialogChoiceYPos() {
  dialogChoiceYPos = resolutionHeight - resolutionHeight / 4;
  totalDialogChoices = 0;
  if(resetDialogMax){
    dialogMax = 0;
   resetDialogMax = false; 
  }
}

boolean renderDialogChoice(String text) {
  float h = textBoxTextSize;
  textSize(h);
  float tw = textWidth(text);
  float x = resolutionWidth / 2 - tw / 2;
  color bc = defaultDialogBoxOffColor;
  color tc = defaultDialogTextOffColor;
  boolean ret = false;
  
  if (scaledMouseX > x - 10 && scaledMouseX < x + tw + 10 && 
    scaledMouseY > dialogChoiceYPos - 10 && scaledMouseY < dialogChoiceYPos + h + 10) {
    bc = defaultDialogBoxOnColor;
    tc = defaultDialogTextOnColor;

    if (mousePressed && mouseButton == LEFT) {
      mousePressed = false;
      ret = true;
    }
  }
  if(currentInputState == KEYBOARD_STATE && totalDialogChoices == highlightededDialogChoice){
    bc = defaultDialogBoxOnColor;
    tc = defaultDialogTextOnColor;
    
    if(checkEnterInput()) ret = true;
  }
  renderTextBox(dialogChoiceYPos, bc, tc, text);
  dialogChoiceYPos += dialogChoiseYIncrement;
  
  totalDialogChoices++;
  if(totalDialogChoices > dialogMax){
    dialogMax = totalDialogChoices;
  }
  
  if(ret) resetDialogMax = true;
  return ret;
}

void resetTextBoxYPos() {
  textBoxYPos = resolutionHeight / 4;
}

void renderTextBox(String... text) {
  renderTextBox(textBoxYPos, text);
  textBoxYPos += textBoxYIncrement;
}

void renderTextBox(float y, String... text) {
  renderTextBox(y, color(100, 100, 100, 196), color(255), text);
}

void renderTextBox(float x, float y, String... text) {
  renderTextBox(x, y, color(100, 100, 100, 196), color(255), text);
}

void renderTextBox(float x, float y, color boxColor, color textColor, String... text) {
  float h = textBoxTextSize;
  textSize(h);
  float w = 0;
  for (int i = 0; i < text.length; i++) {
    float tw = textWidth(text[i]);
    if (tw > w) w = tw;
  }
  fill(boxColor);
  float bh = (h * 1.5) + (h * text.length - 1);
  rect(x - 5, y - h / 2, w + 10, bh, 7);
  for (int i = 0; i < text.length; i++) {
    fill(textColor);
    text(text[i], x, y + h + (i * h));
  }
}

void renderTextBox(color boxColor, color textColor, String... text) {
  renderTextBox(textBoxYPos, boxColor, textColor, text);
}

void renderTextBox(float y, color boxColor, color textColor, String... text) {
  float h = textBoxTextSize;
  textSize(h);
  float w = 0;
  for (int i = 0; i < text.length; i++) {
    float tw = textWidth(text[i]);
    if (tw > w) w = tw;
  }
  float x = resolutionWidth / 2 - w / 2;
  fill(boxColor);
  float bh = (h * 1.5) + (h * text.length - 1);
  rect(x - 5, y - h / 2, w + 10, bh, 7);
  for (int i = 0; i < text.length; i++) {
    float nw = textWidth(text[i]);
    float nx = resolutionWidth / 2 - nw / 2;
    fill(textColor);
    text(text[i], nx, y + h + (i * h));
  }
}

boolean renderPlayerButton(String text, float x, float y) {
  return renderPlayerButton(text, "Press SPACE to " + text, x, y);
}

boolean renderPlayerButton(String text, String prompt, float x, float y) {
  boolean ret = false;

  float h = 36;
  textSize(h);
  float w = textWidth(text);
  float nx = x - camera.x;
  float ny = y - camera.y;
  fill(0, 0, 255);
  rect(nx - 10, ny - 10, w + 20, h + 20, 7);
  fill(255);
  text(text, nx, ny + h - 5);

  if (checkIntersection(player.x, player.y, player.w, player.w, nx, ny, w, h)) {
    textSize(promptTextSize);
    fill(255);
    text(prompt, nx, ny);
    if (checkInteraction()) {
      ret = true;
    }
  }

  return ret;
}

boolean recievingTextInput = false;

boolean inputBoxCursorBlink = false;
boolean inputSubmitted = false;
long inputBoxCursorTime = 0;
String inputBoxString = "";
String renderInputBox() {
  recievingTextInput = true;
  float h = 50;
  float w = 600;
  textSize(h);

  String ts = inputBoxString + '|';
  float tsw = textWidth(ts);
  while (tsw >= w) {
    inputBoxString = inputBoxString.substring(0, inputBoxString.length() - 1);
    ts = inputBoxString + '|';
    tsw = textWidth(ts);
  }

  float hrw = resolutionWidth / 2;  
  float x = hrw - w / 2;
  float y = resolutionHeight - 70;
  fill(0, 0, 0, 196);
  rect(x, y, w, h);
  fill(255);

  text(inputBoxString, x, y + h - 9);
  if (inputBoxCursorBlink) fill(255);
  else fill(255, 255, 255, 100);
  if (System.currentTimeMillis() - inputBoxCursorTime > 500) {
    inputBoxCursorBlink = !inputBoxCursorBlink;
    inputBoxCursorTime = System.currentTimeMillis();
  }
  text("|", x + tsw - 25, y + h - 9);

  if (checkEnterInput()) {
    canEnterInput = false;
    return inputBoxString;
  } else if (!inputSubmitted) {
    canEnterInput = true;
  }

  return null;
}
