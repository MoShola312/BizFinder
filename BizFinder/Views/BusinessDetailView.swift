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
                    AsyncImage(url: URL(string: business.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
//                        ProgressView()
                        Image(systemName: "photo.badge.exclamationmark")
                            .font(.largeTitle)
                    }
                    .frame(height: 250)
                }
                
                HStack {
                    ActionButton(name: "CALL", image: "phone.circle", action: {
                        openURL(URL(string: "tel://\(business.phoneNumber ?? "0000000000")")!)
                    })
                    Spacer()
                    
                    ActionButton(name: "DIRECTIONS", image: "arrowshape.turn.up.right.circle", action: {print("directions")})
                    
                    Spacer()
                    
                    ActionButton(name: "SHARE", image: "square.and.arrow.up.circle", action: {
                        share()
                    })
                    
                    Spacer()
                    
                    ActionButton(name: "WEBSITE", image: "globe.europe.africa.fill", action: {
                        openURL(URL(string: business.website ?? "https://www.google.com/search?q=\(business.name)")!)
                    })
                }
                .padding(.horizontal, 16)
                
                Map(position: $position) {
                    Annotation(business.name, coordinate: business.loc!) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                            .imageScale(.large)
                            .symbolEffect(.pulse)
                    }
                }.frame(width: .infinity, height: 150)
                .clipShape(.rect(cornerRadius: 15))
                .padding(.horizontal, 16)
                  
                Label(business.address, systemImage: "mappin.and.ellipse.circle")
                    .font(.title3)
                    .padding()
                
                ratingsView
                openHoursView
           
            }.navigationTitle("\(business.name)")
    }
    
    
    func share() {
        let url = URL(string: "https://www.google.com/search?q=\(business.name)")!
        let name = "\(business.name)"
        
        
         let activityVC = UIActivityViewController(activityItems: [name, url], applicationActivities: nil)
         if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
             scene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
         }
     }
    
    
    @ViewBuilder
    var openHoursView: some View {
        HStack {
            VStack(alignment: .listRowSeparatorLeading){
                Label("Hours: ", systemImage: "clock")
                    .font(.title2)
                    .padding(.top, 10)
                ForEach(business.openingHours?.weekdayText ?? [], id: \.self ) { daysHours in
                    Text(daysHours)
                }
            }.padding(.horizontal, 16)
            Spacer()
        }
    }
    
    @ViewBuilder
    var ratingsView: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .font(.title3)
            Text(String(format: "%.1f", business.rating))
                .font(.title3)
            
            Spacer()
        }.padding(.horizontal, 16)
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
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .scaledToFit()
                    .foregroundColor(.black)
            }
            Text(name)
                .font(.caption)
        }.padding(10)
            
    }
}


