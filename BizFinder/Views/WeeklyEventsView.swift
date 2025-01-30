//
//  WeeklyEvents.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/14/25.
//

import SwiftUI

struct WeeklyEventsView: View {
    let event = EventViewModel()
    var biz = BusinessViewModel()

    
    
    var body: some View {
        //        Text(event.allEvents)
        NavigationStack {
            List(event.allEvents) { event in
            
            VStack(alignment: .leading){
                HStack {
                    ZStack (alignment: .bottomTrailing){
                        Image(event.image)
                            .resizable()
                            .scaledToFit()
                            .opacity(0.8)
                            .frame(width: 300, height: 200)
                            .zIndex(0)
                            .disabled(true)
                        Group {
                            Spacer()
                            HStack {
                                
                                //share and like button
                                Button {
                                    //instructions
                                    print("text thumbs up")
                                } label: {
                                    Image(systemName: "hand.thumbsup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .foregroundColor(.black)
                                        .frame(width: 50, height: 50)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                                
                                Button {
                                    //instructions
                                    print("text plane")
                                } label: {
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .foregroundColor(.black)
                                        .frame(width: 50, height: 50)
                                        .background(.white)
                                        .clipShape(Circle())
                                }.border(.red)
                                
                                
                            }.padding()
                        }.zIndex(1)
                    }
                    
                }.border(.green)
                HStack {
                    //name of event
                    Text(event.name)
                        .font(.title3)
                        .bold()
                }
                HStack {
                    //day month, date
                    Text(Date.now, format: .dateTime.day().month().year())
                    Spacer()
                    VStack{
                        //time
//                        Text(Date.now, format: .dateTime.hour().minute().timeZone())
                        Text(event.time)
                    }
                }
                HStack {
                    //event
                    Text(((event.venue["name"] != nil ? event.venue["name"]  : " ")!))
             
                }
                
            }
            
        }
    }
    }
}

#Preview {
    WeeklyEventsView()
}
