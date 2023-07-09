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
                Spacer()
                HStack {
                    Text("3665")
                        .font(.largeTitle)
                        .foregroundStyle(.accent.gradient)
                    Text("/")
                        .font(.largeTitle)
                        .foregroundStyle(.accent.gradient)
                    VStack(alignment: .leading) {
                        Text("10k")
                            .fontWeight(.bold)
                        Text("steps")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.accent.gradient)
                    Spacer()
                }
                HStack {
                    Text("Today 35%")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
            .padding([.leading, .trailing])
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
            .containerBackground(.accent.gradient, for: .navigation)
        }
    }
}

#Preview {
    ContentView()
}
