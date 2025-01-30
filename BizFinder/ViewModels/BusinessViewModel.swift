//
//  BusinessModel.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/7/25.
//

import Foundation
import SwiftUI


@MainActor
class BusinessViewModel: ObservableObject {
    


//enum CodingKeys: String, CodingKey {
//    case id
//    case name
//    case address
//    case phone_number
//    case rating
//    case webSite
//}


    @Published var bizs: [Business] = []
    
    init() {
        loadData()
    }
    //guard let url = URL(string: "http://www.breakingbadapi.com/api/quotes")
    func loadData() {
        //create if using API
        
        
        //create using json file
        if let url = Bundle.main.url(forResource: "sample_data_bizs", withExtension: "json") {
            do {
                //fetch using API
                //let (data,_) = try await URLSession.shared.data(from:url)
                
                //fetch using JSON file
                let data = try Data(contentsOf: url)
                
                //decode data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let allBizs = try decoder.decode([Business].self, from: data)
                self.bizs = allBizs
//                print(bizs)
            } catch {
                print("file not found: \(error)")
                
            }
        }
        
    }
}
