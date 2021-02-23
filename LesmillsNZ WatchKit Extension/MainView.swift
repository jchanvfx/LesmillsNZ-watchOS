//
//  MainView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 19/02/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var fitnessClasses: FitnessClasses
    
    var body: some View {
        if fitnessClasses.isLoading {
            LoadingView()
        } else {
            NavigationView {
                DaysMenuView()
            }
//            .transition(.move(edge: .bottom))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
