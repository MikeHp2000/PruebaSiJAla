import Foundation

let circle = OvalShape(width:40,height:40)

//Barreras
var barriers:[Shape]=[]
//Objetivos
var targets:[Shape]=[]

//El cañon de la bola
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]
//Mapea la zona de puntos que cumpla con las 
//condiciones de funnelPoints
let funnel = PolygonShape(points: funnelPoints)

//Lanzamiento de la bola
fileprivate func setupBall() {
    circle.position = Point(x: 250, y: 400)
    scene.add(circle)
    circle.hasPhysics = true
    circle.fillColor = .blue
    circle.isDraggable = false
    
    circle.onCollision = ballCollided(with:)
    
    scene.trackShape(circle)
    circle.onExitedScene = ballExitedScene
    
    circle.onTapped = resetGame
    
    circle.bounciness = 0.6
}

fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
	//Creacion de la barrera 
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
	//Mapea la zona de puntos que cumpla con las
	//condiciones de barrierPoints
    let barrier = PolygonShape(points: barrierPoints)
    
    barriers.append(barrier)
    
    barrier.position = position
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
    barrier.fillColor = .brown
    barrier.angle = angle
}

fileprivate func setupFunnel() {
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    funnel.onTapped = dropBall
    funnel.fillColor = .gray
    funnel.isDraggable = false
}

//Crear objetivos
func addTarget(at position: Point) {
    let targetPoints = [
        Point(x: 10, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y: 10)
    ]
    let target = PolygonShape(points: targetPoints)

    targets.append(target)
    
    target.position = position
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .yellow
    target.name = "target"
    target.isDraggable = false
    
    scene.add(target)
}

func setup() {
    setupBall()
    
    // Creacion de los tablones movibles
    addBarrier(at: Point(x: 175, y: 100), width: 80, height: 25, angle: 0.1)
    addBarrier(at: Point(x: 100, y: 150), width: 30, height: 15, angle: -0.2)
    addBarrier(at: Point(x: 325, y: 150), width: 100, height: 25, angle: 0.3)

    //Cañon
    setupFunnel()
    
    //Añadir objetivos en la zona
    addTarget(at: Point(x: 184, y: 563))
    addTarget(at: Point(x: 238, y: 624))
    addTarget(at: Point(x: 269, y: 453))
    addTarget(at: Point(x: 213, y: 348))
    addTarget(at: Point(x: 113, y: 267))

    resetGame()
    
	//Se imprime en la consola
    scene.onShapeMoved = printPosition(of:)
}

//Funcion que lanza la bola
func dropBall() {
    circle.position = funnel.position
    circle.stopAllMotion()
    
    for barrier in barriers {
        barrier.isDraggable = false
    }
    
    for target in targets {
        target.fillColor = .yellow
    }
}

//Colision de la bola con los objetivos
//los cambia de color al tocarlos
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    
    otherShape.fillColor = .green
}

func ballExitedScene() {
    for barrier in barriers {
        barrier.isDraggable = true
    }
    
    var hitTargets = 0
    for target in targets {
        if target.fillColor == .green {
            hitTargets += 1
        }
    }
    
    if hitTargets == targets.count {
        scene.presentAlert(text: "You won!", completion: alertDismissed)
    }
}

func alertDismissed() {
}

func resetGame() {
    circle.position = Point(x: 0, y: -80)
}

func printPosition(of shape: Shape) {
    print(shape.position)
}