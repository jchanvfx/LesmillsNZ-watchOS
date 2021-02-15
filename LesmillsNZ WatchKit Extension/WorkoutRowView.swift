//
//  WorkoutRowView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 13/02/21.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct WorkoutRowView: View {
    let title: String
    let name: String
    let color: String
    let date: String
    let time: String
    let location: String
    let duration: Int
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.semibold)
            Text(location)
                .font(.system(size: 12))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex:color))
                .frame(height: 1)
            HStack {
                Text(time)
                    .padding(.leading, 2)
                Spacer()
                Text("\(duration) mins")
                    .padding(.trailing, 2)
            }.font(.system(size: 12))
        }
    }
}

struct WorkoutRowView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRowView(
            title:"BodyPump",
            name: "Test User",
            color: "#FF0000",
            date: "Sun 13 Feb",
            time: "10:00am",
            location: "Studio1",
            duration: 60
        )
    }
}
