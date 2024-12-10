//
//  MyService.swift
//  U-watch
//
//  Created by 손동현 on 12/10/24.
//

import Foundation

class MyService {
    static let shared = MyService()

    private init() {}

    var userData: UserData?

    /// Fetches the user's my page data based on the member ID.
    func fetchMyPage(memberId: Int) async throws {
        do {
            // API 호출은 비동기적으로 처리
            let response: APIResponse<UserData> = try await APIClient.fetch(from: "member/mypage?memberId=\(memberId)")
            userData = response.data
        } catch {
            print("Error fetching my page: \(error.localizedDescription)")
            throw error
        }
    }


}

