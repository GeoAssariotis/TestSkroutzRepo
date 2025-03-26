import Foundation

enum InternalError: Error {
    case notSupported
    case dependencyFailed
    case networkError
}
