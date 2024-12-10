//
//  AnalysisService.swift
//  U-watch
//
//  Created by 이승규 on 12/7/24.
//

import Foundation
import DGCharts

class AnalysisService {
    static let shared = AnalysisService()
    private init() {}
    
    var results = [String: AnalysisResult]()
    
    func getResult(for video: Video) async throws -> AnalysisResult {
        let analysisResponse: APIResponse<VideoAnalysis>
        do {
            analysisResponse = try await APIClient.fetch(from: "video/analysis?videoId=\(video.videoId)")
        } catch {
            throw error
        }
        let topKeywordsResponse: APIResponse<TopKeywords>
        do {
            topKeywordsResponse = try await APIClient.fetch(from: "video/keywords?videoId=\(video.videoId)")
        } catch {
            throw error
        }
        let videoInfoResponse: APIResponse<VideoInfo>
        do {
            videoInfoResponse = try await APIClient.fetch(from: "video/info?videoId=\(video.videoId)")
        } catch {
            throw error
        }
        let trendResponse: APIResponse<CommentsTrend>
        do {
            trendResponse = try await APIClient.fetch(from: "video/comments/trend/interval?videoId=\(video.videoId)")
        } catch {
            throw error
        }
        
        let calendar = Calendar.current
        var commentCountHistory = [Date: Int]()
        var y = trendResponse.data.startedAt
        for i in 0..<20 {
            commentCountHistory[y] = trendResponse.data.commentCount[i]
            y = calendar.date(byAdding: .minute, value: trendResponse.data.interval, to: y)!
        }

        results[video.videoId] = AnalysisResult(analysisDate: videoInfoResponse.data.lastUpdated,
                              commentCountHistory: commentCountHistory,
                              wordCloundUrl: videoInfoResponse.data.wordCloudUrl,
                              topKeywords: [
                                TopKeyword(keyword: topKeywordsResponse.data.topKeyword1, grade: Grade.first, count: topKeywordsResponse.data.topKeyword1Count),
                                TopKeyword(keyword: topKeywordsResponse.data.topKeyword2, grade: Grade.second, count: topKeywordsResponse.data.topKeyword2Count),
                                TopKeyword(keyword: topKeywordsResponse.data.topKeyword3, grade: Grade.third, count: topKeywordsResponse.data.topKeyword3Count),
                              ],
                              positiveGauge: analysisResponse.data.positiveRate,
                              countByEmotion: [
                                CommentEmotion.joy: analysisResponse.data.sentimentDistribution.JOY,
                                CommentEmotion.anger: analysisResponse.data.sentimentDistribution.ANGER,
                                CommentEmotion.sadness: analysisResponse.data.sentimentDistribution.SADNESS,
                                CommentEmotion.suprise: analysisResponse.data.sentimentDistribution.SURPRISE,
                                CommentEmotion.fear: analysisResponse.data.sentimentDistribution.FEAR,
                                CommentEmotion.disgust: analysisResponse.data.sentimentDistribution.DISGUST,
                              ],
                              countByCategory: [
                                CommentCategory.reaction: analysisResponse.data.categoryDistribution.REACTION,
                                CommentCategory.feedback: analysisResponse.data.categoryDistribution.FEEDBACK,
                                CommentCategory.question: analysisResponse.data.categoryDistribution.QUESTION,
                                CommentCategory.spam: analysisResponse.data.categoryDistribution.SPAM,
                                CommentCategory.curse: analysisResponse.data.categoryDistribution.INSULT,
                              ])
        
        return results[video.videoId]!
    }
}
