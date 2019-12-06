import Foundation

public class Translator {

    internal(set) var x: Int32
    internal(set) var y: Int32

    internal(set) var rotation: Float // In radians

    init(x: Int32, y: Int32, rotation: Float = 1.0) {
        self.x = x
        self.y = y
        self.rotation = rotation
    }

    open func cast(length: Float) {
        
    }

    open func translate(x: Int32, y: Int32) {
        self.x += x
        self.y += y
    }

    open func rotate(rotation: Float) {
        self.rotation += rotation
    }
}