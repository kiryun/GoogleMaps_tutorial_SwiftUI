//
//  ContentView.swift
//  GoogleMaps_tutorial
//
//  Created by Gihyun Kim on 2020/04/07.
//  Copyright © 2020 wimes. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    
    var body: some View {
        NavigationView{
            GoogleMapView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
