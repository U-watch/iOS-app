//
//  APIClient.swift
//  U-watch
//
//  Created by 이승규 on 12/9/24.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T
}

class APIClient {
   
    static func fetch<T: Decodable> (from path: String) async throws -> APIResponse<T> {
        guard let url = URL(string: "https://coherent-midge-probably.ngrok-free.app/api/v1/\(path)") else {
            throw CustomError.network(message: "Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("", forHTTPHeaderField: "ngrok-skip-browser-warning")
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw CustomError.network(message: error.localizedDescription)
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode / 100 != 2 {
                let dataString = String(data: data, encoding: .utf8)
                throw CustomError.response(code: httpResponse.statusCode, message: dataString ?? "")
            }
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        // Set the custom date decoding strategy
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let apiResponse: APIResponse<T>
        do {
            apiResponse = try decoder.decode(APIResponse<T>.self, from: data)
        } catch {
            throw CustomError.validation(message: error.localizedDescription)
        }
        return apiResponse
    }
}
