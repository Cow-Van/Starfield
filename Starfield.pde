import java.util.ListIterator;

private final float G = 6.6743 * pow(10, -11);
private final PhysicsHelper physicsHelper = new PhysicsHelper();
private final ArrayList<Particle> particles = new ArrayList();

public void setup() {
  size(500, 500);
  
  particles.add(new OddballParticle(150, 150, 1, 0, 1));
  particles.add(new Particle(300, 300, 1, 0, 1));
}

public void draw() {
  ListIterator<Particle> particlesIterator = particles.listIterator();
  
  while(particlesIterator.hasNext()) {
    Particle particle = particlesIterator.next();
    
    if (particle.toDelete()) {
      particles.remove(particle);
      particlesIterator = particles.listIterator();
    } else {
      particle.move();
      particle.show();
    }
  }
}

private class Particle {
  protected final float size = 15;
  protected final float mass;
  
  protected float x;
  protected float y;
  protected float direction;
  protected float velocity;
  protected boolean delete = false;
  protected float netForce = 0;
  protected float acceleration = 0;
  
  public Particle(float x, float y, float velocity, float direction, float mass) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
    this.direction = direction;
    this.mass = mass;
  }
  
  public void move() {
    
  }
  
  public void show() {
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
  
  public float getNetForce() {
    return netForce;
  }
}

private class OddballParticle extends Particle {
  private final float size = 30;
  
  public OddballParticle(float x, float y, float speed, float direction, float mass) {
    super(x, y, speed, direction, mass);
  }
  
  public void move() {
    
  }
  
  public void show() {
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
  
  public float gravitionalForce(Particle p1, Particle p2) {
    return G * p1.getMass() * p2.getMass() / pow(dist(p1.getX(), p1.getY(), p2.getX(), p2.getY()), 2);
  }
  
  public float acceleration(Particle p) {
    return p.getNetForce() / p.getMass();
  }
  
  public Vector addVectors(Vector v1, Vector v2) {
    return xyVector(v1.getX() + v2.getX(), v1.getY() + v2.getY());
  }
  
  public Vector xyVector(float x, float y) {    
    float magnitude = sqrt(x * x + y * y);
    float direction = (y < 0) ? -acos(x / magnitude) : acos(x / magnitude);
    return new Vector(magnitude, direction);
  }
}
