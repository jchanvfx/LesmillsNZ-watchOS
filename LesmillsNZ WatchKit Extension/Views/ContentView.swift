//
//  ContentView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 27/04/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        if (model.isLoading) {
            LoadingScreenView()
        } else {
            NavigationView {
                WeekListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model(preview: true))
    }
}
