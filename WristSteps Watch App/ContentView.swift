//
//  ContentView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 06.07.23.
//

import SwiftUI

struct ContentView: View {
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("Hello, world!")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings, content: {
                Text("Settings")
            })
            .padding()
            .containerBackground(.accent.gradient, for: .navigation)
        }
    }
}

#Preview {
    ContentView()
}
