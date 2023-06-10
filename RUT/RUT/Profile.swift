//
//  Profile.swift
//  RUT
//
//  Created by 한상진 on 2023/06/10.
//

import Foundation

public struct Profile: Codable, Identifiable {
    public let id: UUID
    public let nickname: String
    public let description: String
    public let mbti: String
}
