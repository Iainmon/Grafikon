import Foundation
import DrawKit

public class ApplicationWindow: LoopWindow {

    private var angle: Float = 0.0

    private var speed: Double = 0.001

    private var count: Int = 10000

    private var shader: Shader!

    override open func setup() {
        print("Setting up shader...")

        let vertexString = """
            #version 330 core

            layout(location = 0) in vec4 in_position;

            void main()
            {
                gl_Position = in_position;
            }
        """
        let fragmentString = """
            #version 330 core
            in vec3 ourColor;

            out vec4 color;

            void main()
            {
                color = vec4(ourColor, 1.0f);
            }
        """

        self.shader = DrawKit.Shader(vertex: vertexString, fragment: fragmentString)
        print("Shader set up.")




    }

    override open func preUpdate() {

    }

    override open func update() {
        
        shader.use()
        drawer.color = Color.red

        self.spiral(length: 0.005, count: self.count)
        self.count += 1

    }

    private func spiral(length: Float, count: Int) {

        for n in 0..<count {

            drawer.line(0.0, 0.0, 0.0, -length)
            drawer.translate2d(0.0, -length)
            
            drawer.rotate2d(45.0 + Float(n) * 0.487)

        }

    }

}

func main() {
    try! Renderer.initializeGraphics()
    let window = try! ApplicationWindow(width: 800, height: 800, title: "Hello World!")
    let renderer = try! Renderer(window: window)
    window.draw()
    window.destroy()
    renderer.terminate()
}

main()