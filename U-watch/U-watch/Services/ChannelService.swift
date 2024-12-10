//
//  ChannelService.swift
//  U-watch
//
//  Created by 손동현 on 12/10/24.
//

import Foundation

class ChannelService {
    static let shared = ChannelService()

    private init() {}

    var sentimentData: SentimentData?
    var channelDetails: ChannelData?
    var channelInfo: OnBoardData?
    var superFans: [SuperFan] = []

    /// Fetches sentiment analysis data for a specific channel.
    func fetchSentimentAnalysis(forChannelId channelId: String) async throws {
        do {
            let response: APIResponse<SentimentData> = try await APIClient.fetch(from: "channel/analysis/sentiment?channelId=\(channelId)")
            sentimentData = response.data
        } catch {
            // print("Error fetching sentiment analysis: \(error.localizedDescription)")
            throw error
        }
    }

    /// Fetches channel details for a specific channel.
    func fetchChannelDetails(forChannelId channelId: String) async throws {
        do {
            let response: APIResponse<ChannelData> = try await APIClient.fetch(from: "channel/details?channelId=\(channelId)")
            channelDetails = response.data
        } catch {
            // print("Error fetching channel details: \(error.localizedDescription)")
            throw error
        }
    }

    /// Fetches onboarding channel information for a specific channel.
    func fetchChannelInfo(forMemberId memberId: Int) async throws {
        do {
            // memberId를 쿼리 매개변수로 사용
            let response: APIResponse<OnBoardData> = try await APIClient.fetch(from: "channel/info?memberId=\(memberId)")
            channelInfo = response.data
        } catch {
            throw error
        }
    }


    /// Fetches super fans for a specific channel.
    func fetchSuperFans(forChannelId channelId: String) async throws {
        do {
            let response: APIResponse<[SuperFan]> = try await APIClient.fetch(from: "channel/superfans?channelId=\(channelId)")
            superFans = response.data
        } catch {
            // print("Error fetching super fans: \(error.localizedDescription)")
            throw error
        }
    }
}
