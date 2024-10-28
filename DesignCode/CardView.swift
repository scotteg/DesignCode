//
//  CardView.swift
//  DesignCode
//
//  Created by Scott Gardner on 10/28/24.
//

import SwiftUI

struct CardView: View {
    struct AnimationValues {
        var position: CGPoint = .zero
        var scale: Double = 1
        var opacity: Double = 0
    }
    
    @State var isPlaying = false
    @State var time = Date.now
    @State var isActive = false
    @State var isDownloading = false
    @State var hasSimpleWave = false
    @State var hasComplexWave = false
    @State var hasPattern = false
    @State var hasNoise = false
    @State var hasEmboss = false
    @State var isPixelated = false
    @State var number: Float = 0
    @State var isIncrementing = true
    
    let startDate = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let numberTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TimelineView(.animation) { _ in
            layout
                .frame(maxWidth: 400)
                .dynamicTypeSize(.xSmall ... .xLarge)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue.opacity(0.001))
                .distortionEffect(
                    ShaderLibrary.simpleWave(.float(startDate.timeIntervalSinceNow)),
                    maxSampleOffset: CGSize(width: 100, height: 100),
                    isEnabled: hasSimpleWave
                )
                .visualEffect { content, geometry in
                    content.distortionEffect(
                        ShaderLibrary.complexWave(
                            .float(startDate.timeIntervalSinceNow),
                            .float2(geometry.size),
                            .float(1),
                            .float(8),
                            .float(10)
                        ),
                        maxSampleOffset: CGSize(width: 100, height: 100),
                        isEnabled: hasComplexWave
                    )
                }
        }
    }
    
    var layout: some View {
        ZStack {
            TimelineView(.animation) { _ in
                Image(.image1)
                    .resizable()
                    .scaledToFill()
                    .frame(height: isPlaying ? 600 : 300)
                    .frame(width: isPlaying ? 393 : 360)
                    .colorEffect(
                        ShaderLibrary.circleLoader(.boundingRect, .float(startDate.timeIntervalSinceNow)),
                        isEnabled: hasPattern
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .colorEffect(
                                ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)),
                                isEnabled: hasNoise
                            )
                            .blendMode(.overlay)
                            .opacity(hasNoise ? 1 : 0)
                    }
                    .layerEffect(
                        ShaderLibrary.emboss(.float(10)),
                        maxSampleOffset: .zero,
                        isEnabled: hasEmboss
                    )
                    .layerEffect(
                        ShaderLibrary.pixellate(.float(number)),
                        maxSampleOffset: .zero,
                        isEnabled: isPixelated
                    )
                    .onReceive(numberTimer) { _ in
                        number += isIncrementing ? 1 : -1
                        
                        if number >= 10 {
                            isIncrementing = false
                        }
                        
                        if number <= 0 {
                            isIncrementing = true
                        }
                    }
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
                    .onTapGesture { hasNoise.toggle() }
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
                        .opacity(value.opacity)
                } keyframes: { _ in
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
                    
                    KeyframeTrack(\.opacity) {
                        CubicKeyframe(1, duration: 0)
                    }
                }
            
            content
                .padding(20)
                .background(hasSimpleWave || hasComplexWave ?
                    AnyView(Color(.secondarySystemBackground)) :
                                AnyView(Color.clear.background(.regularMaterial))
                )
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
                .if(hasPattern) { view in
                    view
                        .foregroundStyle(
                            ShaderLibrary.angledFill(
                                .float(10),
                                .float(10),
                                .color(.blue)
                            )
                        )
                }
                .foregroundStyle(.primary, .white)
                .font(.largeTitle)
                .padding(20)
                .background(hasSimpleWave || hasComplexWave ?
                    AnyView(Color(.secondarySystemBackground)) :
                    AnyView(Color.clear.background(.ultraThinMaterial))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
                .offset(y: isPlaying ? 40 : -44)
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
                    Button {
                        hasPattern.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolEffect(.pulse)
                    }
                    .tint(.primary)
                    
                    Divider()
                    
                    Button {
                        hasSimpleWave.toggle()
                    } label: {
                        Image(systemName: "sparkle.magnifyingglass")
                            .symbolEffect(.scale.up, isActive: isActive)
                    }
                    .tint(.primary)
                    
                    Divider()
                    
                    Button {
                        hasComplexWave.toggle()
                    } label: {
                        Image(systemName: "face.smiling")
                            .symbolEffect(.bounce, value: isActive)
                    }
                    .tint(.primary)
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
                    .onTapGesture { isDownloading.toggle() }
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
                .onTapGesture { hasEmboss.toggle() }
            
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
                .onTapGesture { isPixelated.toggle() }
        }
    }
}

#Preview {
    CardView()
}
