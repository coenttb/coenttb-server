import Dependencies
import NIOCore
import NIOEmbedded

enum MainEventLoopGroupKey {}

extension DependencyValues {
    public var mainEventLoopGroup: any EventLoopGroup {
        get { self[MainEventLoopGroupKey.self] }
        set { self[MainEventLoopGroupKey.self] = newValue }
    }
}

extension MainEventLoopGroupKey: DependencyKey {
    public static var testValue: any EventLoopGroup { embedded }
    public static var liveValue: any EventLoopGroup { multithreaded }
}

extension MainEventLoopGroupKey {
    public static var embedded: any EventLoopGroup {
        EmbeddedEventLoop()
    }

    public static var multithreaded: any EventLoopGroup {
#if DEBUG
        return MultiThreadedEventLoopGroup(numberOfThreads: 1)
#else
        return MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
#endif
    }
}
