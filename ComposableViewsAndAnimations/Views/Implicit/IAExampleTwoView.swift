//
//  IAExampleTwoView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct IAExampleTwoView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls the size of the circle
    @State private var scaleFactor: CGFloat = 1.0

    // Controls the hue of the circle
    @State private var hue: Color = .red
    
    // Initialize a timer that will fire in one second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Whether to apply the animation
    @State private var useAnimation = false
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Circle()
                    .foregroundColor(hue)
                    .scaleEffect(scaleFactor)
                    .onTapGesture {
                        if scaleFactor > 0.2 {
                            // Reduce the size of the circle by a tenth
                            scaleFactor -= 0.1
                        } else {
                            // Make sure the button doesn't entirely disappear
                            scaleFactor = 1
                            // Change the color of the view to a random hue
                            hue = Color(hue: Double.random(in: 1...360) / 360.0,
                                        saturation: 0.8,
                                        brightness: 0.8)
                        }
                    }
                // When useAnimation is true, the default animation effect will be used.
                // When useAnimation is false, there will be no animation.
                  .animation(useAnimation ? .linear(duration: 2.5) : .none)
                
            }
            .navigationTitle("Example 2")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        hideView()
                    }
                }
            }
            .onReceive(timer) { input in
                
                // Set the flag to enable animations
                useAnimation = true
                
                // Stop the timer from continuing to fire
                timer.upstream.connect().cancel()
                
            }
            
            
        }
        
    }
    
    // MARK: Functions
    
    // Makes this view go away
    func hideView() {
        showThisView = false
    }
    
}

struct IAExampleTwoView_Previews: PreviewProvider {
    static var previews: some View {
        IAExampleTwoView(showThisView: .constant(true))
    }
}
