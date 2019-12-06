// import Foundation
// import DrawKit

// public class ApplicationWindow: LoopWindow {

//     private var angle: Float = 0.0

//     private var speed: Double = 0.001

//     private var count: Int = 10000

//     override open func setup() {

//     }

//     override open func preUpdate() {

//     }

//     override open func update() {
        
//         drawer.color = Color.yellow

//         // drawer.beginDrawing()
//         //     drawer.defineVertex2d(-0.5, -0.5)
//         //     drawer.defineVertex2d(0.5, -0.5)
//         //     drawer.defineVertex2d(0.5, 0.5)
//         //     drawer.defineVertex2d(-0.5, 0.5)
//         // drawer.endDrawing()

//         // drawer.lineWidth(0.5)
//         // drawer.rotate2d(Float( self.time * self.deltaTime * self.speed ))
//         // drawer.line(0.0, 0.0, 0.0, 600.0)

//         drawer.color = Color.red

//         self.spiral(length: 0.005, count: self.count)
//         self.count += 1

//     }

//     private func spiral(length: Float, count: Int) {

//         for n in 0..<count {

//             drawer.line(0.0, 0.0, 0.0, -length)
//             drawer.translate2d(0.0, -length)
            
//             drawer.rotate2d(45.0 + Float(n) * 0.487)

//         }

//     }

// }

// func main() {
//     try! Renderer.initializeGraphics()
//     var window = try! ApplicationWindow(width: 800, height: 800, title: "Hello World!")
//     var renderer = try! Renderer(window: window)
//     window.draw()
//     window.destroy()
//     renderer.terminate()
// }

