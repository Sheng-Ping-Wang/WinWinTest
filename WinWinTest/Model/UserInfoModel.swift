//
//  UserInfoModel.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import Foundation

struct UserInfo: Codable {
    let code: Int
    let message: String
    let data: OwnerData
}

// MARK: - OwnerData
struct OwnerData: Codable {
    let totalCount: Int
    let items: [OwnerItem]
}

// MARK: - OwnerItem
struct OwnerItem: Codable {
    let user: OwnerUser
    let tags: [String]
}

// MARK: - OwnerUser
struct OwnerUser: Codable {
    let nickName: OwnerNickName
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case nickName
        case imageURL = "imageUrl"
    }
}

enum OwnerNickName: String, Codable {
    case 女人的大哥 = "女人的大哥"
    case 披着羊皮的狼 = "披着羊皮的狼"
    case 笑傲江湖 = "笑傲江湖"
}
