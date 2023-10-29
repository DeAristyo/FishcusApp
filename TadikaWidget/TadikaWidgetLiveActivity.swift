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
    @State var liveState = "focus"
    
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
                            HStack(content: {
                                Image("playIcon")
                                    .resizable()
                                    .frame(width: geometry.size.width/16, height: geometry.size.width/15)
                                Spacer()
                                Text("09:41")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                            }).position(x: geometry.size.width/3, y: geometry.size.height / 2)
                            
                            ZStack(content: {
                                Image("charIcon")
                                    .resizable()
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                            }).position(x: geometry.size.width/3.5, y: geometry.size.height / 2)
                        })
                    })
                }else if liveState == "pause"{
                    ZStack(content: {
                        Image("livePauseBg")
                            .resizable()
                            .frame(width: geometry.size.width ,height: geometry.size.height)
                        
                        HStack(content: {
                            HStack(content: {
                                Image("pauseIcon")
                                    .resizable()
                                    .frame(width: geometry.size.width/16, height: geometry.size.width/15)
                                Spacer()
                                Text("09:41")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                            }).position(x: geometry.size.width/3, y: geometry.size.height / 2)
                            
                            ZStack(content: {
                                Image("boatIcon")
                                    .resizable()
                                    .frame(width: geometry.size.width/4.8, height: geometry.size.width/7)
                            }).position(x: geometry.size.width/3.5, y: geometry.size.height / 2)
                        })
                    })
                    
                }
                
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    ZStack(content: {
                        VStack(content: {
                            Spacer()
                            HStack(content: {
                                Image("boatIcon")
                                    .resizable()
                                    .frame(width: 70, height: 41)
                                
                                VStack(alignment: .leading, content: {
                                    Text("Paused")
                                        .font(.system(size: 19, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("highlight-text"))
                                    
                                    Text("Taking a break...")
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundColor(Color("highlight-text"))
                                    
                                }).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            })
                            Spacer()
                        })
                    })
                }
                DynamicIslandExpandedRegion(.trailing) {
                    ZStack(content: {
                        HStack(content: {
                            VStack(alignment: .trailing, content: {
                                Spacer()
                                Text("04:41")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                                Spacer()
                            }).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        })
                    })
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Fishcus")
                }
            } compactLeading: {
                Text("9m").font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(Color("highlight-text"))
            } compactTrailing: {
                //                Image("boatIcon")
                EmptyView()
            } minimal: {
                EmptyView()
            }
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
