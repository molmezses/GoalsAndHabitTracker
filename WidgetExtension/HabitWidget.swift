//
//  HabitWidget.swift
//  HabitWidgetExtension
//
//  Widget Extension için ana dosya
//

import WidgetKit
import SwiftUI

@main
struct HabitWidgetBundle: WidgetBundle {
    var body: some Widget {
        HabitWidget()
    }
}

struct HabitWidget: Widget {
    let kind: String = "HabitWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: HabitWidgetProvider()) { entry in
            if #available(iOS 17.0, *) {
                HabitWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.white
                    }
            } else {
                HabitWidgetView(entry: entry)
                    .padding(0)
                    .background(Color.white)
            }
        }
        .configurationDisplayName("Habit Tracker")
        .description("Track your daily habits at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct HabitWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> HabitWidgetEntry {
        print("📱 Widget: placeholder çağrıldı")
        return HabitWidgetEntry(
            date: Date(),
            habits: [
                HabitWidgetData(
                    id: "1",
                    title: "Water",
                    emoji: "💧",
                    progress: 0.75,
                    isCompleted: false,
                    colorHex: "#007AFF"
                ),
                HabitWidgetData(
                    id: "2",
                    title: "Exercise",
                    emoji: "🏃",
                    progress: 0.5,
                    isCompleted: false,
                    colorHex: "#34C759"
                )
            ]
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (HabitWidgetEntry) -> ()) {
        print("📱 Widget: getSnapshot çağrıldı")
        let habits = loadHabitsForWidget()
        print("📱 Widget: getSnapshot - \(habits.count) habit yüklendi")
        let entry = HabitWidgetEntry(
            date: Date(),
            habits: habits
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HabitWidgetEntry>) -> ()) {
        let currentDate = Date()
        let habits = loadHabitsForWidget()
        print("Widget: Timeline oluşturuluyor, \(habits.count) habit bulundu")
        
        let entry = HabitWidgetEntry(
            date: currentDate,
            habits: habits
        )
        
        // Her 1 dakikada bir güncelle (daha sık güncelleme için)
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
    
    private func loadHabitsForWidget() -> [HabitWidgetData] {
        // App Group identifier (WidgetDataService ile aynı olmalı)
        let appGroupIdentifier = "group.com.olmezsesmustafa.GoalsAndHabitTracker"
        let habitsKey = "widget_habits"
        
        print("📱 Widget: loadHabitsForWidget çağrıldı")
        print("📱 Widget: App Group ID: \(appGroupIdentifier)")
        
        var data: Data?
        var sharedDefaults: UserDefaults?
        
        // App Group UserDefaults'tan oku
        if let defaults = UserDefaults(suiteName: appGroupIdentifier) {
            sharedDefaults = defaults
            data = defaults.data(forKey: habitsKey)
            print("✅ Widget: App Group bulundu, veri okundu: \(data != nil)")
            if let data = data {
                print("✅ Widget: Veri boyutu: \(data.count) bytes")
            }
        } else {
            // Fallback: Standart UserDefaults
            print("⚠️ Widget: App Group bulunamadı, standart UserDefaults kullanılıyor")
            sharedDefaults = UserDefaults.standard
            data = UserDefaults.standard.data(forKey: habitsKey)
            print("📱 Widget: Standart UserDefaults'tan veri okundu: \(data != nil)")
        }
        
        guard let data = data else {
            print("❌ Widget: Veri bulunamadı! App Group: \(appGroupIdentifier)")
            return []
        }
        
        print("✅ Widget: Veri bulundu, boyut: \(data.count) bytes")
        
        // JSONSerialization ile decode et (Habit struct widget'ta yok)
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            print("❌ Widget: JSON decode edilemedi!")
            // Veriyi string olarak yazdır (debug için)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📄 Widget: Ham veri (ilk 500 karakter): \(String(jsonString.prefix(500)))")
            } else {
                print("❌ Widget: Veri string'e çevrilemedi!")
            }
            return []
        }
        
        print("✅ Widget: JSONSerialization ile decode edildi, \(json.count) habit bulundu")
        
        if json.isEmpty {
            print("⚠️ Widget: JSON array boş!")
            return []
        }
        
        var widgetHabits: [HabitWidgetData] = []
        var skippedCount = 0
        
        for (index, habitDict) in json.enumerated() {
            print("🔍 Widget: Habit \(index) işleniyor...")
            print("   - Keys: \(habitDict.keys.sorted())")
            
            guard let id = habitDict["id"] as? String else {
                print("❌ Widget: Habit \(index) - 'id' eksik veya yanlış tip")
                skippedCount += 1
                continue
            }
            
            guard let title = habitDict["title"] as? String else {
                print("❌ Widget: Habit \(index) - 'title' eksik veya yanlış tip")
                skippedCount += 1
                continue
            }
            
            guard let emoji = habitDict["emoji"] as? String else {
                print("❌ Widget: Habit \(index) - 'emoji' eksik veya yanlış tip")
                skippedCount += 1
                continue
            }
            
            guard let colorHex = habitDict["colorHex"] as? String else {
                print("❌ Widget: Habit \(index) - 'colorHex' eksik veya yanlış tip")
                skippedCount += 1
                continue
            }
            
            print("✅ Widget: Habit \(index) decode edildi - \(title) (\(emoji))")
            
            // Progress hesapla
            let current = (habitDict["current"] as? Double) ?? 0
            let total = (habitDict["total"] as? Double) ?? 1
            let countingMode = (habitDict["countingMode"] as? String) ?? "forward"
            
            var progress: Double = 0
            var isCompleted = false
            
            if countingMode == "forward" {
                progress = total > 0 ? min(current / total, 1.0) : 0
                isCompleted = current >= total
            } else if countingMode == "backward" {
                let remaining = max(0, current)
                progress = total > 0 ? min((total - remaining) / total, 1.0) : 0
                isCompleted = current <= 0
            } else if countingMode == "timer" {
                let timerElapsed = (habitDict["timerElapsed"] as? Double) ?? 0
                let timerTarget = (habitDict["timerTarget"] as? Double) ?? 1
                progress = timerTarget > 0 ? min(timerElapsed / timerTarget, 1.0) : 0
                isCompleted = timerElapsed >= timerTarget
            }
            
            widgetHabits.append(HabitWidgetData(
                id: id,
                title: title,
                emoji: emoji,
                progress: progress,
                isCompleted: isCompleted,
                colorHex: colorHex
            ))
        }
        
        // Bugünün habit'lerini filtrele (en fazla 4 tane)
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let weekdayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let todayName = weekdayNames[weekday - 1]
        
        let todayHabits = widgetHabits.filter { habit in
            // Tüm habit'leri göster (reminderDays kontrolü yapılabilir ama şimdilik hepsini göster)
            true
        }
        
        print("✅ Widget: Toplam \(widgetHabits.count) habit oluşturuldu, \(skippedCount) atlandı")
        print("✅ Widget: \(todayHabits.count) habit döndürülüyor (max 4)")
        
        return Array(todayHabits.prefix(4))
    }
}

struct HabitWidgetEntry: TimelineEntry {
    let date: Date
    let habits: [HabitWidgetData]
}

struct HabitWidgetData: Identifiable {
    let id: String
    let title: String
    let emoji: String
    let progress: Double
    let isCompleted: Bool
    let colorHex: String
}

struct HabitWidgetView: View {
    var entry: HabitWidgetProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(habits: entry.habits)
        case .systemMedium:
            MediumWidgetView(habits: entry.habits)
        case .systemLarge:
            LargeWidgetView(habits: entry.habits)
        default:
            SmallWidgetView(habits: entry.habits)
        }
    }
}

// MARK: - Small Widget
struct SmallWidgetView: View {
    let habits: [HabitWidgetData]
    
    var body: some View {
        ZStack {
            if let firstHabit = habits.first {
                let habitColor = Color(hex: firstHabit.colorHex)
                
                VStack(spacing: 10) {
                    // Emoji with habit color background
                    ZStack {
                        Circle()
                            .fill(habitColor.opacity(0.25))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Circle()
                                    .stroke(habitColor.opacity(0.5), lineWidth: 2)
                            )
                            .shadow(color: habitColor.opacity(0.3), radius: 4, x: 0, y: 2)
                        
                        Text(firstHabit.emoji)
                            .font(.system(size: 32))
                    }
                    
                    // Title
                    Text(firstHabit.title)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 4)
                    
                    // Progress bar
                    HStack {
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.15))
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            colors: [habitColor, habitColor.opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * firstHabit.progress)
                                    .shadow(color: habitColor.opacity(0.3), radius: 2, x: 0, y: 1)
                            }
                        }
                    }
                    .frame(height: 10)
                    
                    // Status
                    if firstHabit.isCompleted {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(habitColor)
                                .font(.system(size: 14, weight: .bold))
                            Text("Done")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(habitColor.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Text("\(Int(firstHabit.progress * 100))%")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(habitColor.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 0.529, green: 0.827, blue: 0.737))
                    }
                    
                    Text("No Habits")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

// MARK: - Medium Widget
struct MediumWidgetView: View {
    let habits: [HabitWidgetData]
    
    var body: some View {
        ZStack {
            if habits.isEmpty {
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 64, height: 64)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(Color(red: 0.529, green: 0.827, blue: 0.737))
                    }
                    
                    Text("No Habits")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                }
            } else {
                VStack(spacing: 10) {
                    ForEach(habits.prefix(3)) { habit in
                        let habitColor = Color(hex: habit.colorHex)
                        
                        HStack(spacing: 10) {
                            // Emoji with habit color background
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(habitColor.opacity(0.25))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(habitColor.opacity(0.5), lineWidth: 1.5)
                                    )
                                    .shadow(color: habitColor.opacity(0.3), radius: 3, x: 0, y: 2)
                                
                                Text(habit.emoji)
                                    .font(.system(size: 24))
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(habit.title)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                
                                // Progress bar
                                HStack {
                                    GeometryReader { geometry in
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(Color.gray.opacity(0.15))
                                            
                                            RoundedRectangle(cornerRadius: 6)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [habitColor, habitColor.opacity(0.8)],
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .frame(width: geometry.size.width * habit.progress)
                                                .shadow(color: habitColor.opacity(0.3), radius: 2, x: 0, y: 1)
                                        }
                                    }
                                }
                                .frame(height: 6)
                            }
                            
                            Spacer(minLength: 4)
                            
                            // Status indicator
                            if habit.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(habitColor)
                                    .font(.system(size: 18, weight: .bold))
                                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
                            } else {
                                Text("\(Int(habit.progress * 100))%")
                                    .font(.system(size: 11, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(habitColor.opacity(0.15))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                        }
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Large Widget
struct LargeWidgetView: View {
    let habits: [HabitWidgetData]
    
    var body: some View {
        ZStack {
            if habits.isEmpty {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 70, height: 70)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(Color(red: 0.529, green: 0.827, blue: 0.737))
                    }
                    
                    Text("No Habits")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                    
                    Text("Add habits to track your progress")
                        .font(.system(size: 13, design: .rounded))
                        .foregroundColor(.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            } else {
                VStack(spacing: 12) {
                    // Header
                    HStack {
                        Text("Today's Habits")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(habits.filter { $0.isCompleted }.count)/\(habits.count)")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // Habits list
                    VStack(spacing: 10) {
                        ForEach(habits) { habit in
                            let habitColor = Color(hex: habit.colorHex)
                            
                            HStack(spacing: 12) {
                                // Emoji with habit color background
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(habitColor.opacity(0.25))
                                        .frame(width: 48, height: 48)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(habitColor.opacity(0.5), lineWidth: 1.5)
                                        )
                                        .shadow(color: habitColor.opacity(0.3), radius: 4, x: 0, y: 2)
                                    
                                    Text(habit.emoji)
                                        .font(.system(size: 26))
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(habit.title)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                            .lineLimit(1)
                                        
                                        Spacer(minLength: 4)
                                        
                                        if habit.isCompleted {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(habitColor)
                                                .font(.system(size: 18, weight: .bold))
                                        }
                                    }
                                    
                                    // Progress bar
                                    HStack {
                                        GeometryReader { geometry in
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.gray.opacity(0.15))
                                                
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(
                                                        LinearGradient(
                                                            colors: [habitColor, habitColor.opacity(0.8)],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        )
                                                    )
                                                    .frame(width: geometry.size.width * habit.progress)
                                                    .shadow(color: habitColor.opacity(0.3), radius: 2, x: 0, y: 1)
                                            }
                                        }
                                    }
                                    .frame(height: 8)
                                    
                                    // Progress percentage
                                    HStack {
                                        Text("\(Int(habit.progress * 100))%")
                                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                    }
                                }
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(habitColor.opacity(0.2), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            )
                        }
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Color Extension for Widget
extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
struct HabitWidget_Previews: PreviewProvider {
    static var previews: some View {
        HabitWidgetView(entry: HabitWidgetEntry(
            date: Date(),
            habits: [
                HabitWidgetData(
                    id: "1",
                    title: "Water",
                    emoji: "💧",
                    progress: 0.75,
                    isCompleted: false,
                    colorHex: "#007AFF"
                ),
                HabitWidgetData(
                    id: "2",
                    title: "Exercise",
                    emoji: "🏃",
                    progress: 1.0,
                    isCompleted: true,
                    colorHex: "#34C759"
                )
            ]
        ))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        HabitWidgetView(entry: HabitWidgetEntry(
            date: Date(),
            habits: [
                HabitWidgetData(
                    id: "1",
                    title: "Water",
                    emoji: "💧",
                    progress: 0.75,
                    isCompleted: false,
                    colorHex: "#007AFF"
                ),
                HabitWidgetData(
                    id: "2",
                    title: "Exercise",
                    emoji: "🏃",
                    progress: 1.0,
                    isCompleted: true,
                    colorHex: "#34C759"
                )
            ]
        ))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
