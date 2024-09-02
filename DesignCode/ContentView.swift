//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPlaying = false
    @State var time = Date.now
    @State var isActive = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(.image1)
                .resizable()
                .scaledToFill()
                .frame(height: isPlaying ? 600 : 300)
                .frame(width: isPlaying ? 393 : 360)
                .cornerRadius(isPlaying ? 0 : 20)
                .offset(y: isPlaying ? -200 : 0)
            
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
                            .symbolEffect(.pulse)
                        
                        Divider()
                        
                        Image(systemName: "sparkle.magnifyingglass")
                            .symbolEffect(.scale.up, isActive: isActive)
                        
                        Divider()
                        
                        Image(systemName: "face.smiling")
                            .symbolEffect(.bounce, value: isActive)
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
            .padding(40)
            .offset(y: isPlaying ? 220 : 80)
            
            HStack(spacing: 30) {
                Image(systemName: "wand.and.rays")
                    .frame(width: 44)
                    .symbolEffect(.variableColor.iterative.reversing,
                                  options: .speed(3))
                    .symbolEffect(.bounce, value: isPlaying)
                    .opacity(isPlaying ? 1 : 0)
                    .blur(radius: isPlaying ? 0 : 20)
                
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .frame(width: 44)
                    .contentTransition(.symbolEffect(.replace))
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            isPlaying.toggle()
                        }
                    }
                
                Image(systemName: "bell.and.waves.left.and.right.fill")
                    .frame(width: 44)
                    .symbolEffect(.bounce,
                                  options: .speed(3).repeat(3),
                                  value: isPlaying)
                    .opacity(isPlaying ? 1 : 0)
                    .blur(radius: isPlaying ? 0 : 20)
                    .onReceive(timer) { time in
                        self.time = time
                        isActive.toggle()
                    }
            }
            .frame(width: isPlaying ? 220 : 50)
            .foregroundStyle(.primary, .white)
            .font(.largeTitle)
            .padding(20)
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(linearGradient)
            )
            .cornerRadius(20)
            .offset(y: isPlaying ? 40 : -44)
        }
        .frame(maxWidth: 400)
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
