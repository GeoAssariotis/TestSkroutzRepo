import Foundation
import Alamofire


class MainNetworkClient: NetworkClient {
    
    private var savedToken: String?

    func login(username: String, password: String) async throws -> APISession {
        
//        try await performRequest(endpoint: "", method: .post, responseValueType: String())
        guard let url = URL(string: "https://whale-app-jrqfx.ondigitalocean.app/v1/user/login") else {
            throw InternalError.dependencyFailed
        }
        let headers: HTTPHeaders = [.authorization(username: username, password: password)]
        let request = AF
            .request(
                url,
                method: .post,
                encoding: JSONEncoding(),
                headers: headers
            )
            .debugLog()
            .response{ response in
                guard let data = response.data else { debugPrint("Unable to process data") ; return }
                let jsonResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                debugPrint(jsonResponse as Any)
            }
        let response = try await request
            .serializingDecodable(APISession.self)
            .value
        return response
    }
    
    func performRequest<ResponseValue: Decodable>(
            endpoint: String,
            method: HTTPMethod,
            responseValueType: ResponseValue.Type
        ) async throws -> ResponseValue {
            let url = URL(string: "http://localhost:5000/\(endpoint)")!
            let headers: HTTPHeaders = [.authorization(
                username: "pariloas@curlybrac.com",
                password: "4fY-kbH-bVE"
            )]
            return try await AF.request(url, method: method, headers: headers)
                .debugLog()
                .serializingDecodable(ResponseValue.self)
                .value
        }
        
        func fetchMeals(week: String) {
            
        }
        
        func favouriteMeal(mealName: String) {
        }
        
        func saveToken(token: String) {
            
        }
}
