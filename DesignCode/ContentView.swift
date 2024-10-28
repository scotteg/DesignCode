//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                ForEach(0 ..< 5) { item in
                    CardView()
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                .blur(radius: phase.isIdentity ? 0 : 10)
                                .rotationEffect(.degrees(phase.isIdentity ? 0 : -30))
                                .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 60),
                                                  axis: (x: 1, y: 1, z: 0))
                                .offset(x: phase.isIdentity ? 0 : -200)
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
