//
//  LoadingView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 18/02/21.
//

import SwiftUI

struct LoadingView: View {
    let style = StrokeStyle(lineWidth: 4, lineCap: .round)
    let color = Color(hex: "#00d6d3")
    @State private var animate = false

    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: .init(colors: [Color(hex:"#262626")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                        style: style)
                Circle()
                    .trim(from: 0.1, to: 0.4)
                    .stroke(
                        AngularGradient(
                            gradient: .init(colors: [color]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                        style: style)
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false))
                Circle()
                    .trim(from: 0.6, to: 0.9)
                    .stroke(
                        AngularGradient(
                            gradient: .init(colors: [color]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),
                        style: style)
                    .rotationEffect(Angle(degrees: animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false))
                Image("LmLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65)
            }
            .frame(width: 90, height: 90)
            .onAppear() {
                animate.toggle()
            }
            Spacer()
                .frame(height: 20)
            Text("Requesting Data...")
                .font(.caption)
                .foregroundColor(Color.blue)
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
