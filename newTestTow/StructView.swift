//
//  StructView.swift
//  newTestTow
//
//  Created by Artem Kossov on 15.09.2023.
//

import SwiftUI

struct StructView: View {
    let answer: [Qestions] = Bundle.main.decode("questions.json")
    
    let tickets: [Tickets] = Bundle.main.decode("tickkets.json")
    @State private var score = 0
    @State private var index = 0
    
    var body: some View {
      //  NavigationView {
            List(tickets, id: \.ticket) { ticket in
                NavigationLink(destination: TicketView(ticket: ticket, question: answer)) {
                    Text(ticket.ticket)
                        .font(.headline)
                }
                .navigationBarTitle("Билеты",displayMode: .inline)
            }
     //   }
    }
}


struct TicketView: View {
    let ticket: Tickets
    let question: [Qestions]
    @State private var mistakes = 0
    @State private var index = 0
    @State var selectedAnswerIndex: Int? = nil
    @State private var didTap = false
    @State private var scoreTitle = ""
    @State private var tiMer: Int = 1800
    
    var body: some View {
        
        
        ZStack {
            GeometryReader { geometre in
                ScrollView {
                    VStack() {
                        
                        if index < ticket.ansver.count {
                            
                            let qestionIndex = ticket.ansver[index]
                            let questions = question[qestionIndex]
                            
                            
                            Text("Вопрос: \(questions.ansver)")
                            ForEach(questions.variants.indices, id: \.self) { variantIndex in
                                let variant = questions.variants[variantIndex]
                                
                                Button(action: {
                                    
                                    allert(variant, for: variantIndex)
                                    
                                }) {
                                    Text(variant)
                                        .foregroundColor(colorButton(at: variantIndex))
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.blue ,lineWidth: 2)
                                            
                                        )
                                }
                            }
                            .alert(scoreTitle, isPresented: $didTap) {
                                
                                Button("Дальше", role: .cancel) {
                                    selectedAnswerIndex = nil
                                    index += 1
                                    
                                }
                            }
                            
                        } else {
                            switch mistakes {
                            case 1:
                                Text("Молодец ты допустил \(mistakes) ошибку из 20 вопросов. Быть тебе специалистом по БДД с зарплатой 40 т.р")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.green ,lineWidth: 2)
                          )
                            case 2:
                                Text("Молодец ты допустил \(mistakes) ошибки из 20 вопросов. Быть тебе специалистом по БДД с зарплатой 40 000 т.р")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.green ,lineWidth: 2)
                          )
                            case 2...5:
                                Text("Ты допустил \(mistakes) ошибки из 20 вопросов. Не быть тебе специалистом по БДД с зарплатой 40 т.р")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.yellow ,lineWidth: 2)
                          )
                            case 5...10:
                                Text("Полегче, ты допустил \(mistakes) ошибок из 20 вопросов.")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red ,lineWidth: 2)
                          )
                            case 10...20:
                                Text("Вау, Вау, Вау,\(mistakes) ошибок из 20 вопросов. Так ты не станешь специалистом по БДД и будешь работать всю жизнь за 30 000 т.р , а ну соберись!")
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.red ,lineWidth: 2)
                          )
                                
                            default:
                                Text("Красавец! Ты ответил правильно на все 20 вопросов. Тебя ждет светлое будущее в должности специалиста по БДД или механика.")
                                  
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.green ,lineWidth: 2)
                          )  }
                        }
                        
                    }
                    .ignoresSafeArea(.all)
                    .frame(width: geometre.size.width)
                  .frame(minHeight: geometre.size.height)
                 
                }
                .scrollIndicators(.hidden)
                
            }
           .padding()
            .navigationTitle(ticket.ticket)
            .ignoresSafeArea(edges: .bottom)
            
        }
        .navigationBarItems(trailing:
                                HStack {
            Timerr(tiMer: $tiMer, score: $mistakes, index: $index)
        }
        )
    }
   
    func allert(_ selectedVariant: String, for answerIndex: Int) {
        let questionIndex = ticket.ansver[index]
        let question = question[questionIndex]
        
        if selectedVariant == question.correctAnswer {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                index += 1
                selectedAnswerIndex = nil
            }
            didTap = false
        } else {
            scoreTitle = " Не правильно!!! Правильный ответ \(question.correctAnswer)"
            didTap = true
            mistakes += 1
        }
        
        selectedAnswerIndex = answerIndex
    }
    
    
    func colorButton(at buttonIndex: Int) -> Color {
        guard let selectedAnswerIndex = selectedAnswerIndex, selectedAnswerIndex == buttonIndex else {
            return .primary
        }
        
        let questionIndex = ticket.ansver[index]
        let question = question[questionIndex]
        
        return question.variants[selectedAnswerIndex] == question.correctAnswer ? .green : .red
    }
}

struct StructView_Previews: PreviewProvider {
    static var previews: some View {
        StructView()
            .preferredColorScheme(.light)
    }
}

