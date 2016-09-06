import java.util.ArrayList;


Graph g;

void setup() {
    size(600, 600);
    frameRate(30);

    g = new Graph();
}

void draw() {
    background(#242424);

    color c = #FFFFFF;

    g.countEdges();

    g.setNodeColor(c);
    g.setEdgeColor(c);
    g.draw();

    // print(g.getMaxDist() + "\n");
}

void mousePressed() {
    if (mouseButton == LEFT) {
        Node n = new Node(mouseX, mouseY);
        g.addNode(n);
    } else {
        g.clear();
    }
}

void mouseWheel(MouseEvent e) {
    float maxDist = g.getMaxDist();

    maxDist += -e.getCount() * 10;

    if (maxDist < 0) maxDist = 0;

    g.setMaxDist(maxDist);
}


class Graph {
    private ArrayList<Node> nodes;
    private ArrayList<Edge> edges;
    private float maxDist;  // max distance between nodes

    Graph() {
        nodes = new ArrayList();
        edges = new ArrayList();

        maxDist = 100;
    }

    public void addNode(Node n) {
        nodes.add(n);
    }

    public void addEdge(Edge e) {
        edges.add(e);
    }

    public void draw() {
        for (Node n : nodes) {
            n.draw();
        }

        for (Edge e : edges) {
            e.draw();
        }
    }

    public void setNodeColor(color c) {
        for (Node n : nodes) {
            n.setColor(c);
        }
    }

    public void setEdgeColor(color c) {
        for (Edge e : edges) {
            e.setColor(c);
        }
    }

    public void setMaxDist(float dist) {
        this.maxDist = dist;
    }

    public float getMaxDist() {
        return maxDist;
    }

    public void countEdges() {
        edges.clear();

        for (int i = 0; i < nodes.size(); i++) {
            Node curr_i = nodes.get(i);

            for (int j = 0; j < nodes.size(); j++) {
                Node curr_j = nodes.get(j);

                float dist = curr_i.getPos().dist(curr_j.getPos());

                if (dist <= maxDist) {
                    Edge e = new Edge(curr_i.getPos(), curr_j.getPos());
                    edges.add(e);
                } 
            }
        }
    }

    public void clear() {
        nodes.clear();
        edges.clear();
    }
}


class Node {
    PVector pos;
    private color c;
    private int size;

    Node (int x, int y) {
        this.pos = new PVector(x, y);
        this.c = #000000;
        this.size = 5;
    }

    Node(int x, int y, color c) {
        this.pos = new PVector(x, y);
        this.c = c;
        this.size = 5;
    }

    public void draw() {
        fill(c);
        noStroke();

        rectMode(CENTER);
        rect(pos.x, pos.y, size, size);
    }

    public void setSize(int size) {
        this.size = size;
    }

    public void setColor(color c) {
        this.c = c;
    }

    public PVector getPos() {
        return pos;
    }
}


class Edge {
    private PVector v0;
    private PVector v1;
    private color c;
    private int width;

    Edge(PVector v0, PVector v1) {
        this.v0 = v0;
        this.v1 = v1;
        this.c = #000000;
        this.width = 1;
    }

    public void setColor(color c) {
        this.c = c;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public void draw() {
        stroke(c);
        strokeWeight(width);
        line(v0.x, v0.y, v1.x, v1.y);        
    }
}
