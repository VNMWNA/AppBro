import SwiftUI
import MediaPlayer

/// システムの音量スライダーを非表示で提供するビュー
/// `MPVolumeView` を使用して、システムの音量スライダーを非表示でビューに追加します。
/// これにより、アプリ内で音量ボタンを使用して音量を調整できるようになります。
struct VolumeView: UIViewRepresentable {
    /// `MPVolumeView` インスタンスを作成するメソッド
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView(frame: .zero)
        volumeView.isHidden = true // UIを非表示に設定
        return volumeView
    }

    /// `MPVolumeView` の更新処理
    func updateUIView(_ uiView: MPVolumeView, context: Context) {}
}

