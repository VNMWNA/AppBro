import Foundation
import MediaPlayer
import AVFoundation
import Combine

// 音量の変化を安定して検知するための監視クラス
class VolumeMonitor: ObservableObject {
    private var displayLink: CADisplayLink?
    private var lastVolume: Float = AVAudioSession.sharedInstance().outputVolume
    @Published var volumeIsZero = false

    init() {
        // 音量UIを表示しないようにするための処理（バックグラウンドビュー）
        let _ = MPVolumeView(frame: .zero)

        try? AVAudioSession.sharedInstance().setActive(true)

        // 監視スタート（約60fps）
        displayLink = CADisplayLink(target: self, selector: #selector(checkVolume))
        displayLink?.add(to: .main, forMode: .default)
    }

    deinit {
        displayLink?.invalidate()
    }

    // 音量をチェックして0.0になったか確認
    @objc private func checkVolume() {
        let currentVolume = AVAudioSession.sharedInstance().outputVolume
        if currentVolume == 0.0 && lastVolume != 0.0 {
            volumeIsZero = true
        } else if currentVolume > 0.0 {
            volumeIsZero = false
        }
        lastVolume = currentVolume
    }
}

