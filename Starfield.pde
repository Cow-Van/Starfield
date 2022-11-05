import java.util.ListIterator;

private final float G = 6.6743 * pow(10, -11);
private final PhysicsHelper physicsHelper = new PhysicsHelper();
private final ArrayList<Particle> particles = new ArrayList();

public void setup() {
  size(500, 500);
  
  particles.add(new OddballParticle(150, 150, new Vector(1, 0), 1));
  particles.add(new Particle(300, 300, new Vector(1, 0), 1));
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
  protected Vector velocity;
  protected boolean delete = false;
  protected Vector netForce = new Vector(0, 0);
  protected Vector acceleration = new Vector(0, 0);
  
  public Particle(float x, float y, Vector velocity, float mass) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
    this.mass = mass;
  }
  
  public void move() {
    acceleration = physicsHelper.acceleration(this);
    velocity = physicsHelper.addVectors(velocity, acceleration);
    x += velocity.getX();
    y += velocity.getY();
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
  
  public Vector getNetForce() {
    return netForce;
  }
}

private class OddballParticle extends Particle {
  private final float size = 30;
  
  public OddballParticle(float x, float y, Vector velocity, float mass) {
    super(x, y, velocity, mass);
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
  
  public Vector acceleration(Particle p) {
    return new Vector(p.getNetForce().getMagnitude() / p.getMass(), p.getNetForce().getDirection());
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
