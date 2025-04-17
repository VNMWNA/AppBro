import SwiftUI
import WebKit

// URLInputView.swift
struct URLInputView: View {
    @State private var text = ""
    var onSubmit: (URL) -> Void

    @StateObject private var bookmarkManager = BookmarkManager()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter URL", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    if let url = URL(string: text) {
                        onSubmit(url)
                        bookmarkManager.addBookmark(url)
                    }
                }

            // ブックマーク一覧
            List {
                ForEach(bookmarkManager.bookmarks, id: \.self) { url in
                    Button(action: {
                        onSubmit(url)
                    }) {
                        Text(url.absoluteString)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { bookmarkManager.bookmarks[$0] }.forEach {
                        bookmarkManager.removeBookmark($0)
                    }
                }
            }
        }
    }
}
