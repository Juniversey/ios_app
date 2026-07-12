//
//  ContentView.swift
//  ExamCountdown
//
//  Created by ExamTimer on 2026/07/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = ExamStore()
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if store.exams.isEmpty {
                    EmptyView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(store.exams) { exam in
                                ExamCardView(exam: exam)
                            }
                        }
                        .padding(.horizontal, 4)
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("考试倒计时")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddExamView(store: store)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Empty State

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge-clock")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
                .padding(.top, 80)
            Text("还没有添加考试")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text("点击右上角 + 添加你的第一个考试")
                .font(.body)
                .foregroundColor(.secondary)
                .opacity(0.7)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
