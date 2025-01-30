//
//  EventsModel.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/15/25.
//

import Foundation

struct Event: Decodable, Identifiable {
    var id: Int
    var name:String
    var date: String
    var time: String
    var image: String {
        "eventnoire_sample"
    }
    var venue: [String: String] = [:]
    
//    struct Venue: Decodable, Identifiable, Hashable {
//        var id: Int
//        var name: String
//        var address: String
//        var city: String
//        var state: String
//        var country: String
//    }
    
}
