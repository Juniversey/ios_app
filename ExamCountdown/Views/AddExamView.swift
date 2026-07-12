//
//  AddExamView.swift
//  ExamCountdown
//
//  Created by ExamTimer on 2026/07/11.
//

import SwiftUI

struct AddExamView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: ExamStore

    @State private var examName: String = ""
    @State private var examDate: Date = Date().addingTimeInterval(86400)
    @State private var showingDatePicker = false

    var body: some View {
        NavigationStack {
            Form {
                Section("考试信息") {
                    TextField("例如：高考、考研、四六级", text: $examName)
                        .autocorrection(false)
                }

                Section("考试日期") {
                    HStack {
                        Text(examDate.formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(examName.isEmpty ? .secondary : .primary)

                        Spacer()

                        Button {
                            showingDatePicker = true
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                        }
                    }
                }

                if !examName.isEmpty {
                    Section("倒计时预览") {
                        let days = examDate.daysUntilToday
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("距离考试")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(days)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(days < 0 ? .gray : days <= 7 ? .red : days <= 30 ? .orange : .green)
                            }
                            Text(days < 0 ? "已过期" : days == 0 ? "就是今天！" : "天后")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("添加考试")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("添加") {
                        guard !examName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        store.addExam(name: examName.trimmingCharacters(in: .whitespaces), date: examDate)
                        dismiss()
                    }
                    .disabled(examName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .sheet(isPresented: $showingDatePicker) {
                DatePickerPickerView(selectedDate: $examDate)
            }
        }
    }
}

// MARK: - Custom DatePicker Sheet

struct DatePickerPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDate: Date

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()

                Spacer()
            }
            .navigationTitle("选择日期")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("确定") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Preview

struct AddExamView_Previews: PreviewProvider {
    static var previews: some View {
        AddExamView(store: ExamStore())
    }
}
