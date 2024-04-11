//
//  ContentView.swift
//  Blackjack
//
//  Created by 64000114 on 2/11/24.
//

import SwiftUI
//import Darwin

struct ContentView: View {
    
    @State var dealerUp = "back"
    @State var dealerDown = "back"
    @State var dealer3 = ""
    @State var dealer4 = ""
    @State var dealer5 = ""
    @State var dealer6 = ""
    
    @State var player1 = "back"
    @State var player2 = "back"
    @State var player3 = ""
    @State var player4 = ""
    @State var player5 = ""
    @State var player6 = ""
    
    @State var playerCount = 0
    @State var dealerCount = 0
    
    @State var playerNum1 = 0
    @State var playerNum2 = 0
    @State var playerNum3 = 0
    @State var playerNum4 = 0
    @State var playerNum5 = 0
    @State var playerNum6 = 0
    
    @State var dealerNum1 = 0
    @State var dealerNum2 = 0
    @State var dealerNum3 = 0
    @State var dealerNum4 = 0
    @State var dealerNum5 = 0
    @State var dearlerNum6 = 0
    
    @State var profit:Double = 0
    @State var handsWon = 0
    @State var handsLost = 0
    @State var bet:Double = 0
    
    @State var status = "Win"
    @State var j = 0
    
    @State var dealOn:Int = 1
    @State var hitOn:Int = 1
    @State var standOn:Int = 1
    @State var doubleOn:Int = 1
    @State var splitOn:Int = 1
    @State var standSplitOn = 0
    @State var splitHitOn = 0
    @State var newHandOn = 1
    @State var temp2 = 0
    @State var dealerTemp = 0

    
    var body: some View {
        ZStack{
            Image("background-cloth")
                
            
            VStack {
                
                Text("Win/Lost last hand:" + status)
                
                
                //dealer cards
                HStack{
                    Spacer()
                    Text("Dealer")
                    Spacer()
                    Text("Sum: " + String(dealerCount))
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .font(.title)
                
                HStack{
                    Spacer()
                    Image(dealerUp)
                    Spacer()
                    Image(dealerDown)
                    Spacer()
                    Image(dealer3)
                    Spacer()
                    Image(dealer4)
                    Spacer()
                    Image(dealer5)
                    Spacer()
                    Image(dealer6)
                    Spacer()
                }
                
                Image("BJ Logo")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 225.0, height: 100.0)
                
                HStack{
                    Text("Record=" + String(handsWon) + "-" + String(handsLost))
                    
                    Text("Net Profit/Loss=" + String(profit))
                } .fontWeight(.bold)
                
                //player cards
                HStack{
                    Spacer()
                    Text("Player")
                    Spacer()
                    Text("Sum: " + String(playerCount))
                    Spacer()
                }
                .foregroundColor(.white)
                .font(.title)
                
                HStack{
                    Spacer()
                    Image(player1)
                    Spacer()
                    Image(player2)
                    Spacer()
                    Image(player3)
                    Spacer()
                    Image(player4)
                    Spacer()
                    Image(player5)
                    Spacer()
                    Image(player6)
                    Spacer()
                }
                
                
                
                HStack{
                    Spacer()
                    
                    Button(
                        action: {
                            if (hitOn==1){
                                hit()
                            }else if(splitHitOn==1){
                                splitHit()
                            }},
                        label: {
                        
                            Text("Hit")
                        }).background(Rectangle().frame(width: 50.0, height: 30.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    Spacer()
                    
                    Button(
                        action: {
                            if (standOn==1){
                                stand()
                            }else if (standSplitOn==1){
                                standSplit()
                            }
                        },
                        label: {
                            Text("Stand")
                        }).background(Rectangle().frame(width: 70.0, height: 30.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    Spacer()
                    
                    Button(
                        action: { if (doubleOn==1){
                            double()
                        }
                        },
                        label: {
                            Text("Double")
                        }).background(Rectangle().frame(width: 80.0, height: 30.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    Spacer()
                    
                    Button(
                        action: {if splitOn==1{
                            split()}
                        },
                        label: {
                            Text("Split")
                        }).background(Rectangle().frame(width: 70.0, height: 30.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    Spacer()
                    
                }.frame(width: 380.0, height: 40.0).foregroundColor(.white).background(Rectangle().foregroundStyle(.gray)).cornerRadius(20)
                
                Button(action: {
                    deal()
                }, label: {
                    Image("button")
                        .padding(.vertical, -7.0)
                        
                        
                        
                        
                })
                
                
                HStack{
                    Button(action: {
                        reset()
                    }, label: {
                        Text("Reset")
                    })
                    .padding() .background(Rectangle().frame(height: 40.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    
                    
                    Button(action: {new()
                    }, label: {
                        Text("New Hand")
                    }).padding().background(Rectangle().frame(height: 40.0).cornerRadius(10).foregroundStyle(.black).shadow(radius: 10))
                    
                    Text("Current Bet: " + String(bet))
                    
                }.background(Rectangle().frame(width: 400.0).foregroundColor(.gray).ignoresSafeArea())
                
            }.foregroundColor(.white)
        }
    }
    
    
    func deal(){
        if(player1 == "back"){
            newHandOn = 0
            playerNum1 = rng()
            player1 = "card" + String(playerNum1)
            playerNum2 = rng()
            player2 = "card" + String(playerNum2)
            playerCount = face(playerNum1) + face(playerNum2)
            
            dealerNum1 = rng()
            dealerUp = "card" + String(dealerNum1)
            dealerCount = face(dealerNum1)
            
            bet += 1
            if(playerCount==21){
                profit += (1.5)*Double((bet))
                handsWon += 1
                status="Won"
                dealOn = 0
                hitOn = 0
                standOn = 0
                doubleOn = 0
                splitOn = 1
                newHandOn=1
            }
            overPlayer()
        }else{}
    }
    
    func hit() {
        if(player1 == "back"){
        }
        else if(player3 == ""){
            playerNum3 = rng()
            player3 = "card" + String(playerNum3)
            playerCount += face(playerNum3)
            
            overPlayer()
        }
        else if(player4 == ""){
            playerNum4 = rng()
            player4 = "card" + String(playerNum4)
            playerCount += face(playerNum4)
            
            overPlayer()
        }
        else if(player5 == ""){
            playerNum5 = rng()
            player5 = "card" + String(playerNum5)
            playerCount += face(playerNum5)
            
            overPlayer()
        }
        else{
            playerNum6 = rng()
            player6 = "card" + String(playerNum6)
            playerCount += face(playerNum6)
            
            overPlayer()
        }
    }
    
    
    func stand() {
        if(dealerUp == "back"){
            
        }
        else if(dealerDown == "back"){
            hitOn = 0
            splitOn = 0
            doubleOn = 0
            dealerNum2 = rng()
            dealerDown = "card" + String(dealerNum2)
            dealerCount += face(dealerNum2)
            overDealer()
        }
        else if(dealer3 == ""){
            dealerNum3 = rng()
            dealer3 = "card" + String(dealerNum3)
            dealerCount += face(dealerNum3)
            overDealer()
        }
        else if(dealer4 == ""){
            dealerNum4 = rng()
            dealer4 = "card" + String(dealerNum4)
            dealerCount += face(dealerNum4)
            overDealer()
        }
        else if(dealer5 == ""){
            dealerNum5 = rng()
            dealer5 = "card" + String(dealerNum5)
            dealerCount += face(dealerNum5)
            overDealer()
        }
        
        
        
        
    }
    
    func double() {
        bet = bet*2
        hit()
        hitOn=0
        doubleOn = 0
        splitOn = 0
    }
    
    func split() {
        if (face(playerNum1) == face(playerNum2)){
            standSplitOn = 1
            standOn = 0
            splitHitOn=1
            hitOn=0
            doubleOn=0
            splitOn=0
             temp2 = playerNum2
             dealerTemp = dealerNum1
            
            playerNum2 = rng()
            player2 = "card" + String(playerNum2)
            playerCount = face(playerNum1) + face(playerNum2)
        }
    }
    
    func standSplit (){
        hitOn = 0
        splitOn = 0
        doubleOn = 0
        splitHitOn=0
        if(dealerUp == "back"){
            
        }
        else if(dealerDown == "back"){
            hitOn = 0
            splitOn = 0
            doubleOn = 0
            dealerNum2 = rng()
            dealerDown = "card" + String(dealerNum2)
            dealerCount += face(dealerNum2)
            overSplit()
           
        }
        else if(dealer3 == ""){
            dealerNum3 = rng()
            dealer3 = "card" + String(dealerNum3)
            dealerCount += face(dealerNum3)
            overSplit()
        }
        else if(dealer4 == ""){
            dealerNum4 = rng()
            dealer4 = "card" + String(dealerNum4)
            dealerCount += face(dealerNum4)
            overSplit()
        }
        else if(dealer5 == ""){
            dealerNum5 = rng()
            dealer5 = "card" + String(dealerNum5)
            dealerCount += face(dealerNum5)
            overSplit()
        }
    }
    
    func splitHit(){
        if(dealerUp == "back"){
            
        }
//        else if(player2 == "back"){
//            hitOn = 0
//            splitOn = 0
//            doubleOn = 0
//            playerNum2 = rng()
//            player2 = "card" + String(playerNum2)
//            playerCount += face(playerNum2)
//            overSplit()
//           
//        }
        else if(player3 == ""){
            hitOn = 0
            splitOn = 0
            doubleOn = 0
            playerNum3 = rng()
            player3 = "card" + String(playerNum3)
            playerCount += face(playerNum3)
            print("here")
            overSplit()
        }
        else if(player4 == ""){
            playerNum4 = rng()
            player4 = "card" + String(playerNum4)
            playerCount += face(playerNum4)
            overSplit()
        }
        else if(player5 == ""){
            playerNum5 = rng()
            player5 = "card" + String(playerNum5)
            playerCount += face(playerNum5)
            overSplit()
        }
    }
    
    func splitNew(){
        if(j==0){
            hitOn=1
            doubleOn=1
            splitOn = 1
            standSplitOn = 1
            playerNum1 = temp2
            player1 = "card" + String(temp2)
            
            playerNum2 = rng()
            player2 = "card" + String(playerNum2)
            playerCount = face(playerNum1) + face(playerNum2)
            player3 = ""
            player4 = ""
            player5 = ""
            player6 = ""
            
            dealerUp = "card" + String(dealerTemp)
            dealerDown = "back"
            dealer3 = ""
            dealer4 = ""
            dealer5 = ""
            dealer6 = ""
            dealerCount = dealerTemp
        
            j = 1
        }else{
            dealOn = 0
            hitOn = 0
            standOn = 0
            doubleOn = 0
            splitOn = 1
            newHandOn=1
        }
    }
    
    func overSplit (){
        if(playerCount>=22){
            profit -= bet
            handsLost += 1
            status = "Lost"
            splitNew()
        }
        if(dealerCount>16){
            standSplitOn=0
//            if j == 1{
                standSplitOn = 0
            if(dealerCount>21){
                profit += bet
                handsWon += 1
                splitNew()
            }
                else{
                    if(dealerCount>playerCount){
                        profit -= bet
                        handsLost += 1
                        status = "Lost"
                        splitNew()
                    }
                    else if(dealerCount==playerCount){
                        status="Push"
                        splitNew()
                    }else{
                        profit += bet
                        handsWon += 1
                        splitNew()                    }
            }
        }
    }
    
    func rng() -> Int {
        let p = Int.random(in:2...14)
        return p
    }
    
    func overPlayer (){
        if(playerCount>21){
            lost()
        }
    }
    func overDealer (){
        if(dealerCount>16){
            if(dealerCount>21){
                win()
            }
            else{
                if(dealerCount>playerCount){
                    lost()
                }
                else if(dealerCount==playerCount){
                    status="Push"
                    push()
                }else{
                    win()
                }
        }
    }
}
    
    
    func face(_ num:Int) -> Int{
        if(num==14){
            return 11
        }
        else if(num<=10){
            return num
        }
        else{ return 10}
    }
    
    func new(){
        if(newHandOn == 1){
            player1 = "back"
            player2 = "back"
            player3 = ""
            player4 = ""
            player5 = ""
            player6 = ""
            playerCount = 0
            
            dealerUp = "back"
            dealerDown = "back"
            dealer3 = ""
            dealer4 = ""
            dealer5 = ""
            dealer6 = ""
            dealerCount = 0
            
            bet=0
            
            j=0
            dealOn = 1
            hitOn = 1
            standOn = 1
            doubleOn = 1
            splitOn = 1
        }
    }
    func lost(){
        profit -= bet
        handsLost += 1
        status = "Lost"
        dealOn = 0
        hitOn = 0
        standOn = 0
        doubleOn = 0
        splitOn = 1
        newHandOn=1
    }
    func push(){
        dealOn = 0
        hitOn = 0
        standOn = 0
        doubleOn = 0
        splitOn = 1
        newHandOn=1
    }
    
    func win(){
        profit += bet
        handsWon += 1
        status="Won"
        dealOn = 0
        hitOn = 0
        standOn = 0
        doubleOn = 0
        splitOn = 1
        newHandOn=1
    }
    
    
    func reset(){
        newHandOn = 1
        new()
        
        handsWon=0
        handsLost=0
        profit=0
        
    }
}
    
    


#Preview {
    ContentView()
}
