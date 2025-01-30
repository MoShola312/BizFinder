//
//  Business.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/29/25.
//

import Foundation
struct Business: Codable, Identifiable {
    
    
    var id: Int
    var name: String
    var category: String
    var address: String
    var rating: Double
    var website: URL
    var phoneNumber: String
    var image: String {
        "bronzevillewinery"
    }
}
