//
//  ExamStore.swift
//  ExamCountdown
//
//  Created by ExamTimer on 2026/07/11.
//

import Foundation
import Combine

@MainActor
class ExamStore: ObservableObject {
    @Published var exams: [Exam] = [] {
        didSet { saveExams() }
    }

    init() {
        loadExams()
    }

    // MARK: - CRUD

    func addExam(name: String, date: Date) {
        let exam = Exam(name: name, date: date)
        exams.append(exam)
    }

    func removeExam(at offsets: IndexSet) {
        exams.remove(atOffsets: offsets)
    }

    func removeExam(id: UUID) {
        exams.removeAll { $0.id == id }
    }

    // MARK: - Persistence

    private func saveExams() {
        if let encoded = try? JSONEncoder().encode(exams) {
            UserDefaults.standard.set(encoded, forKey: "SavedExams")
        }
    }

    private func loadExams() {
        if let data = UserDefaults.standard.data(forKey: "SavedExams"),
           let decoded = try? JSONDecoder().decode([Exam].self, from: data) {
            exams = decoded.sorted { $0.date < $1.date }
        }
    }
}
