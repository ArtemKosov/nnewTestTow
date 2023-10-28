//
//  ContentView.swift
//  newTestTow
//
//  Created by Artem Kossov on 15.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Добро пожаловать в тест по БДД")
                NavigationLink(destination: StructView()) {
                    Text("Начать тест")
                }
            }
            .navigationBarTitle("ТЕСТ",displayMode: .inline)

        }
 
        }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
