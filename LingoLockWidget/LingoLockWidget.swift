import WidgetKit
import SwiftUI

// Provider for generating timeline entries
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

// Structure representing a single entry in the timeline
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let word: String
    let definition: String
}

// View for displaying widget content
struct LingoLockWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(entry.word)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)

                Text(entry.definition)
                    .font(.system(size: 11))
                    
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(3)
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
            .background(Color.red)

        case .systemMedium:
            VStack(alignment: .leading) {
                Text(entry.word)
                    .font(.headline)
                    .bold()
                Text(entry.definition)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .background(Color.red)

        default:
            EmptyView()
        }
    }
}

// Widget configuration
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

// Extension for providing example configurations
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

// Preview configuration
#Preview(as: .systemSmall) {
    LingoLockWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, word: "Parola", definition: "Word")
}
