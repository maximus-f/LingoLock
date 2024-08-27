//
//  LingoLockWidget.swift
//  LingoLockWidget
//
//  Created by Max Fuligni on 8/26/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), word: "Placeholder", definition: "Placeholder definition")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, word: "Example", definition: "An example definition")
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, word: "znakomity (adj.)", definition: "excellent, superb, great")
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let word: String
      let definition: String
}

struct LingoLockWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
       var entry: Provider.Entry

       var body: some View {
           switch family {
           case .accessoryRectangular:
               VStack(alignment: .leading) {
                   Text(entry.word)
                       .font(.system(size: 18)) // Adjust font size as needed
                       .bold()
                       .opacity(1)
                       .foregroundColor(.black)

                   Text(entry.definition)
                       .font(.system(size: 15)) // Adjust font size as needed
                       .opacity(1)
                       .foregroundColor(.black)
                   
               }
               .padding(.all, 3)
               .background(Color.white)
               .cornerRadius(10)
               .opacity(1.0)


           case .accessoryInline:
               Text("\(entry.word): \(entry.definition)")
           case .accessoryCircular:
               VStack {
                   Text(entry.word)
                       .font(.caption)
                       .bold()
                   Text(entry.definition)
                       .font(.footnote)
                       
               }
               .background(Color.white)
         case .systemMedium:
             VStack(alignment: .leading) {
                 Text(entry.word)
                     .font(.headline)
                     .bold()
                 Text(entry.definition)
                     .font(.caption)
                     .foregroundColor(.gray)
             }
             .background(Color.white)
           default:
               EmptyView()
           }
       }
    
}

struct LingoLockWidget: Widget {
    let kind: String = "LingoLockWidget"

       var body: some WidgetConfiguration {
           AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
               LingoLockWidgetEntryView(entry: entry)
                   .containerBackground(.fill, for: .widget)
           }
           .supportedFamilies([.accessoryRectangular, .accessoryInline, .accessoryCircular, .systemMedium, .systemSmall])
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

#Preview(as: .systemSmall) {
    LingoLockWidget()
} timeline: {
    SimpleEntry( date: .now, configuration: .smiley, word: "Parola", definition: "Word")
   
}
