//
//  ExamModel.swift
//  ExamCountdown
//
//  Created by ExamTimer on 2026/07/11.
//

import Foundation

struct Exam: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var date: Date

    init(id: UUID = UUID(), name: String, date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }

    static func == (lhs: Exam, rhs: Exam) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - 日期扩展

extension Date {
    /// 返回距离今天的整数天数
    var daysUntilToday: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let target = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.day], from: today, to: target)
        return components.day ?? 0
    }

    /// 返回距离今天的精确天数（浮点）
    var daysUntilTodayDouble: Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let target = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.second], from: today, to: target)
        return Double(components.second ?? 0) / 86400.0
    }

    /// 格式化日期显示
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日"
        return formatter.string(from: self)
    }

    /// 格式化完整日期显示
    var fullFormattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日 (EEEE)"
        formatter.locale = Locale(identifier: "zh_CN")
        let weekdaySymbols = formatter.weekdaySymbols
        formatter.weekdaySymbols = ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"]
        return formatter.string(from: self)
    }
}
