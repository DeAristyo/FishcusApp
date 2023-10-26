//
//  TadikaWidgetLiveActivity.swift
//  TadikaWidget
//
//  Created by Dimas Aristyo Rahadian on 24/10/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TadikaWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }
    
    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TadikaWidgetLiveActivity: Widget {
    @State var liveState = "pause"
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TadikaWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            GeometryReader{geometry in
                if liveState == "focus"{
                    ZStack(content: {
                        Image("liveFocusBg")
                            .resizable()
                            .frame(width: geometry.size.width ,height: geometry.size.height)
                        
                        HStack(content: {
                            VStack(content: {
                                Text("Break Time")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("regular-text"))
                                    .frame(width: 136, alignment: .top)
                                
                                Text("09:41")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                            
                            ZStack(content: {
                                HStack(content: {
                                    Button(action: {
                                        // Button action
                                    }) {
                                        ZStack {
                                            Image("pauseButton")
                                                .resizable()
                                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                    Button(action: {
                                        // Button action
                                    }) {
                                        ZStack {
                                            Image("correctStopButton")
                                                .resizable()
                                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                })
                                
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                        })
                    })
                }else if liveState == "pause"{
                    ZStack(content: {
                        Image("livePauseBg")
                            .resizable()
                            .frame(width: geometry.size.width ,height: geometry.size.height)
                        
                        HStack(content: {
                            VStack(content: {
                                Text("Break Time")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("regular-text"))
                                    .frame(width: 136, alignment: .top)
                                
                                Text("09:41")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                            
                            ZStack(content: {
                                HStack(content: {
                                    Button(action: {
                                        // Button action
                                    }) {
                                        ZStack {
                                            Image("playButton")
                                                .resizable()
                                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                    Button(action: {
                                        // Button action
                                    }) {
                                        ZStack {
                                            Image("correctStopButton")
                                                .resizable()
                                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                            
                                        }
                                    }.buttonStyle(PlainButtonStyle())
                                })
                                
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                        })
                    })

                }
                
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TadikaWidgetAttributes {
    fileprivate static var preview: TadikaWidgetAttributes {
        TadikaWidgetAttributes(name: "World")
    }
}

extension TadikaWidgetAttributes.ContentState {
    fileprivate static var smiley: TadikaWidgetAttributes.ContentState {
        TadikaWidgetAttributes.ContentState(emoji: "😀")
    }
    
    fileprivate static var starEyes: TadikaWidgetAttributes.ContentState {
        TadikaWidgetAttributes.ContentState(emoji: "🤩")
    }
}

#Preview("Notification", as: .content, using: TadikaWidgetAttributes.preview) {
    TadikaWidgetLiveActivity()
} contentStates: {
    TadikaWidgetAttributes.ContentState.smiley
    TadikaWidgetAttributes.ContentState.starEyes
}
