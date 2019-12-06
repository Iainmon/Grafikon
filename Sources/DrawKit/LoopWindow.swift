import Foundation

open class LoopWindow: ContextWindow {

    open var deltaTime: Double = 0.0

    open var time: Double {
        get {
            return ProcessInfo.processInfo.systemUptime
        }
    }

    open var stop: Bool = false

    override open func draw() {

        self.setup()

        self.drawer.background()

        while !self.shouldClose() {

            if !self.stop {

                let preFrameTime = ProcessInfo.processInfo.systemUptime

                self.preUpdate()

                self.update()

                self.renderer.queueNextFrameRender()

                self.deltaTime = (ProcessInfo.processInfo.systemUptime - preFrameTime)

                #if DEBUG
                print("Frame took \(self.deltaTime)ms")
                #endif
            }

            self.checkForEvents()
        }
    
    }


    open func setup() {}
    open func preUpdate() {
        self.drawer.prepareFrame()
    }
    open func update() {}

}