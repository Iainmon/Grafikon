import Foundation

open class Window: ContextWindow {

    override open func draw() {

        let drawer = self.drawer!

        drawer.background()

        while !self.shouldClose() {

            drawer.prepareFrame()

            drawer.color = Color.yellow
            drawer.beginDrawing()
                drawer.defineVertex2d(-0.5, -0.5)
                drawer.defineVertex2d(0.5, -0.5)
                drawer.defineVertex2d(0.5, 0.5)
                drawer.defineVertex2d(-0.5, 0.5)
            drawer.endDrawing()

            self.renderer.queueNextFrameRender()

            self.checkForEvents()

        }
    
    }

}

