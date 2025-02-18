//
//  Business.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/29/25.
//

import Foundation
import SwiftUI
import MapKit

struct Business: Codable, Identifiable {
 
    var name: String
    var placeId: String
    var address: String
    var rating: Double
    var phoneNumber: String?
    var imageUrl: String?
    let geometry: Geometry
    
    var category: String?
    
    var website: String?
    var owner: OwnershipType?
   
    let openingHours: OpeningHours?
    
    var image: String {
        "bronzevillewinery"
    }
 
    var id: String {
        return self.placeId
    }
    var loc: CLLocationCoordinate2D? {
        return CLLocationCoordinate2D(latitude: geometry.location.latitude, longitude: geometry.location.longitude)
    }
   
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool
    let periods: [Period]?
    let weekdayText: [String]?

//    enum CodingKeys: String, CodingKey {
//        case openNow = "open_now"
//        case periods
//        case weekdayText = "weekday_text"
//    }
}

// MARK: - Period
struct Period: Codable {
    let open: DayTime
    let close: DayTime?
}

// MARK: - DayTime
struct DayTime: Codable {
    let day: Int
    let time: String
}

enum OwnershipType: String, CaseIterable, Codable, Identifiable {
    case all
    case blackOwnedBusiness
    case minorityOwnedBusiness
    case otherOwnedBusiness
    
    var id: OwnershipType {
        self
    }
    
    var background: Color {
        switch self {
        case .blackOwnedBusiness:
                .black
        case .minorityOwnedBusiness:
                .blue
        case .otherOwnedBusiness:
                .red
        case .all:
                .gray
        }
    }
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .blackOwnedBusiness:
            "figure.wave.circle.fill"
        case .minorityOwnedBusiness:
            "figure.wave.circle.fill"
        case .otherOwnedBusiness:
            "figure.wave"
        }
    }
    
    var displayName: String {
        switch self {
        case .all:
            "All"
        case .blackOwnedBusiness:
            "Black-owned Business"
        case .minorityOwnedBusiness:
            "Minority-owned Business"
        case .otherOwnedBusiness:
            "Other"
        }
    }
    
}
