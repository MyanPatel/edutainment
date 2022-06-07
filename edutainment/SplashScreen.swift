//
//  SplashScreen.swift
//  edutainment
//
//  Created by Myan Patel on 31/05/2022.
//

import SwiftUI

struct SplashScreen: View {
    
    
    @State var isActive: Bool = false
    
    let backgroundColour = Color("#8ec7ff")
    
    var body: some View {
        
        ZStack{
            
            VStack {
                // 2.
                if self.isActive {
                    // 3.
                    ContentView()
                } else {
                    ZStack{
                        backgroundColour?.ignoresSafeArea()
                        Image("image2")
                            .resizable()
                            .frame(width: 655, height: 1000)
                            .scaledToFit()
                            
                            .offset(x: +100)
                            
                        VStack{
                            Text("edutainment")
                                //.font(.largeTitle)
                                .fontWeight(.bold)
                                .font(.system(size: 60, design: .rounded))
                                .foregroundColor(.white)
                            Text("Practice your times table!")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .font(.system(size: 25, design: .rounded))
                            
                            
                        }
                        
                        
                    }.ignoresSafeArea()
                        .background()
                    
                }
            }
            
        }
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 11111111112.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}


extension Color {
    init?(_ hex: String) {
        var str = hex
        if str.hasPrefix("#") {
            str.removeFirst()
        }
        if str.count == 3 {
            str = String(repeating: str[str.startIndex], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
        } else if !str.count.isMultiple(of: 2) || str.count > 8 {
            return nil
        }
        guard let color = UInt64(str, radix: 16)
        else {
            return nil
        }
        if str.count == 2 {
            let gray = Double(Int(color) & 0xFF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if str.count == 4 {
            let gray = Double(Int(color >> 8) & 0x00FF) / 255
            let alpha = Double(Int(color) & 0x00FF) / 255
            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if str.count == 6 {
            let red = Double(Int(color >> 16) & 0x0000FF) / 255
            let green = Double(Int(color >> 8) & 0x0000FF) / 255
            let blue = Double(Int(color) & 0x0000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if str.count == 8 {
            let red = Double(Int(color >> 24) & 0x000000FF) / 255
            let green = Double(Int(color >> 16) & 0x000000FF) / 255
            let blue = Double(Int(color >> 8) & 0x000000FF) / 255
            let alpha = Double(Int(color) & 0x000000FF) / 255
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            return nil
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
