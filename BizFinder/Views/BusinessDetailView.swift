//
//  BusinessDetailView.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/28/25.
//

import SwiftUI
import MapKit

struct BusinessDetailView: View {
    let business: Business
    
    @State var position: MapCameraPosition
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
            ScrollView {
             
                HStack {
//                    let _=print(business.imageUrl ?? "Not found!!")
                    AsyncImage(url: URL(string: business.imageUrl ?? ""))
                }
                HStack {
                    ActionButton(name: "CALL", image: "phone.circle", action: {print("call")})
                    ActionButton(name: "DIRECTIONS", image: "arrowshape.turn.up.right.circle", action: {print("directions")})
                    ActionButton(name: "SHARE", image: "square.and.arrow.up.circle", action: {print("share")})
                    ActionButton(name: "WEBSITE", image: "globe.europe.africa.fill", action: {openURL(URL(string: ((business.website != nil) ? business.website : "https://www.google.com/search?q=\(business.name)")!)!)})
                    
                }

//                    HStack {
//                        Text("OVERVIEW")
//                        Text("MENU")
//                        Text("REVIEWS")
//                        Text("PHOTOS")
//                    }

               
                    
                        VStack {
                            Map(position: $position) {
                                Annotation(business.name, coordinate: business.loc!) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .foregroundStyle(.red)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                    }
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 15))
                    
                        
                        VStack {
                            Label(business.address, systemImage: "mappin.and.ellipse.circle")
                                .font(.title3)
                                .multilineTextAlignment(.center)
                               
                                
                        }
                    
                VStack (alignment: .leading, spacing: 10){
                    Label("Hours: ", systemImage: "clock")
                        .font(.title2)
                        .bold()
                        ForEach(business.openingHours?.weekdayText ?? [], id: \.self ) { text in
                                Text(text)
                        }
                }
                .padding()
                HStack {
                    Label(business.phoneNumber, systemImage: "phone")
                        .font(.title2)
                      
                }
            }.navigationTitle("Details")
    }
}


#Preview {
    
    NavigationStack {
        BusinessDetailView(business: BusinessViewModel().bizs[3], position: .camera(
            MapCamera(
                centerCoordinate: BusinessViewModel().bizs[3].loc!,
                distance: 2500
            )))
    }
}

struct ActionButton: View {
    let name: String
    let image: String
    let action: () -> Void
    var body: some View {
        VStack {
            Button {
                //instructions
                action()
            } label: {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.black)
                    .frame(width: 70, height: 70)
            }
            Text(name)
                .font(.caption)
        }.padding(10)
            
    }
}
