//
//  Todo.swift
//  TODO
//
//  Created by Youngho Kwon on 12/16/23.
//

import Foundation

struct Todo: Codable, Equatable {
    var id: Int
    var title: String
    var isCompleted: Bool
//    var category: String
}
