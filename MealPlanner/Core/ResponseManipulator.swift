import Foundation

public extension Data {
    
    func jsonString() -> NSString {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "invalid data"
        } else {
            return NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? "invalid data"
        }
    }
}

public extension URL {
    
    var withoutQueryItems: URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.query = nil
        return components!.url!
    }
}
