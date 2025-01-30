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
    
    @State var viewModel = BusinessViewModel()
    
    var body: some View {
       
        NavigationStack {
            
            VStack (){
                Map(){
                    
                }.frame(height: 250)
                    .mapStyle(.standard(elevation: .realistic))
                
            }.border(.blue)
            Spacer()
            List(viewModel.bizs) { info in
                //loop
                
                NavigationLink {
                    //BusinessDetailPage
                    BusinessDetailView(business: info)
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
                                    Text(info.category)
                                    
                                }
                                HStack {
                                    Text(info.address)
                                }
                                HStack {
                                    
                                    Text("\(info.website)")
                                }
                                HStack {
                                    Text("Closes soon -")
                                    
                                }
                                
                            }
                            Spacer()
                            VStack {
                                Image(systemName: "phone.fill")
                                Text("CALL")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Businesses")
            .searchable(text: $searchText)
            .animation(.default,value: searchText)
            
            
        }
    }
    
    //        .padding()
}


#Preview {
    ContentView()
}
