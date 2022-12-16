//
//  LiveActivityHelper.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation
import ActivityKit

struct MetroWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var stop: Stop?
        var state : State = .initialized
    }
    
    // Fixed non-changing properties about your activity go here!
    var cityName: String
    var lineName : String
    var lineColor : String
}

enum State : Codable {
    case initialized, using, ended, successful
}

class LiveActivityHelper {
    
    static let shared = LiveActivityHelper()
    
    var activity: Activity<MetroWidgetAttributes>?
    
    func start() {
        // We can check if activity is enabled.
        
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Activities are not enabled!")
            return
        }
        
        // Initializing the models.
        let settings = Settings.shared
        
        let attributes = MetroWidgetAttributes(cityName: settings.city.name, lineName: settings.line.name, lineColor: settings.line.color)
        let initialContentState = MetroWidgetAttributes.ContentState()
        
        // Key point here!
        // Now we tell iOS that there is a new activity started!
        
        let activityContent = ActivityContent(state: initialContentState, staleDate: nil)
        
        
        do {
            activity = try Activity.request(attributes: attributes, content: activityContent)
            Settings.shared.notNotified = true
            print("Requested a Live Activity \(String(describing: activity?.id)).")
        } catch (let error) {
            print("Error requesting Live Activity \(error.localizedDescription).")
        }
    }
    
    // Now I will update the current activity.
    func update(_ stop : Stop?) {
        
        Task {
            let updatedState = MetroWidgetAttributes.ContentState(stop: stop, state: .using)
            let updatedContent = ActivityContent(state: updatedState, staleDate: nil)
            
            await activity?.update(updatedContent, alertConfiguration: nil)
            
        }
    }
    
    func endAndNotify(_ stop : Stop?) {
        
        Task {
            let updatedState = MetroWidgetAttributes.ContentState(stop: stop, state: .successful)
            let sound_name = NotificationSoundManager().getSound()
            let alertConfiguration = AlertConfiguration(title: "Metro update", body: "You're close to your destination!'", sound: .named(sound_name))
            let updatedContent = ActivityContent(state: updatedState, staleDate: nil)
            
            await activity?.update(updatedContent, alertConfiguration: alertConfiguration)
            
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: 5, to: Date())!
            
            await activity?.end(updatedContent, dismissalPolicy: .after(date))
            
            Settings.shared.notNotified = true
        }
    }
    
    func end() {
        Task {
            let finalState = MetroWidgetAttributes.ContentState(stop: nil, state: .ended)
            let finalContent = ActivityContent(state: finalState, staleDate: nil)
            
            for activity in Activity<MetroWidgetAttributes>.activities {
                Settings.shared.notNotified = true
                await activity.end(finalContent, dismissalPolicy: .immediate)
                print("Ending the Live Activity: \(activity.id)")
            }
        }
    }
    
}
