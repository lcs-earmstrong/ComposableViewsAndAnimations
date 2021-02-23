//
//  IAExampleOneView.swift
//  ComposableViewsAndAnimations
//
//  Created by Russell Gordon on 2021-02-23.
//

import SwiftUI

struct IAExampleOneView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // Controls the size of the circle
    @State private var scaleFactor: CGFloat = 1.0
    
    // Initialize a timer that will fire in one second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Whether to apply the animation
    @State private var useAnimation = false
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Circle()
                    .foregroundColor(.red)
                    .scaleEffect(scaleFactor)
                    .onTapGesture {
                        if scaleFactor > 0.2 {
                            // Reduce the size of the circle by a tenth
                            scaleFactor -= 0.1
                        } else {
                            // Make sure the button doesn't entirely disappear
                            scaleFactor = 1
                        }
                    }
                // When useAnimation is true, the default animation effect will be used.
                // When useAnimation is false, there will be no animation.
         //     .animation(useAnimation ? .default : .none)
                
            }
            .navigationTitle("Example 1")
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

struct IAExampleOneView_Previews: PreviewProvider {
    static var previews: some View {
        IAExampleOneView(showThisView: .constant(true))
    }
}
