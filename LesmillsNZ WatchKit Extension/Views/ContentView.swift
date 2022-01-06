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
        Group {
            if (model.isLoading) {
                LoadingScreenView()
            } else {
                NavigationView {
                    WeekListView()
                }
            }
        }
        .alert(isPresented: $model.showingAlert, error: model.error) { error in
            Button("OK") {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model.preview)
    }
}
