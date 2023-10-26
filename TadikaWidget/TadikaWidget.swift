//
//  TadikaWidget.swift
//  TadikaWidget
//
//  Created by Dimas Aristyo Rahadian on 24/10/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let sharedDefaults = UserDefaults(suiteName: "group.75VHUVZJF4.com.vicky.tadikaapp")
        
        let widgetState = sharedDefaults?.string(forKey: "widgetState") ?? "idle"
        let currentTime = sharedDefaults?.string(forKey: "currentTime") ?? "00:00:00"
        return SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), widgetState: widgetState, currentTime: currentTime)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let sharedDefaults = UserDefaults(suiteName: "group.75VHUVZJF4.com.vicky.tadikaapp")
        
        let widgetState = sharedDefaults?.string(forKey: "widgetState") ?? "idle"
        let currentTime = sharedDefaults?.string(forKey: "currentTime") ?? "00:00"
        return SimpleEntry(date: Date(), configuration: configuration, widgetState: widgetState, currentTime: currentTime)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            let sharedDefaults = UserDefaults(suiteName: "group.75VHUVZJF4.com.vicky.tadikaapp")
            
            let widgetState = sharedDefaults?.string(forKey: "widgetState") ?? "idle"
            let currentTime = sharedDefaults?.string(forKey: "currentTime") ?? "00:00:00"
            
            let entry = SimpleEntry(date: entryDate, configuration: configuration, widgetState: widgetState, currentTime: currentTime)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    var widgetState: String
    var currentTime: String
}

struct TadikaWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            GeometryReader{ geometry in
                switch entry.widgetState{
                case "idle":
                    ZStack(content: {
                        Image("idleBG")
                            .resizable()
                            .frame(width: geometry.size.width*1.15, height: geometry.size.height*1.3)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        Button(action: {
                            // Button action
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("primeLight"))
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .opacity(0.4)
                                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 4)
                                    .overlay(content: {
                                        Circle()
                                            .fill(Color("primeLight"))
                                            .frame(width: geometry.size.width/2.8, height: geometry.size.height/1)
                                            .opacity(0.6).overlay(content: {
                                                Circle()
                                                    .fill(Color("regular-text"))
                                                    .frame(width: geometry.size.width/3.5, height: geometry.size.height/1)
                                                Text("Focus")
                                                    .foregroundColor(Color("primeColor"))
                                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                            })
                                    })
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                case "focus":
                    ZStack(content: {
                        Image("focusBG")
                            .resizable()
                            .frame(width: geometry.size.width*1.15, height: geometry.size.height*1.3)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        ZStack(content: {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: geometry.size.width, height: geometry.size.height*1.5)
                                .background(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: Color("primeColor"), location: 0.00),
                                            Gradient.Stop(color: Color("primeColor").opacity(0.69), location: 0.58),
                                            Gradient.Stop(color: Color("primeColor").opacity(0), location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0, y: 0.5),
                                        endPoint: UnitPoint(x: 0.95, y: 0.5)
                                    )
                                )
                                .position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                            
                            VStack(content: {
                                Text("Focus Mode")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("regular-text"))
                                
                                Button(action: {
                                    // Button action
                                }) {
                                    ZStack {
                                        Capsule()
                                            .fill(Color("primeLight"))
                                            .frame(width: 130, height: 30)
                                            .offset(x: 0, y: 4)
                                        
                                        Capsule()
                                            .fill(Color("regular-text"))
                                            .frame(width: 130, height: 30)
                                        
                                        Text("Pause")
                                            .font(.system(size: 16.0, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("primeColor"))
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                        })
                    }).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                case "pause":
                    ZStack(content: {
                        Image("focusBG")
                            .resizable()
                            .blur(radius: 2)
                            .frame(width: geometry.size.width*1.15, height: geometry.size.height*1.3)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        ZStack(content: {
                            Rectangle()
                                .fill(Color("primeColor"))
                                .frame(width: 340, height: 160)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                .opacity(0.75)
                            
                            VStack(spacing: 3,content: {
                                Text("Break Time")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("regular-text"))
                                    .frame(width: 136, alignment: .top)
                                
                                Text(entry.currentTime)
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("highlight-text"))
                                    .animation(
                                        .easeIn(duration: 2)
                                            .delay(1)
                                    )
                            }).position(x: geometry.size.width/3.9, y: geometry.size.height / 2)
                            
                            ZStack(content: {
                                Button(action: {
                                    // Button action
                                }) {
                                    ZStack {
                                        Capsule()
                                            .fill(Color("primeLight"))
                                            .frame(width: 115, height: 30)
                                            .offset(x: 0, y: 4)
                                        
                                        Capsule()
                                            .fill(Color("regular-text"))
                                            .frame(width: 115, height: 30)
                                        
                                        Text("Resume")
                                            .font(.system(size: 16.0, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("primeColor"))
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }).position(x: geometry.size.width/1.3, y: geometry.size.height / 2)
                        })
                    }).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                default:
                    VStack {
                        Text("This widget is not working go call Dimas").multilineTextAlignment(.center)                }
                }
            }
        default:
            VStack {
                Text("This widget is not working go call Dimas").multilineTextAlignment(.center)                }
        }
    }
}

struct TadikaWidget: Widget {
    let kind: String = "TadikaWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TadikaWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    TadikaWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, widgetState: "idle", currentTime: "waktu")
}
