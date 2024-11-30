//
//  APIClient.swift
//  U-watch
//
//  Created by 이승규 on 11/30/24.
//

import Foundation

class APIClient {
    static let shared = APIClient() // Singleton instance
    
    private init() {}
    
    // Fetch users from the API
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        // Define the API endpoint
        let urlString = "https://example.com/api/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Create a URL session data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Validate response status code
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let statusError = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            // Decode JSON data
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the task
        task.resume()
    }
}
