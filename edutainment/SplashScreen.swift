//
//  SplashScreen.swift
//  edutainment
//
//  Created by Myan Patel on 31/05/2022.
//

import SwiftUI

struct SplashScreen: View {
    
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                // 3.
                ContentView()
            } else {
                // 4.
                Text("edutainment")
                    .font(Font.largeTitle)
                    .fontWeight(.bold)
                Text("Practice your times table!")
            }
        }.padding()
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
