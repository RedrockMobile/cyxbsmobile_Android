//
//  CyxbsWidget.swift
//  CyxbsWidget
//
//  Created by SSR on 2023/9/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import WidgetKit
import SwiftUI

@available(iOS 17.0, *)
struct AppIntentProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> AppIntentTimelineEntry {
        AppIntentTimelineEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> AppIntentTimelineEntry {
        AppIntentTimelineEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<AppIntentTimelineEntry> {
        var entries: [AppIntentTimelineEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = AppIntentTimelineEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

@available(iOS 17.0, *)
struct AppIntentTimelineEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

@available(iOS 17.0, *)
struct CyxbsWidgetEntryView : View {
    var entry: AppIntentProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}

@available(iOS 17.0, *)
struct CyxbsWidget: Widget {
    let kind: String = "CyxbsWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: AppIntentProvider()) { entry in
            CyxbsWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

@available(iOS 17.0, *)
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
