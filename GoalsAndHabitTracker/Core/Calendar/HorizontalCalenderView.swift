//
//  HorizontalCalenderView.swift
//  GoalsAndHabitTracker
//
//  Created by Mustafa Ölmezses on 22.04.2025.
//

import SwiftUI

struct HorizontalCalendarView: View {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    @Binding var selectedDate: Date?
    
    let today: Date = Calendar.current.startOfDay(for: Date())
    let dates: [Date]

    init(selectedDate: Binding<Date?> = .constant(nil)) {
        self._selectedDate = selectedDate
        var tempDates: [Date] = []
        for offset in -3...3 {
            if let date = calendar.date(byAdding: .day, value: offset, to: Date()) {
                tempDates.append(calendar.startOfDay(for: date))
            }
        }
        self.dates = tempDates
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(dates, id: \.self) { date in
                        let isSelected = selectedDate != nil && calendar.isDate(date, inSameDayAs: selectedDate!)
                        let isToday = calendar.isDateInToday(date)
                        
                        Button {
                            selectedDate = date
                        } label: {
                            VStack(spacing: 4) {
                                Text(weekdayString(from: date))
                                    .font(.caption2)
                                    .foregroundColor(.black)
                                Text("\(calendar.component(.day, from: date))")
                                    .font(.headline)
                                    .foregroundColor(isToday ? .black : .primary)
                            }
                            .padding(10)
                            .frame(width: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(isSelected ? .mint : (isToday ? .mint.opacity(0.4) : Color(.systemBackground)))
                            )
                        }
                        .id(date)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    proxy.scrollTo(today, anchor: .center)
                }
            }
        }
    }

    func weekdayString(from date: Date) -> String {
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date).uppercased()
    }
}

#Preview {
    HorizontalCalendarView()
}

