//
//  WeekMenuView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 14/02/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack (alignment: .leading) {
            HStack(spacing: 4) {
                Image(systemName: "location.fill")
                Text("Taranaki St")
                    .fontWeight(.semibold)
            }
            .font(.system(size: 12))
            .foregroundColor(.orange)
            .padding(.leading, 5)
            .padding(.bottom, 5)
            List {
                NavigationLink(destination: TimetableView()) {
                    Text("Sun 15 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Mon 16 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Tue 17 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Wed 18 Feb")
                        .padding(.horizontal)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Thur 19 Feb")
                        .padding(.leading, 10)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Fri 20 Feb")
                        .padding(.leading, 10)
                }
                NavigationLink(destination: TimetableView()) {
                    Text("Sat 21 Feb")
                        .padding(.leading, 10)
                }
            }
            .navigationTitle("Lesmills NZ")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
