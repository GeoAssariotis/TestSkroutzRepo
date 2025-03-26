import OSLog
import Alamofire

extension Request {
    
    public func debugLog(_ logger: Logger = Logger.init(subsystem: "Networking", category: "Network")) -> Self {
        self.onURLRequestCreation { request in
            logger.log(level: .debug, "-----| Request |-----")
            if let baseURL = request.url?.withoutQueryItems {
                logger.log(level: .debug, "\(request.method?.rawValue ?? "URL"): \(baseURL.absoluteString)")
            }
            logger.log(level: .debug, "- URL Params: \(request.url?.query()?.components(separatedBy: "&") ?? [])")
            logger.log(level: .debug, "- Headers: \n \(request.headers)")
            logger.log(level: .debug, "- Body: \n \(request.httpBody?.jsonString() ?? "-")")
        }
    }
}
