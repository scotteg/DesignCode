//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            title
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 60) {
                ForEach(cards) { card in
                    CardView(card: card)
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                                .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60),
                                                  axis: (x: 1, y: 1, z: 0))
                                .blur(radius: phase.isIdentity ? 0 : 60)
                                .offset(x: phase.isIdentity ? 0 : -200)
                        }
                }
            }
            .scrollTargetLayout()
            .padding(.bottom, 100)
        }
        .scrollTargetBehavior(.viewAligned)
    }

    var title: some View {
        VStack(alignment: .leading) {
            Text("Explore")
                .font(.largeTitle)
                .bold()
            Text("\(Date.now.formatted(date: .complete, time: .omitted))")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
