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
    

    @Published var bizs: [Business] = []
    @Published var allBizs: [Business] = []
    
    init() {
        loadData()
    }
    
    

    //guard let url = URL(string: "http://www.breakingbadapi.com/api/quotes")
    func loadData() {
        //create if using API
        
        
        //create using json file
        if let url = Bundle.main.url(forResource: "sample_data_bizs3", withExtension: "json") {
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
    
    func search(for searchTerm: String) -> [Business] {
        if searchTerm.isEmpty {
            return bizs
        } else {
            return bizs.filter { biz in
                biz.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        bizs.sort { biz1, biz2 in
            if alphabetical {
                return biz1.name < biz2.name
            } else {
                //change to distance later
                return biz1.name > biz2.name
            }
        }
    }
    
//    func filter(by owner: OwnershipType) {
//        if owner == .all {
//            bizs = allBizs
//        } else {
//            bizs = allBizs.filter { biz in
//                biz.owner == owner
//            }
//        }
//    }
}
