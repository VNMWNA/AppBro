import Foundation

// ブックマークの管理を担当するクラス（URLの保存・読み込み）
class BookmarkManager: ObservableObject {
    @Published var bookmarks: [URL] = []

    init() {
        loadBookmarks()
    }

    // 新しいURLをブックマークに追加（重複は避ける）
    func addBookmark(_ url: URL) {
        if !bookmarks.contains(url) {
            bookmarks.append(url)
            saveBookmarks()
        }
    }

    // 指定したURLをブックマークから削除
    func removeBookmark(_ url: URL) {
        bookmarks.removeAll { $0 == url }
        saveBookmarks()
    }

    // ブックマークをUserDefaultsに保存（永続化）
    private func saveBookmarks() {
        let urls = bookmarks.map { $0.absoluteString }
        UserDefaults.standard.set(urls, forKey: "Bookmarks")
    }

    // 保存されているブックマークを読み込む
    private func loadBookmarks() {
        if let urlStrings = UserDefaults.standard.array(forKey: "Bookmarks") as? [String] {
            bookmarks = urlStrings.compactMap { URL(string: $0) }
        }
    }
}
