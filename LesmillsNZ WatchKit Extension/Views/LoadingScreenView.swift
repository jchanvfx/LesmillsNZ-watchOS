//
//  LoadingWheelView.swift
//  LesmillsNZ WatchKit Extension
//
//  Created by Johnny Chan on 28/04/21.
//

import SwiftUI

struct SlidingBarAnimView: View {
    let color = Color(hex:"#aa8161")
    @State private var isAnimated = false
 
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(hex: "#262626"), lineWidth: 3)
                .frame(height: 2)
            RoundedRectangle(cornerRadius: 6)
                .stroke(color, lineWidth: 3)
                .frame(width: 20, height: 3)
                .offset(x: isAnimated ? 80 : -80, y: 0)
                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: true))
        }
        .onAppear() {
            self.isAnimated = true
        }
        .onDisappear {
            self.isAnimated = false
        }
    }
}

struct LoadingScreenView: View {
    
    var body: some View {
        VStack {
            Image("LmTextLogo")
                .resizable()
                .scaledToFit()
                .colorMultiply(Color.white)
                .frame(width: 160)
            Text("NEW ZEALAND")
                .font(.system(size: 12))
                .foregroundColor(Color(hex:"#aa8161"))
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(hex:"#4f3a00"))
                .frame(height: 1)
                .padding([.top, .bottom], 5)
            Spacer()
            Text("loading classes...")
                .font(.system(size: 12))
                .foregroundColor(Color.gray)
            SlidingBarAnimView()
                .padding()
            Spacer()
            Text("www.lesmills.co.nz")
                .foregroundColor(Color(hex:"#aa8161"))
                .font(.system(size: 12))
                .padding(.top, 5)
        }
    }
}

struct LoadingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenView()
    }
}
