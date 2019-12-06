import Foundation
import CGLFW3
import SGLOpenGL

#if os(OSX)
    import OpenGL
#endif

public enum ContextWindowError: Error {
    case unableToOpenWindow
}

open class ContextWindow {

    open var renderer: Renderer!

    public var width: Int32 {
        didSet {
            glfwSetWindowSize(window, width, height)
        }
    }
    public var height: Int32 {
        didSet {
            glfwSetWindowSize(window, width, height)
        }
    }

    public var title: String

    public let window: GraphicsContextPointer!
    public let context: GraphicsContextPointer!

    public var drawer: ContextDrawer!


    public init(width: Int, height: Int, title: String = "Untitled Window", useDefaultHints: Bool = true) throws {

        if useDefaultHints {
            glfwDefaultWindowHints()
        }

        guard let window = glfwCreateWindow(Int32(width), Int32(height), title, nil, nil) else {
            throw ContextWindowError.unableToOpenWindow
        }

        self.window = window
        self.context = window

        self.drawer = ContextDrawer()

        self.width = Int32(width)
        self.height = Int32(height)
        self.title = title
    }

    open func draw() {}

    public func destroy() {
        // Destroy the window and its context
        glfwDestroyWindow(self.window)
    }

    public func checkIfWindowShouldClose() {
        glfwWindowShouldClose(self.window)
    }

    public func shouldClose() -> Bool {
        return glfwWindowShouldClose(self.window) == 1
    }

    public func checkForEvents() {
        // Poll for events
        glfwPollEvents()
    }

}