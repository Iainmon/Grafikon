import Foundation
import CGLFW3
import SGLOpenGL

public struct Vertex {
    var x: GLfloat = 0.0
    var y: GLfloat = 0.0
    var z: GLfloat = 0.0

    init(_ x: GLfloat, _ y: GLfloat) {
        self.x = x
        self.y = y
    }
    init(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}