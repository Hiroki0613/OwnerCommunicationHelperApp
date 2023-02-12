//
//  AVCaptureDevice+Ext.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/02/12.
//

// https://github.com/athanasiospap/Pulse
import Foundation
import AVFoundation

extension AVCaptureDevice {
    private func availableFormatsFor(preferredFps: Float64) -> [AVCaptureDevice.Format] {
        var availableFormats: [AVCaptureDevice.Format] = []
        for format in formats {
            let ranges = format.videoSupportedFrameRateRanges
            for range in ranges where range.minFrameRate <= preferredFps && preferredFps <= range.maxFrameRate {
                availableFormats.append(format)
            }
        }
        return availableFormats
    }

    private func formatWithHighestResolution(_ availableFormats: [AVCaptureDevice.Format]) -> AVCaptureDevice.Format? {
        var maxWidth: Int32 = 0
        var selectedFormat: AVCaptureDevice.Format?
        for format in availableFormats {
            let desc = format.formatDescription
            let dimensions = CMVideoFormatDescriptionGetDimensions(desc)
            let width = dimensions.width
            if width >= maxWidth {
                maxWidth = width
                selectedFormat = format
            }
        }
        return selectedFormat
    }

    private func formatFor(
        preferredSize: CGSize,
        availaleFormats: [AVCaptureDevice.Format]
    ) -> AVCaptureDevice.Format? {
        for format in availaleFormats {
            let desc = format.formatDescription
            let dimensions = CMVideoFormatDescriptionGetDimensions(desc)
            if dimensions.width >= Int32(preferredSize.width) && dimensions.height >= Int32(preferredSize.height) {
                return format
            }
        }
        return nil
    }

    func updateFormatWithPreferredVideoSpec(preferredSpec: VideoSpec) {
        let availableFormats: [AVCaptureDevice.Format]
        if let preferredFps = preferredSpec.fps {
            availableFormats = availableFormatsFor(preferredFps: Float64(preferredFps))
        } else {
            availableFormats = formats
        }
        var selectedFormat: AVCaptureDevice.Format?
        if let prefferedSize = preferredSpec.size {
            selectedFormat = formatFor(preferredSize: prefferedSize, availaleFormats: availableFormats)
        } else {
            selectedFormat = formatWithHighestResolution(availableFormats)
        }
        print("selected format: \(String(describing: selectedFormat))")
        if let selectedFormat = selectedFormat {
            do {
                try lockForConfiguration()
            } catch let error {
                fatalError(error.localizedDescription)
            }
            activeFormat = selectedFormat
            if let preferredFps = preferredSpec.fps {
                activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: preferredFps)
                activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: preferredFps)
                unlockForConfiguration()
            }
        }
    }

    // swiftlint:disable identifier_name
    func toggleTorch(on: Bool) {
        guard hasTorch, isTorchAvailable else {
            return
        }
        do {
            try lockForConfiguration()
            torchMode = on ? .on : .off
            unlockForConfiguration()
        } catch {
            print("Torch could not be used \(error)")
        }
    }
    // swiftlint:enable identifier_name
}
