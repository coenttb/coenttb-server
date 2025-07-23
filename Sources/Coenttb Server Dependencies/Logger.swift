import Dependencies
import Logging
import Foundation

enum LoggerKey {}

extension DependencyValues {
    public var logger: Logger {
        get { self[LoggerKey.self] }
        set { self[LoggerKey.self] = newValue }
    }
}

extension LoggerKey: TestDependencyKey {
    public static let testValue = Logger(label: ProcessInfo.processInfo.processName)
}

extension Logger {
    @inlinable
    public func log(
        _ level: Logger.Level,
        _ message: @autoclosure () -> Logger.Message,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(
            level: level,
            message(),
            metadata: (metadata ?? [:]).merging(
                [
                    "file": "\(file)",
                    "line": "\(line)"
                ], uniquingKeysWith: { $1 }
            ),
            file: file,
            function: function,
            line: line
        )
    }
}
