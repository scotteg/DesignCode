//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    struct AnimationValues {
        var position: CGPoint = .zero
        var scale: Double = 1
    }
    
    @State var isPlaying = false
    @State var time = Date.now
    @State var isActive = false
    @State var isDownloading = false
    
    let startDate = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TimelineView(.animation) { context in
            ZStack {
                TimelineView(.animation) { context in
                    Image(.image1)
                        .resizable()
                        .scaledToFill()
                        .frame(height: isPlaying ? 600 : 300)
                        .frame(width: isPlaying ? 393 : 360)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .colorEffect(
                                    ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow))
                                )
                                .blendMode(.softLight)
                        }
                        .layerEffect(ShaderLibrary.emboss(.float(10)), maxSampleOffset: .zero)
                        .layerEffect(ShaderLibrary.pixellate(.float(10)), maxSampleOffset: .zero)
                        .cornerRadius(isPlaying ? 0 : 20)
                        .offset(y: isPlaying ? -200 : 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(linearGradient)
                                .opacity(isPlaying ? 0 : 1)
                        )
                        .phaseAnimator([1, 2], trigger: isPlaying) { content, phase in
                            content.blur(radius: phase == 2 ? 100 : 0)
                        }
                }
                
                Circle()
                    .fill(.thinMaterial)
                    .frame(width: 100)
                    .overlay(Circle().stroke(.secondary))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    )
                    .keyframeAnimator(
                        initialValue: AnimationValues(),
                        trigger: isDownloading
                    ) { content, value in
                        content.offset(x: value.position.x, y: value.position.y)
                            .scaleEffect(value.scale)
                    } keyframes: { value in
                        KeyframeTrack(\.position) {
                            SpringKeyframe(
                                CGPoint(x: 100, y: -100),
                                duration: 0.5,
                                spring: .bouncy
                            )
                            
                            CubicKeyframe(CGPoint(x: 400, y: 1000), duration: 0.5)
                        }
                        
                        KeyframeTrack(\.scale) {
                            CubicKeyframe(1.2, duration: 0.5)
                            CubicKeyframe(1, duration: 0.5)
                        }
                    }
                
                
                content
                    .padding(20)
                    .background(.regularMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(linearGradient)
                    )
                    .cornerRadius(20)
                    .padding(40)
                    .offset(y: isPlaying ? 220 : 80)
                    .phaseAnimator([1, 1.1], trigger: isPlaying) { content, phase in
                        content.scaleEffect(phase)
                    } animation: { phase in
                        switch phase {
                        case 1: .bouncy
                        case 1.1: .easeOut
                        default: .easeInOut
                        }
                    }
                
                play
                    .frame(width: isPlaying ? 220 : 50)
                    .foregroundStyle(
                        ShaderLibrary.angledFill(
                            .float(10),
                            .float(10),
                            .color(.blue)
                        )
                    )
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.001))
            .distortionEffect(ShaderLibrary.simpleWave(.float(startDate.timeIntervalSinceNow)),
                              maxSampleOffset: CGSize(width: 100, height: 100))
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(colors: [.clear, .primary.opacity(0.3), .clear],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    
    var content: some View {
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
                    .symbolEffect(.bounce, value: isDownloading)
                    .onTapGesture {
                        isDownloading.toggle()
                    }
            }
        }
    }
    
    var play: some View {
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
    }
}

#Preview {
    ContentView()
}
