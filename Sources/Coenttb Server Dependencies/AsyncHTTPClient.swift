import AsyncHTTPClient
import Dependencies

enum HTTPClientKey {}

extension DependencyValues {
    public var httpClient: HTTPClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}

extension HTTPClientKey: DependencyKey {
    public static var liveValue: HTTPClient { .default }
    public static var testValue: HTTPClient { .default }
}

extension HTTPClient {
    public static var `default`: HTTPClient {
        @Dependency(\.mainEventLoopGroup) var eventLoopGroup
        return HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))
    }
}
