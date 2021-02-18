//
//  LoadingView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 18/02/21.
//

import SwiftUI

struct LoadingView: View {
    let style = StrokeStyle(lineWidth: 8, lineCap: .round)
    let color = Color.blue
    @State var animate = false

    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.3)
                    .stroke(
                        AngularGradient(gradient: .init(colors: [color]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/), style: style)
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                
                Circle()
                    .trim(from: 0.5, to: 0.8)
                    .stroke(
                        AngularGradient(gradient: .init(colors: [Color.green]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/), style: style)
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
            }
            .frame(width: 80, height: 80)
            .onAppear() {
                self.animate.toggle()
            }
            Spacer()
                .frame(height: 20)
            Text("loading timetable...")
                .font(.caption)
                .foregroundColor(color)
            Text("www.lesmills.co.nz")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
