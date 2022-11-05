import java.util.ListIterator;

private final float G = 6.6743 * pow(10, -11);
private final PhysicsHelper physicsHelper = new PhysicsHelper();
private final ArrayList<Particle> particles = new ArrayList();

public void setup() {
  Vector v1 = new Vector(10, degrees(180));
  Vector v2 = new Vector(10, degrees(180));
  Vector v3 = physicsHelper.addVectors(v1, v2);
  System.out.println(v3.getMagnitude() + " " + degrees(v3.getDirection()));
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
  private final float mass;
  
  private float x;
  private float y;
  private float direction;
  private float velocity;
  private boolean delete = false;
  private float netForce = 0;
  private float acceleration = 0;
  
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
  public OddballParticle(float x, float y, float speed, float direction, float mass) {
    super(x, y, speed, direction, mass);
  }
  
  public void move() {
    
  }
  
  public void show() {
    
  }
}

private class Vector {
  private final float magnitude;
  private final float direction;
  
  public Vector(float magnitude, float direction) {
    this.magnitude = magnitude;
    this.direction = direction;
  }
  
  public float getMagnitude() {
    return magnitude;
  }
  
  public float getDirection() {
    return direction;
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
    float v1x = v1.getMagnitude() * cos(v1.getDirection());
    float v1y = v1.getMagnitude() * sin(v1.getDirection());
    float v2x = v2.getMagnitude() * cos(v2.getDirection());
    float v2y = v2.getMagnitude() * sin(v2.getDirection());
    
    float magnitude = sqrt(pow(v1x + v2x, 2) + pow(v1y + v2y, 2));
    float direction = atan((v1y + v2y)/(v1x + v2x));
    
    return new Vector(magnitude, direction);
  }
}
