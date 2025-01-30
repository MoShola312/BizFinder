//
//  EventsData.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/16/25.
//

import Foundation

class EventViewModel: ObservableObject {
    
    @Published var allEvents: [Event] = []
    
    
    init() {
        decodeEventData()
    }
    
    func decodeEventData() {
        
        //grab json data and set it to URL variable
        if let url = Bundle.main.url(forResource: "eventbrite_events", withExtension: "json") {
            do {
                //grab contents of the json and set it data
                let data = try Data(contentsOf: url)
                
                //create a decoder
                let decoder = JSONDecoder()
                
                //transfer keys from snake case to camel
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                //transfer json to allEvents / Event model
                let mutiEvents = try decoder.decode([Event].self, from: data)
                self.allEvents = mutiEvents
//                print(allEvents)
                
            } catch {
                //catch errors
                print("event could not be found: \(error)")
            }
        }
        
    }
    
}
