//
//  AboutView.swift
//  Bullseye
//
//  Created by Alysha Reinard on 1/14/20.
//  Copyright © 2020 Alysha Reinard. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let perfection = Color(red: 1, green: 0.84, blue: 0.7)
    struct TextStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size:16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
        }
    }
    struct HeadingStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size:30))
        }
    }
    var body: some View {
        Group{
            VStack{
                Text("🎯 Bullseye 🎯")
                .padding(.bottom, 20)
                .padding(.top, 20)
                .modifier(HeadingStyle())
                
                Text("This is Bullseye, a game where you can earn points and fame by dragging a slider.").modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target.").modifier(TextStyle())
                Text("Bonus points of 100 for a perfect round and 50 for being one value off").modifier(TextStyle())
                Text("Enjoy").modifier(TextStyle())

            }
            .navigationBarTitle("About")
            .background(perfection)
            
        }
    .background(Image("Background"))
    }

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height:414))
    }
}
