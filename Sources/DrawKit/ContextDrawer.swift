import Foundation
import CGLFW3
import SGLOpenGL

public class ContextDrawer {

    init() {

    }

    open var color: Color = Color.black {
        didSet {
            self.setColor(color)
        }
    }

    open func setColor(_ color: Color = Color.white) {
        glColor4f(color.red, color.green, color.blue, color.alpha)
    }

    open func lineWidth(_ width: Float) {
        glLineWidth(width)
    }

    open func clear(_ color: Color = Color.black) {
        glClearColor(color.red, color.green, color.blue, color.alpha)
    }

    open func background(_ color: Color = Color.black) {
        self.clear(color)
    }

    open func eraseFrame() {
        glClear(UInt32(GL_COLOR_BUFFER_BIT))
    }

    open func prepareFrame() {
        self.eraseFrame()
    }

    open func defineVertex2d(_ x: Float, _ y: Float) {
        glVertex2f(x, y)
    }

    open func defineVertex3d(_ x: Float, _ y: Float, _ z: Float) {
        glVertex3f(x, y, z)
    }

    open func beginDrawing(_ mode: GLenum = GL_QUADS) {
        glBegin(mode)
    }

    open func endDrawing() {
        glEnd()
    }

    open func draw(mode: GLenum = GL_QUADS, completion: (ContextDrawer) -> Void) {
        self.beginDrawing(mode)
        completion(self)
        self.endDrawing()
    }

}

public extension ContextDrawer {
    func rotateAxis(degrees: Float, xaxis: Float, yaxis: Float, zaxis: Float) {
        glRotatef(degrees, xaxis, yaxis, zaxis)
    }

    func rotate2d(_ degrees: Float) {
        self.rotateAxis(degrees: degrees, xaxis: 0.0, yaxis: 0.0, zaxis: 1.0)
    }

    func translate(dx: Float, dy: Float, dz: Float) {
        glTranslatef(dx, dy, dz)
    }

    func translate2d(_ x: Float, _ y: Float) {
        self.translate(dx: x, dy: y, dz: 0.0)
    }
}

public extension ContextDrawer {
    func line(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) {
        self.beginDrawing(GL_LINES)
        self.segment(x1, y1, x2, y2)
        self.endDrawing()
    }

    func segment(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) {
        self.defineVertex2d(x1, y1)
        self.defineVertex2d(x2, y2)
    }
}