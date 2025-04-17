import SwiftUI
import WebKit

// WebView.swift
struct WebView: UIViewRepresentable {
    @Binding var url: URL?
    let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    func goBack() {
        if webView.canGoBack { webView.goBack() }
    }
    
    func goForward() {
        if webView.canGoForward { webView.goForward() }
    }
}

