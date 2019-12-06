import Foundation
import CGLFW3
import SGLOpenGL

public typealias GraphicsObjectPointer = GLuint

public let zerovoidPointer = UnsafeRawPointer(bitPattern: 0)

public enum VertexMode: GLenum {
    case points = GL_POINTS
    case lines = GL_LINES
    case lineStrip = GL_LINE_STRIP
    case lineLoop = GL_LINE_LOOP
    case triangles = GL_TRIANGLES
    case triangleStrip = GL_TRIANGLE_STRIP
    case triangleFan = GL_TRIANGLE_FAN
    case quads = GL_QUADS
    case quadStrip = GL_QUAD_STRIP
    case polygon = GL_POLYGON
}

public enum ObjectType: GLenum {
    case buffer = GL_BUFFER
    case shader = GL_SHADER
    case program = GL_PROGRAM
    case vertexArray = GL_VERTEX_ARRAY
    case query = GL_QUERY
    case programPipeline = GL_PROGRAM_PIPELINE
    case transformFeedback = GL_TRANSFORM_FEEDBACK
    case sampler = GL_SAMPLER
    case texture = GL_TEXTURE
    case renderbuffer = GL_RENDERBUFFER
    case frameBuffer = GL_FRAMEBUFFER
}

