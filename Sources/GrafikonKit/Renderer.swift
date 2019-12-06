import Foundation
import CGLFW3
import SGLOpenGL




open class RenderTarget {
    
    public var frameBuffer: GraphicsObjectPointer = 0

    public var renderingOutput: GraphicsObjectPointer = 0

    public var depthRenderBuffer: GraphicsObjectPointer = 0

    public let width: GLsizei
    public let height: GLsizei

    public var parentFrameBuffer: GraphicsObjectPointer

    public let gpuInitilizationFailed: Bool

    private var bounded = false

    open init(width: GLsizei, height: GLsizei) {

        self.width = width
        self.height = height

        self.parentFrameBuffer = RenderTarget.currentFrameBuffer()

        glGenFramebuffers(1, &self.frameBuffer)
        glBindFramebuffer(GL_FRAMEBUFFER, self.frameBuffer)

        glGenTextures(1, &self.renderingOutput)
        glBindTexture(GL_TEXTURE_2D, self.renderingOutput)

        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.width, self.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, 0)

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)

        glGenRenderbuffers(1, &self.depthRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, self.depthRenderBuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, self.width, self.height);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, self.depthRenderBuffer);
        
        glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, renderedTexture, 0)

        var frameBufferAttachmentLocations: [GLenum] = [ GL_COLOR_ATTACHMENT0 ]
	    glNamedFramebufferDrawBuffers(self.frameBuffer, 1, &frameBufferAttachmentLocations) // OR! glDrawBuffers

        self.gpuInitilizationFailed = glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE

        glBindFramebuffer(GL_FRAMEBUFFER, self.parentFrameBuffer) // Sets current frame buffer back to old one

    }

    public func bind() {
        glBindFramebuffer(GL_FRAMEBUFFER, self.frameBuffer)
        self.bounded = true
    }

    public func unbind() {
        glBindFramebuffer(GL_FRAMEBUFFER, self.parentFrameBuffer)
        self.bounded = false
    }

    public func render() {
        glViewport(GL_ZERO, GL_ZERO, self.width, self.height)
    }

    public static func currentFrameBuffer() -> GraphicsObjectPointer {
        var currentFrameBufferID: GraphicsObjectPointer = 0
        glGetIntegerv(GL_FRAMEBUFFER_BINDING, &currentFrameBufferID)
        return currentFrameBufferID
    }

    public static let fullscreenQuadVertexLocations: GLfloat = [
        -1.0, -1.0, 0.0,
		 1.0, -1.0, 0.0,
		-1.0,  1.0, 0.0,
		-1.0,  1.0, 0.0,
		 1.0, -1.0, 0.0,
		 1.0,  1.0, 0.0,
    ]

}

protocol Renderable {

    var shader: Shader?

    func preRender()
    func render(target: GraphicsObjectPointer)
    func postRender()
}

// Drawer object will instantiate this when it's line, circle, ... is called
open class RenderObject: Renderable {

    open var mode: VertexMode

    open var shader: Shader?

    open var drawInstructions: ((RenderObject) -> Void)?

    open var verticies: [Vertex] = []
    open var indicies: [GLuint] = []

    open init(_ mode: VertexMode = .triangles, verticies: [Vertex]?) {
        self.mode = mode
        if let verticies = verticies {
            self.verticies = verticies
        }
    }

    private var VAO: GraphicsObjectPointer = 0
    private var VAO: GraphicsObjectPointer = 0

    public func preRender() {

        var primitiveVerticies: GLfloat = []

        for vertex in self.verticies {
            primitiveVerticies.append(vertex.x)
            primitiveVerticies.append(vertex.y)
            primitiveVerticies.append(vertex.z)
        }

        if self.indices.isEmpty {
            self.indices = [GLuint](0..<self.verticies.count)
        }

        glGenVertexArrays(n: 1, arrays: &self.VAO)
        glGenBuffers(n: 1, buffers: &self.VBO)
        glGenBuffers(n: 1, buffers: &self.EBO)
        glBindVertexArray(self.VAO)

        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: self.VBO)
        glBufferData(
            target: GL_ARRAY_BUFFER,
            size: MemoryLayout<GLfloat>.stride * primitiveVerticies.count,
            data: primitiveVerticies,
            usage: GL_STATIC_DRAW
        )
        glBindBuffer(target: GL_ELEMENT_ARRAY_BUFFER, buffer: self.EBO)
        glBufferData(
            target: GL_ELEMENT_ARRAY_BUFFER, 
            size: MemoryLayout<GLuint>.stride * self.indices.count,
            data: self.indices,
            usage: GL_STATIC_DRAW
        )

        let voidzeroPointer = UnsafeRawPointer(bitPattern: 0)

        glVertexAttribPointer(
            index: 0,
            size: 3,
            type: GL_FLOAT,
            normalized: false,
            stride: MemoryLayout<GLfloat>.stride * self.verticies.count,
            pointer: voidzeroPointer
        )
        glEnableVertexAttribArray(0)

        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: 0)
        
        glBindVertexArray(0)
    }

    public func render(target: GraphicsObjectPointer) {
        let voidzeroPointer = UnsafeRawPointer(bitPattern: 0)
        glBindVertexArray(self.VAO)
        glDrawElements(self.mode, self.indices.count, GL_UNSIGNED_INT, voidzeroPointer)
    }

    public func postRender() {

    }

    deinit () {
        glDeleteVertexArrays(1, &self.VAO)
        glDeleteBuffers(1, &self.VBO)
        glDeleteBuffers(1, &self.EBO)
    }
}

open class RenderGroup: Renderable {

    public var renderObjects: [RenderObject] = []

    public var shader: Shader?

    open init(shader: Shader?, renderObjects: [RenderObject]?) {
        self.shader = shader
        self.renderObjects = renderObjects
    }



}

open class Renderer {
    
}