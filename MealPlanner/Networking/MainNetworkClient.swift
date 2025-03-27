import Foundation
import Alamofire


class MainNetworkClient: NetworkClient {
    
    private var savedToken: String?
    
    func login(username: String, password: String) async throws -> APISession {
        
        var response: APISession = .init(token: "")
        
        do {
            var url = URLComponents(string: "http://localhost:5000/users/tokens/sign_up")
            
            url?.queryItems = [
                URLQueryItem(name: "username", value: username),
                URLQueryItem(name: "password", value: password)
            ]
            
            if let urlString = url?.url?.absoluteString {
                response = try await performRequest(endpoint: urlString, method: .post, responseValueType: APISession.self)
            }
        }catch {
            throw InternalError.networkError
        }
        
//        guard let url = URL(string: "https://whale-app-jrqfx.ondigitalocean.app/v1/user/login") else {
//            throw InternalError.dependencyFailed
//        }
//        let headers: HTTPHeaders = [.authorization(username: username, password: password)]
//        let request = AF
//            .request(
//                url,
//                method: .post,
//                encoding: JSONEncoding(),
//                headers: headers
//            )
//            .debugLog()
//            .response{ response in
//                guard let data = response.data else { debugPrint("Unable to process data") ; return }
//                let jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                debugPrint(jsonResponse as Any)
//            }
//        let response = try await request
//            .serializingDecodable(APISession.self)
//            .value
        return response
    }
    
    func register(username: String, password: String) async throws -> APISession {
        
        var response: APISession = .init(token: "")
        
        do {
            var url = URLComponents(string: "http://localhost:5000/users/tokens/sign_up")
            
            url?.queryItems = [
                URLQueryItem(name: "username", value: username),
                URLQueryItem(name: "password", value: password),
                URLQueryItem(name: "password_confirmation", value: username)
            ]

            if let urlString = url?.url?.absoluteString {
                response = try await performRequest(endpoint: urlString, method: .post, responseValueType: APISession.self)
            }
            
        } catch {
            
        }
        
//        guard let url = URL(string: "https://whale-app-jrqfx.ondigitalocean.app/v1/user/login") else {
//            throw InternalError.dependencyFailed
//        }
//        let headers: HTTPHeaders = [.authorization(username: username, password: password)]
//        let request = AF
//            .request(
//                url,
//                method: .post,
//                encoding: JSONEncoding(),
//                headers: headers
//            )
//            .debugLog()
//            .response{ response in
//                guard let data = response.data else { debugPrint("Unable to process data") ; return }
//                let jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                debugPrint(jsonResponse as Any)
//            }
//        let response = try await request
//            .serializingDecodable(APISession.self)
//            .value
        return response
    }
    
    func performRequest<ResponseValue: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        responseValueType: ResponseValue.Type
    ) async throws -> ResponseValue {
//        let url = URL(string: "http://localhost:5000/\(endpoint)")!
        return try await AF.request(endpoint, method: method, parameters: parameters)
        
            .debugLog()
            .serializingDecodable(ResponseValue.self)
            .value
    }
    
    func fetchMeals(week: Int) async throws -> [WeekPlan]{
        var headers: HTTPHeaders = [
            "X-Api-Key": "PdpCSK+RbLzxhpQzn+4Vww==aLHYjgwDQ4YBEoG3",
            "Content-Type": "application/json"
        ]
        if let savedToken {
            headers["token"] = savedToken
        }
        let value = try await AF.request(
            "https://api.api-ninjas.com/v1/planets?min_distance_light_year=\(week)&max_distance_light_year=\(week)",
            headers: headers
        )
            .debugLog()
            .serializingDecodable(
                [WeekPlan].self
            ).value
        return value
    }
    
    func favouriteMeal(mealName: String) {
    }
    
    func saveToken(token: String) {
        
    }
}
