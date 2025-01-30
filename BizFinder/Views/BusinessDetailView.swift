//
//  BusinessDetailView.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/28/25.
//

import SwiftUI

struct BusinessDetailView: View {
    let business: Business
    var body: some View {
        
            ScrollView {
             
                HStack {
                    Image(business.image)
                        .resizable()
                        .scaledToFit()
                }
                HStack {
                    Text(business.name)
                        .font(.title)
                }
//                    HStack {
//                        Text("OVERVIEW")
//                        Text("MENU")
//                        Text("REVIEWS")
//                        Text("PHOTOS")
//                    }
                HStack {
                    ActionButton(name: "CALL", image: "phone.circle", action: {print("call")})
                    ActionButton(name: "DIRECTIONS", image: "arrowshape.turn.up.right.circle", action: {print("directions")})
                    ActionButton(name: "SHARE", image: "square.and.arrow.up.circle", action: {print("share")})
                    ActionButton(name: "WEBSITE", image: "globe.europe.africa", action: {print("website")})
                    
                }
                VStack(alignment: .leading, spacing: 15.0) {
                    Label(business.address, systemImage: "mappin.and.ellipse.circle")
                        .font(.title2)
                    Label("business.time", systemImage: "clock")
                        .font(.title2)
                    Label(business.phoneNumber, systemImage: "phone")
                        .font(.title2)
                }
            }.navigationTitle("Details")
    }
}


#Preview {
    BusinessDetailView(business: BusinessViewModel().bizs[3])
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
