//
//  ContentView.swift
//  WristSteps Watch App
//
//  Created by Michael Schoder on 06.07.23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text("Hello, world!")
            }
            .padding()
            .containerBackground(.accent.gradient, for: .navigation)
        }
    }
}

#Preview {
    ContentView()
}
