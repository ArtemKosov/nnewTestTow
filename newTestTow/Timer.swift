//
//  Timer.swift
//  json
//
//  Created by Artem Kossov on 13.09.2023.
//

import SwiftUI

struct Timerr: View {
    
    @Binding var tiMer: Int
    @Binding var score: Int
    @Binding var index: Int
    @State private var text = ""
    @State private var alert = false
    var timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    func convertSecond(second: Int) -> String {
        let minutes = second / 60
        let seconds = second % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
        var body: some View {
            VStack {
                Text(convertSecond(second: tiMer))
                    .padding()
                    .onReceive(timer) {
                        _ in
                        
                        if tiMer > 0 {
                            tiMer -= 1
                        }
                        else {
                            tiMer = 0
                            text = "Время вышло"
                            alert = true
                            
                        }
                        
                    }
                    .alert(text, isPresented: $alert) {
                        Button("Начать заново", action: restart)
                            
                            
                        
                    }
            }
        }
    func restart() {
        index = 0
        score = 0
        tiMer = 1800
    }
    }

