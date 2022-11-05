import java.util.Iterator;

private final float G = 6.6743 * 0.01;
private final PhysicsHelper physicsHelper = new PhysicsHelper();
private final ArrayList<Particle> particles = new ArrayList();

public void setup() {
  size(500, 500);
  background(0);
  noStroke();
  
  particles.add(new OddballParticle(250, 250, new Vector(0, 0), 100, 10));
  
  for (int i = 0; i < 20; i++) {
    particles.add(new Particle((float) Math.random() * width, (float) Math.random() * height, new Vector((float) Math.random() * 2, (float) Math.random() * TWO_PI), 10, (float) Math.random() * 3 + 4));
  }
}

public void draw() {
  fill(0, 0, 0, 25);
  rect(0, 0, width, height);
  
  Iterator<Particle> particlesIterator = particles.iterator();
  
  while(particlesIterator.hasNext()) {
    Particle particle = particlesIterator.next();
    
    if (particle.toDelete()) {
      particles.remove(particle);
      particlesIterator = particles.iterator();
    } else {
      particle.move();
      particle.show();
    }
  }
  
  while (particles.size() < 20) {
    particles.add(new Particle((float) Math.random() * width, (float) Math.random() * height, new Vector((float) Math.random() * 2, (float) Math.random() * TWO_PI), 10, (float) Math.random() * 3 + 2));
  }
}

private class Particle {
  protected final float size = 15;
  protected final float mass;
  protected final float speed;
  
  protected float x;
  protected float y;
  protected Vector velocity;
  protected boolean delete = false;
  protected Vector netForce = new Vector(0, 0);
  protected Vector acceleration = new Vector(0, 0);
  
  public Particle(float x, float y, Vector velocity, float mass, float speed) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
    this.mass = mass;
    this.speed = speed;
  }
  
  public void move() {
    for (int i = 0; i < particles.size(); i++) {
      if (particles.get(i) instanceof OddballParticle) {
        netForce = physicsHelper.addVectors(netForce, physicsHelper.gravitationalForce(this, particles.get(i)));
      }
    }
    
    acceleration = physicsHelper.acceleration(this);
    
    velocity = physicsHelper.addVectors(velocity, acceleration);
    x += velocity.getX() * speed;
    y += velocity.getY() * speed;
    
    if (x < -100 || y < -100 || x > width + 100 || y > height + 100) {
      delete = true;
    }
  }
  
  public void show() {
    fill(255);
    ellipse(x, y, size, size);
  }
  
  public boolean toDelete() {
    return delete;
  }
  
  public float getMass() {
    return mass;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public Vector getNetForce() {
    return netForce;
  }
}

private class OddballParticle extends Particle {
  private final float size = 30;
  
  public OddballParticle(float x, float y, Vector velocity, float mass, float speed) {
    super(x, y, velocity, mass, speed);
  }
  
  public void move() {
    
  }
  
  public void show() {
    fill(0, 128, 128);
    ellipse(x, y, size, size);
  }
}

private class Vector {
  private final float magnitude;
  private final float direction;
  private final float x;
  private final float y;
  
  public Vector(float magnitude, float direction) {
    this.magnitude = magnitude;
    this.direction = direction;
    this.x = magnitude * cos(direction);
    this.y = magnitude * sin(direction);
  }
  
  public float getMagnitude() {
    return magnitude;
  }
  
  public float getDirection() {
    return direction;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
}

private class PhysicsHelper {
  public PhysicsHelper() {}
  
  public Vector gravitationalForce(Particle p1, Particle p2) {
    return new Vector(G * p1.getMass() * p2.getMass() / pow(dist(p1.getX(), p1.getY(), p2.getX(), p2.getY()), 2), xyVector(p2.getX() - p1.getX(), p2.getY() - p1.getY()).getDirection());
  }
  
  public Vector acceleration(Particle p) {
    return new Vector(p.getNetForce().getMagnitude() / p.getMass(), p.getNetForce().getDirection());
  }
  
  public Vector addVectors(Vector v1, Vector v2) {
    return xyVector(v1.getX() + v2.getX(), v1.getY() + v2.getY());
  }
  
  public Vector xyVector(float x, float y) {
    float magnitude = sqrt((x * x) + (y * y));
    
    if (magnitude == 0) {
      return new Vector(0, 0);
    }
    
    float direction = (y < 0) ? -acos(x / magnitude) : acos(x / magnitude);
    return new Vector(magnitude, direction);
  }
}
