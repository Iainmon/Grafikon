import Foundation
import CGLFW3
import SGLOpenGL

open protocol GLBindable {
    
}

open class GLObject {

    var objectPointer: GraphicsObjectPointer = 0
    var previouslyBoundObjectPointer: GraphicsObjectPointer = 0

    var bounded = false

    open init() {

    }

    func bind() {

    }
    func unbind() {

    }
}

open class FrameBuffer: GLObject {

}