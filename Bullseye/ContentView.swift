//
//  ContentView.swift
//  Bullseye
//
//  Created by Alysha Reinard on 1/13/20.
//  Copyright © 2020 Alysha Reinard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false
    @State var startover: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target:Int = Int.random(in: 1...100)
    @State var totalScore:Int=0
    @State var round:Int=1
    let midnightblue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0 )
    
    struct ValueStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.yellow)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size:24))
        }
    }
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size:18))
        }
    }
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size:12))
        }
    }
    struct LabelStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size:18))
        }
    }
    struct ShadowStyle: ViewModifier {
        func body(content:Content) -> some View {
            return content
            .shadow(color:Color.black, radius:5, x:2, y:2)
        }
    }

    var body: some View {
        VStack {
            // Target row
            Spacer()
            HStack {

                Text("Put the Bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())

            }
            Spacer()
            //slider view
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }.padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 40)
            
            //Game button
            HStack {
                Button(action:{

                    self.alertIsVisible = true
                    self.round+=1
                }){
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                }
                .alert(isPresented: $alertIsVisible){ () -> Alert in

                    return Alert(title: Text("\(alertTitle())"),
                                 message: Text("The slider value is \(sliderValueRounded()).\n" +
                                 "You scored \(self.pointsForCurrentRound()) points this round"),
                                 dismissButton: .default(Text("Rad!")){
                                    self.totalScore += self.pointsForCurrentRound()
                                    self.target = Int.random(in:1...100)
                                }
                    )
                }
                .background(Image("Button")).modifier(ShadowStyle())
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            HStack {
                
                Button(action:{
                    self.startover = true
                }){
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                    
                }
                .alert(isPresented: $startover){ () ->
                    Alert in
                    return Alert(title:Text("Starting over"),
                                 message:Text("Resetting score"),
                                 dismissButton: .default(Text("Good luck next round!")){
                                    self.totalScore = 0
                                    self.round=1
                                    self.sliderValue=50.0
                                    self.target = Int.random(in: 1...100)
                        }
                    )
                }
                .background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                Text("Score: ").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("INFO").modifier(ButtonSmallTextStyle())
                    }
                    
                    
                }
                .background(Image("Button")).modifier(ShadowStyle())
                
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 40)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightblue)
        .navigationBarTitle("Bullseye")
        
    }
    func sliderValueRounded()->Int{
        return Int(sliderValue.rounded())
    }
    
    func amountOff()->Int{
        return abs(sliderValueRounded() - self.target)
    }
    func pointsForCurrentRound()->Int{
        let maximumScore = 100
        var score = maximumScore - abs(sliderValueRounded() - self.target)
        if amountOff() == 0{
            score += 100
        } else if amountOff() == 1{
            score+=50
        }
        return score
    }
    func alertTitle()->String{
        let title:String
        let points = pointsForCurrentRound()
        if points == 100{
            title="Nailed it!"
        }
        else if points > 95{
            title="Nice job!"
        }
        else if points > 90{
            title = "Not bad"
        }
        else{
            title = "Keep practicing"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height:414))
    }
}
