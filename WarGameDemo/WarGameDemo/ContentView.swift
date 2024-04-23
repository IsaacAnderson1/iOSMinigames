//
//  ContentView.swift
//  WarGameDemo
//
//  Created by 64000114 on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard = "card7"
    @State var cpuCard = "card12"
    
    @State var playerScore = 0
    @State var cpuScore = 0
    
    var body: some View {
        
        ZStack{
            Image("background-cloth")
            VStack {
                Image("logo")
                HStack{
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                .padding(30)
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }

                
                HStack{
                    Spacer()
                    VStack{
                        Text("Player")
                            .font(.title)
                            .padding(.bottom, 10)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    .foregroundColor(.white)
                    Spacer()
                    VStack{
                        Text("CPU")
                            .font(.title)
                            .padding(.bottom, 10)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                            
                    }
                    .foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
    
    func deal(){
        // Randomize player's card
        var playerCardValue = Int.random(in: 2...14)
        playerCard = "card" + String(playerCardValue)
        
        // Randomize cpu's card
        var cpuCardValue = Int.random(in: 2...14)
        cpuCard = "card" + String(cpuCardValue)
        
        // Update Score
        if playerCardValue > cpuCardValue {
            playerScore += 1
        }
        else if playerCardValue < cpuCardValue {
            cpuScore += 1
        }
        
    }
}



#Preview {
    ContentView()
}
