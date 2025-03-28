import Foundation
import Alamofire


class MainNetworkClient: NetworkClient {
    
    private var savedToken: String?
    
    func login(email: String, password: String) async throws -> APISession {
        
        var response: APISession = .init(token: "")
        
        do {
            var url = URLComponents(string: "http://localhost:5000/users/tokens/sign_in")
            
            url?.queryItems = [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]
            
            if let urlString = url?.url?.absoluteString {
                response = try await performRequest(endpoint: urlString, method: .post, responseValueType: APISession.self)
            }
        }catch {
            throw InternalError.networkError
        }
        
        return response
    }
    
    func register(email: String, password: String) async throws -> APISession {
        
        var response: APISession = .init(token: "")
        
        do {
            var url = URLComponents(string: "http://localhost:5000/users/tokens/sign_up")
            
            url?.queryItems = [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password),
                URLQueryItem(name: "password_confirmation", value: password)
            ]
            
            if let urlString = url?.url?.absoluteString {
                response = try await performRequest(endpoint: urlString, method: .post, responseValueType: APISession.self)
            }
            
        } catch {
            throw InternalError.networkError
        }
        
        return response
    }
    
    func fetchMeals(week: Int) async throws -> [Days] {
        
        
        var response: WeekPlan = .init(id: 1, days: .init())
        
        do {
            let url = "http://localhost:5000/api/v1/weeks/\(week)"
            
            response = try await performRequest(endpoint: url, method: .get, needsHeaders: true, responseValueType: WeekPlan.self)
            //            ForEach(Array(section.meals .enumerated()), id: \.offset)
            
        } catch {
            throw InternalError.networkError
        }
        
        return response.days
    }
    
    func performRequest<ResponseValue: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        needsHeaders: Bool? = false,
        responseValueType: ResponseValue.Type
    ) async throws -> ResponseValue {
        
        if needsHeaders == false{
            return try await AF.request(endpoint, method: method, parameters: parameters)
            
                .debugLog()
                .response{ response in
                    guard let data = response.data else { debugPrint("Unable to process data") ; return }
                    let jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    debugPrint(jsonResponse as Any)
                }
                .serializingDecodable(ResponseValue.self)
                .value
        } else {
            var headers: HTTPHeaders = []
            if let savedToken {
                headers["Authorization"] = "Bearer \(savedToken)"
            }
            return try await AF.request(endpoint, method: method, parameters: parameters, headers: headers)
        
            .debugLog()
            .response{ response in
                guard let data = response.data else { debugPrint("Unable to process data") ; return }
                let jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                debugPrint(jsonResponse as Any)
            }
            .serializingDecodable(ResponseValue.self)
            .value
    }
}

func favouriteMeal(mealName: String) {
}

func saveToken(token: String) {
    savedToken = token
}
}
