//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta Enriquez on 30/01/26.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var count: Int = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap count: \(count)") {
            count += 1
        }
        // Build-in haptic motions
//        .sensoryFeedback(.increase, trigger: count)
//        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: count)
//        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: count)
        
        Button("Play haptic", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptics engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events: [CHHapticEvent] = []
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let instensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [instensity, sharpness],
                relativeTime: i
            )
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let instensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [instensity, sharpness],
                relativeTime: 1 + i
            )
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
