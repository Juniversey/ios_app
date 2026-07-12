//
//  ExamCardView.swift
//  ExamCountdown
//
//  Created by ExamTimer on 2026/07/11.
//

import SwiftUI

struct ExamCardView: View {
    let exam: Exam

    private var days: Int {
        exam.date.daysUntilToday
    }

    private var status: CardStatus {
        if days < 0 { return .done }
        if days == 0 { return .today }
        if days == 1 { return .tomorrow }
        if days <= 7 { return .urgent }
        if days <= 30 { return .warning }
        return .normal
    }

    private var statusColor: Color {
        switch status {
        case .normal: return .green
        case .warning: return .orange
        case .urgent, .today, .tomorrow: return .red
        case .done: return .gray
        }
    }

    private var statusGradient: LinearGradient {
        switch status {
        case .normal:
            return LinearGradient(colors: [Color.green.opacity(0.15), Color.green.opacity(0.05)],
                                  startPoint: .leading, endPoint: .trailing)
        case .warning:
            return LinearGradient(colors: [Color.orange.opacity(0.15), Color.orange.opacity(0.05)],
                                  startPoint: .leading, endPoint: .trailing)
        case .urgent, .today, .tomorrow:
            return LinearGradient(colors: [Color.red.opacity(0.15), Color.red.opacity(0.05)],
                                  startPoint: .leading, endPoint: .trailing)
        case .done:
            return LinearGradient(colors: [Color.gray.opacity(0.15), Color.gray.opacity(0.05)],
                                  startPoint: .leading, endPoint: .trailing)
        }
    }

    private var statusLabel: String {
        switch status {
        case .normal: return "\(days) 天后"
        case .warning: return "\(days) 天后"
        case .urgent: return "\(days) 天后"
        case .today: return "就是今天！"
        case .tomorrow: return "明天！"
        case .done: return "已结束"
        }
    }

    private var daysLabel: String {
        switch status {
        case .today: return "就是今天，加油！"
        case .tomorrow: return "明天就要考试了"
        case .done: return "已于 \(abs(days)) 天前结束"
        default: return "还有 \(days) 天"
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            // Left colored bar
            VStack(spacing: 8) {
                Text(String(days < 0 ? abs(days) : days))
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .foregroundStyle(statusColor.gradient)
                    .lineLimit(1)

                Text(daysLabel)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(width: 90, alignment: .center)

            // Divider
            Rectangle()
                .fill(Color.secondary.opacity(0.2))
                .frame(width: 1)

            // Right info
            VStack(alignment: .leading, spacing: 6) {
                Text(exam.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)

                Text(exam.date.formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(exam.date.fullFormattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .opacity(0.7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(statusGradient)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(statusColor.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Card Status Enum

enum CardStatus {
    case normal, warning, urgent, today, tomorrow, done
}

// MARK: - Preview

struct ExamCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExamCardView(exam: Exam(name: "高考", date: Date().addingTimeInterval(50 * 86400)))
                .previewLayout(.sizeThatFits)

            ExamCardView(exam: Exam(name: "考研", date: Date().addingTimeInterval(3 * 86400)))
                .previewLayout(.sizeThatFits)

            ExamCardView(exam: Exam(name: "期末考试", date: Date().addingTimeInterval(-5 * 86400)))
                .previewLayout(.sizeThatFits)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
