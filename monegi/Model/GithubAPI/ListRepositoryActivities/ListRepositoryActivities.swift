//
//  ListRepositoryActivities.swift
//  monegi
//
//  Created by Minseong Kang on 10/29/23.
//

struct ListRepositoryActivities: Decodable {
    var id: Int
    // activity 가 된 날짜
    var timestamp: String
    // push, force_push, branch_creation, branch_deletion, pr_merge, merge_queue_merge 중 하나
    var activityType: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case activityType = "activity_type"
    }
}
