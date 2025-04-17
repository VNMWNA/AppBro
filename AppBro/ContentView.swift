//
//  ContentView.swift
//  AppBro
//
//  Created by TAMA on 2025/03/18.
//

import SwiftUI
import WebKit
import MediaPlayer
import AVFoundation

// ContentView.swift
struct ContentView: View {
    /// 現在のURLを保持するステートプロパティ
    @State private var url: URL? = nil
    /// URL入力ビューを表示するかどうかを制御するステートプロパティ
    @State private var showURLInput = true
    /// 音量の変化を監視するオブジェクト
    @StateObject private var volumeMonitor = VolumeMonitor()
    
    /// ビューの本体
    var body: some View {
        ZStack {
            if showURLInput {
                URLInputView { enteredURL in
                    url = enteredURL
                    showURLInput = false
                }
            } else {
                WebView(url: $url)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture(count: 2) { location in
                        let screenWidth = UIScreen.main.bounds.width
                        if location.x < screenWidth / 2 {
                            goBack()
                        } else {
                            goForward()
                        }
                    }
            }
        }
        .onChange(of: volumeMonitor.volumeIsZero) { _, isZero in
            // 音量が0.0になったときだけホームに戻る
            if isZero{
                showURLInput = true
                url = nil
            }
        }
    }
    private func goBack() {
        let webview = WebView(url: $url)
        webview.goBack()
    }
    private func goForward() {
        let webview = WebView(url: $url)
        webview.goForward()
    }
}
