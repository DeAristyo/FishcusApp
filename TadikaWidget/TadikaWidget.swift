//
//  TadikaWidget.swift
//  TadikaWidget
//
//  Created by Dimas Aristyo Rahadian on 13/10/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct TadikaWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            GeometryReader{ geometry in
                VStack(spacing: 5, content: {
                    Text(entry.date, style: .time)
                        .font(.system(size: 40, weight: .bold, design: .default))
                    
                    Image("mancingIkan")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .position(CGPoint(x: geometry.frame(in: .global).minX+23, y: geometry.frame(in: .global).minY+30))
                })
                .frame(width: geometry.size.width, height: geometry.size.width)
            }
            
        case .systemMedium:
            GeometryReader{ geometry in
                HStack(spacing: 5, content: {
                    Image("mancingIkan")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .position(CGPoint(x: geometry.frame(in: .global).minX+25, y: geometry.frame(in: .global).minY+67))
                    
                    VStack(spacing: 0, content: {
                        Text(entry.date, style: .time)
                            .font(.system(size: 40, weight: .bold, design: .default))
                        
                        Button("Stop Focus"){
                            
                        }
                        .background(Color.red)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        
                    }).position(CGPoint(x: geometry.frame(in: .global).midX-110, y: geometry.frame(in: .global).midY-20))
                    
                }).frame(width: geometry.size.width, height: geometry.size.width)
            }
        default:
            VStack {
                Text("This widget is not working go call Dimas")
//                Text("Time:")
//                Text(entry.date, style: .time)
//                
//                Text("Favorite Emoji:")
//                Text(entry.configuration.favoriteEmoji)
            }
        }
    }
}

struct TadikaWidget: Widget {
    let kind: String = "TadikaWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TadikaWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemSmall, .systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
}

#Preview(as: .systemSmall) {
    TadikaWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
