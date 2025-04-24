//
//  StatusView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct StatusView: View {
    
    let daysOfWeek: [String] = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    let daysOfWeekColumns = Array(repeating: GridItem(.flexible()), count: 7)
    
    @State var currentMonth: Int = Calendar.current.component(.month, from: Date())
    @State var currentYear: Int = Calendar.current.component(.year, from: Date())
    @Environment(\.dismiss) var dismiss
    @State var animate: Bool = false
    let habit: Habit


    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                    ScrollView {
                        VStack {
                            VStack {
                                Button {
                                    dismiss()
                                } label: {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                            .imageScale(.large)
                                            .bold()
                                        Text("Back to Task")
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                                    .padding(.horizontal)
                                    .foregroundStyle(.black)
                                }

                            //takvim
                            VStack {
                                // LEFT - RIGHT BUTTONS
                                HStack {
                                    Text(formattedMonthYear(month: currentMonth, year: currentYear))
                                    Spacer()
                                    Group {
                                        Button { backToday() } label: {
                                            Image(systemName: "calendar")
                                        }
                                        Button { leftButtonClicked() } label: {
                                            Image(systemName: "chevron.left")
                                                .padding(.horizontal)
                                        }
                                        Button { rightButtonClicked() } label: {
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                    .imageScale(.large)
                                    .foregroundStyle(.black)
                                }
                                .padding()
                                
                                // WEEKDAY HEADERS
                                LazyVGrid(columns: daysOfWeekColumns, spacing: 10) {
                                    ForEach(daysOfWeek, id: \.self) { weekDayName in
                                        Text(weekDayName)
                                            .fontWeight(.bold)
                                    }
                                }

                                // DAYS IN MONTH
                                LazyVGrid(columns: daysOfWeekColumns, spacing: 10) {
                                    // Günleri gösteren kısımda güncelleme:
                                    ForEach(generateCalendarDays(), id: \.self) { day in
                                        Text("\(day.day)")
                                            .frame(width: 40, height: 40)
                                            .background(getBackgroundColor(for: day))
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .foregroundStyle(getTextColor(for: day))
                                    }
                                    
                                }
                                .opacity(animate ? 1 : 0)
                                .offset(y: animate ? 0 : 20)
                                .animation(.easeInOut(duration: 0.6), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity , alignment: .center)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .padding()
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 20)
                            .animation(.easeInOut(duration: 0.6), value: animate)
                            .onAppear {
                                animate = true
                            }
                            
                            //Jetonlar
                            VStack(spacing: 8) {
                                HStack(spacing: 8) {
                                    InfoCard(title: "10 Days", subtitle: "Completed", icon: "checkmark", color: .green)
                                    InfoCard(title: "4 Days", subtitle: "Missing", icon: "xmark", color: .red)
                                }
                                
                                HStack(spacing: 8) {
                                    InfoCard(title: "89%", subtitle: "Month Goals", icon: "checkmark.rectangle.stack", color: .purple)
                                    InfoCard(title: "21 Days", subtitle: "Longest Series", icon: "figure.run.treadmill", color: .blue)
                                }
                                
                                HStack(spacing: 8) {
                                    InfoCard(title: "12 Sep 25", subtitle: "Starting Day", icon: "calendar", color: .orange)
                                    InfoCard(title: "21 Days", subtitle: "Reminder Time", icon: "clock.badge.checkmark", color: .mint)
                                }
                            }
                            .padding(.horizontal)
                            .background(Color(.systemGroupedBackground))
                            .opacity(animate ? 1 : 0)
                            .animation(.easeInOut(duration: 0.6), value: animate)
                            .onAppear {
                                animate = true
                            }

                        }
                    }
                }
            }
        }
    }
    
    struct InfoCard: View {
        let title: String
        let subtitle: String
        let icon: String
        let color: Color
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .bold()
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: icon)
                    .bold()
                    .foregroundStyle(color)
                    .padding(10)
                    .background(color.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }

    
    // 📌 AYIN FORMATINI DÜZENLER
    func formattedMonthYear(month: Int, year: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        var components = DateComponents()
        components.year = year
        components.month = month
        
        if let date = Calendar.current.date(from: components) {
            return dateFormatter.string(from: date)
        }
        return "Geçersiz tarih"
    }
    
    // 📌 TAKVİM GÜNLERİNİ OLUŞTURUR
    func generateCalendarDays() -> [CalendarDay] {
        let calendar = Calendar.current
        let firstDayOfMonth = DateComponents(year: currentYear, month: currentMonth, day: 1)
        
        guard let firstDate = calendar.date(from: firstDayOfMonth),
              let daysRange = calendar.range(of: .day, in: .month, for: firstDate) else {
            return []
        }

        let numberOfDays = daysRange.count
        let firstWeekday = calendar.component(.weekday, from: firstDate) - 1
        
        var days: [CalendarDay] = []
        
        // 🔹 Önceki ayın günlerini ekle
        let prevMonth = currentMonth == 1 ? 12 : currentMonth - 1
        let prevYear = currentMonth == 1 ? currentYear - 1 : currentYear
        let prevMonthDays = numberOfDaysInMonth(month: prevMonth, year: prevYear)

        if firstWeekday > 0 {
            for i in (prevMonthDays - firstWeekday + 1)...prevMonthDays {
                days.append(CalendarDay(day: i, isCurrentMonth: false))
            }
        }

        // 🔹 Geçerli ayın günlerini ekle
        for i in 1...numberOfDays {
            days.append(CalendarDay(day: i, isCurrentMonth: true))
        }

        // 🔹 Sonraki ayın günlerini ekle
        let remainingDays = 42 - days.count
        if remainingDays > 0 {
            for i in 1...remainingDays {
                days.append(CalendarDay(day: i, isCurrentMonth: false))
            }
        }
        return days
    }

    // 📌 TAKVİMDEKİ GÜNÜN YAZI RENGİNİ BELİRLER
    func getTextColor(for day: CalendarDay) -> Color {
        let formattedDate = "\(day.day) \(formattedMonthYear(month: currentMonth, year: currentYear))"
        
        if day.isCurrentMonth, habit.complatedDay.contains(formattedDate) {
            return .white // İşaretli günlerde beyaz yazı
        }
        
        if day.isCurrentMonth {
            return .black // Normal günlerde siyah yazı
        }

        return .gray // Diğer aylardan olan günler
    }

    
    // 📌 BELİRLİ BİR AYIN GÜN SAYISINI DÖNDÜRÜR
    func numberOfDaysInMonth(month: Int, year: Int) -> Int {
        var components = DateComponents()
        components.year = year
        components.month = month
        
        if let date = Calendar.current.date(from: components),
           let range = Calendar.current.range(of: .day, in: .month, for: date) {
            return range.count
        }
        
        return 0
    }
    

    // 📌 TAKVİMDEKİ GÜNÜN ARKA PLAN RENGİNİ BELİRLER
    func getBackgroundColor(for day: CalendarDay) -> Color {
        let formattedDate = "\(day.day) \(formattedMonthYear(month: currentMonth, year: currentYear))"

        if day.isCurrentMonth, habit.complatedDay.contains(formattedDate) {
            return habit.color // ✅ İşaretli günler için yeşil
        }

        if day.isCurrentMonth {
            return habit.color.opacity(0.2) // 🌿 Diğer günler için açık yeşil
        }
        
        return .clear // Önceki ve sonraki ayların günleri
    }




    // 📌 SOL BUTONA BASILDIĞINDA AYI DEĞİŞTİRİR
    func leftButtonClicked() {
        withAnimation(.spring){
            if currentMonth == 1{
                currentMonth = 12
                currentYear -= 1
            }else{
                currentMonth -= 1
            }
        }
    }
    
    // 📌 SAĞ BUTONA BASILDIĞINDA AYI DEĞİŞTİRİR
    func rightButtonClicked() {
        withAnimation(.spring){
            if currentMonth == 12{
                currentMonth = 1
                currentYear += 1
            }else{
                currentMonth += 1
            }
        }
    }
    
    // 📌 BUGÜNE GERİ DÖNER
    func backToday() {
        currentYear = Calendar.current.component(.year, from: Date())
        currentMonth = Calendar.current.component(.month, from: Date())
    }
}

// 📌 TAKVİMDEKİ HER BİR GÜNÜ TEMSİL EDEN MODEL
struct CalendarDay: Hashable {
    let day: Int
    let isCurrentMonth: Bool
}

#Preview {
    StatusView(habit: Habit.MOCK_HABIT[0])
}
