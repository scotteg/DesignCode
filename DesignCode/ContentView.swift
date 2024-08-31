//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image(.image1)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .cornerRadius(20)
            
            VStack(alignment: .center) {
                Text("modern architecture, an isometric tiny house, cute illustration, minimalist, vector art, night view")
                    .font(.subheadline)
                HStack(spacing: 8) {
                    VStack(alignment: .leading) {
                        Text("Size")
                            .foregroundStyle(.secondary)
                        Text("1024x1024")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Type")
                            .foregroundStyle(.secondary)
                        Text("Upscale")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Date")
                            .foregroundStyle(.secondary)
                        Text("Today 5:19")
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(height: 44)
                
                HStack {
                    HStack {
                        Image(systemName: "ellipsis")
                        Divider()
                        Image(systemName: "sparkle.magnifyingglass")
                        Divider()
                        Image(systemName: "face.smiling")
                    }
                    .padding()
                    .frame(height: 44)
                    .overlay(
                        UnevenRoundedRectangle(topLeadingRadius: 0,
                                               bottomLeadingRadius: 20,
                                               bottomTrailingRadius: 0,
                                               topTrailingRadius: 20)
                            .strokeBorder(linearGradient)
                    )
                    .offset(x: -20, y: 20)
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.down")
                        .padding()
                        .frame(height: 44)
                        .overlay(
                            UnevenRoundedRectangle(topLeadingRadius: 20,
                                                   bottomLeadingRadius: 0,
                                                   bottomTrailingRadius: 20,
                                                   topTrailingRadius: 0)
                                .strokeBorder(linearGradient)
                        )
                        .offset(x: 20, y: 20)
                }
            }
            .padding(20)
            .background(.regularMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(linearGradient)
            )
            .cornerRadius(20)
            .padding(20)
            .offset(y: 80)
        }
        .frame(maxWidth: 400)
        .padding(20)
        .dynamicTypeSize(.xSmall ... .xLarge)
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(colors: [.clear, .primary.opacity(0.3), .clear],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}

#Preview {
    ContentView()
}
