//
//  ContentView.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/6/25.
//

import SwiftUI
import MapKit

struct LocalBusinessView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = OwnershipType.all
    @State var position: MapCameraPosition = .region(MKCoordinateRegion())
    @State var viewModel = BusinessViewModel()
    
    var filteredBizs: [Business] {
        //viewModel.filter(by: currentSelection)
        
        viewModel.sort(by: alphabetical)
        
        return viewModel.search(for: searchText)
    }
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                Map(position: $position){
                    ForEach (filteredBizs) { biz in
                        Annotation(biz.name, coordinate: biz.loc!) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .symbolEffect(.pulse)
                        }
                    }
                }.frame(height: 250)
                    .mapStyle(.standard(elevation: .realistic))
                
            }
            
            //            List(viewModel.bizs) { info in
            List(filteredBizs) { info in
                //loop
                
                NavigationLink {
                    //BusinessDetailPage
                    BusinessDetailView(business: info, position: .camera(MapCamera(centerCoordinate: info.loc!, distance: 30000)))
                } label: {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(info.name)
                                        .font(.title3)
                                        .bold()
                                }
                                HStack {
                                    Text(String(format: "%.1f", info.rating))
                                    Image(systemName: "star.fill")
                                    
                                    Link(destination: URL(string: (info.website != nil ? info.website : "https://www.google.com/search?q=\(info.name)")!)!) {
                                        Image(systemName: "google.fill")
                                            .font(.title3)
                                    }
                                    
                                }
                                HStack {
                                    info.openingHours?.openNow ?? false ? Text("Open now")
                                        .foregroundStyle(.green) : Text("Closed")
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                                
                                HStack {
                                    Text(info.address)
                                }
                                
                            }
//                            VStack (alignment: .trailing) {
//                                Image(systemName: "phone.fill")
//                                Text("CALL")
//                            }
                        }
                    }
                }
            }
            .navigationTitle("Businesses")
            .searchable(text: $searchText)
            .animation(.default,value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        if alphabetical {
                            Image(systemName: "map")
                        } else {
                            Image(systemName: "textformat")
                        }
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection) {
                            ForEach(OwnershipType.allCases) { type in
                                Label(type.displayName, systemImage: type.icon)
                                
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .task {
            updatePostion()
        }
    }
    func updatePostion() {
        position = .camera(MapCamera(centerCoordinate: filteredBizs.first?.loc ?? CLLocationCoordinate2D(), distance: 10000000, heading: 250, pitch: 80))
    }
}

#Preview {
    ContentView()
}
