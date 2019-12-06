import Foundation
import CGLFW3
import SGLOpenGL

public enum GraphicsRendererError: Error {
    case unableToInitialize
    case graphicsNotInitialized
    case graphicsAlreadyInitialized
}

public typealias GraphicsContextPointer = OpaquePointer

public class Renderer {

    private static var graphicsIsInitialized = false

    public static func initializeGraphics() throws {

        if Renderer.graphicsIsInitialized {
            throw GraphicsRendererError.graphicsAlreadyInitialized
        }

        // Initializes GLFW
        if glfwInit() == 0 {
            Renderer.graphicsIsInitialized = false
            print("Failed to initialize GLFW!")
            throw GraphicsRendererError.unableToInitialize
        } else {
            Renderer.graphicsIsInitialized = true
        }
    }

    internal let context: GraphicsContextPointer!

    public let version: String

    public init(_ context: GraphicsContextPointer, printVersionInformation: Bool = true) throws {
        // if !Renderer.graphicsIsInitialized {
        //     throw GraphicsRendererError.graphicsAlreadyInitialized
        // }

        self.context = context
        glfwMakeContextCurrent(self.context)

        let version = String(cString: glGetString(GL_VERSION))
        if !version.isEmpty {
            self.version = version
        } else {
            self.version = "NULL"
        }

        if printVersionInformation {
            print(self.version)
        }
    }

    public convenience init(window: ContextWindow) throws {
        try! self.init(window.context)
        window.renderer = self
    }

    public func terminate() {
        if Renderer.graphicsIsInitialized {
            glfwTerminate()
        }
        Renderer.graphicsIsInitialized = false
    }

    deinit {
        self.terminate()
    }

    public func queueNextFrameRender() {
        glfwSwapBuffers(self.context)
    }

}
