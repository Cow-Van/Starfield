public final ArrayList<Particle> particles = new ArrayList();

public void setup() {
  size(500, 500);
  noStroke();
}

public void draw() {
  background(0);
  
  for (int i = particles.size() - 1; i >= 0; i--) {
    if (particles.get(i).toRemove()) {
      particles.remove(particles.get(i));
      continue;
    }
    
    particles.get(i).move();
    particles.get(i).show();
  }
}

public void mousePressed() {
  for (int i = 0; i < 20; i++) {
    particles.add(new Particle(mouseX, mouseY, 5, 18 * i));
  }
}

public class Particle {
  private final float size = 10;
  
  private float x;
  private float y;
  private float speed;
  private float direction;
  private boolean remove = false;
  
  public Particle(float x, float y, float speed, float direction) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.direction = direction;
  }
  
  public void move() {
    x += cos(direction) * speed;
    y += sin(direction) * speed;
    direction += PI * 0.0075 * speed;
    
    //if (direction > TWO_PI) {
    //  remove = true;
    //}
  }
  
  public void show() {
    ellipse(x, y, size, size);
  }
  
  public boolean toRemove() {
    return remove;
  }
}

public class OddballParticle extends Particle {
  public OddballParticle(float x, float y, float speed, float direction) {
    super(x, y, speed, direction);
  }
  
  public void move() {
    
  }
  
  public void show() {
    
  }
}
