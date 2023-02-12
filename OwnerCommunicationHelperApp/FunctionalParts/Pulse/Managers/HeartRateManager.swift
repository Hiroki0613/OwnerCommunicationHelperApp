//
//  HeartRateManager.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/02/12.
//

// https://github.com/athanasiospap/Pulse
import Foundation
import AVFoundation

enum CameraType: Int {
    case back
    case front

    func captureDevice() -> AVCaptureDevice {
        switch self {
        case .front:
            let devices = AVCaptureDevice.DiscoverySession(
                deviceTypes: [],
                mediaType: AVMediaType.video,
                position: .front
            ).devices
            print("devices:\(devices)")
            for device in devices where device.position == .front {
                return device
            }
        default:
            break
        }
        // TODO: 暫定で強制アンラップをしているので注意
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
    }
}

struct VideoSpec {
    var fps: Int32?
    var size: CGSize?
}

typealias ImageBufferHandler = ( (_ imageBuffer: CMSampleBuffer) -> Void )

class HeartRateManager: NSObject {
    private let captureSession = AVCaptureSession()
    // TODO: 暫定対応で強制アンラップを入れています
    private var videoDevice: AVCaptureDevice!
    private var videoConnection: AVCaptureConnection!
    private var audioConnection: AVCaptureConnection!
    private var previewLayer: AVCaptureVideoPreviewLayer?
    var imageBufferHandler: ImageBufferHandler?

    init(cameraType: CameraType, preferredSpec: VideoSpec?, previewContainer: CALayer?) {
        super.init()
        videoDevice = cameraType.captureDevice()
        // MARK: - Setup Video Format
        do {
            captureSession.sessionPreset = .low
            if let preferredSpec = preferredSpec {
                // Update the format with a preferred fps
                videoDevice.updateFormatWithPreferredVideoSpec(preferredSpec: preferredSpec)
            }
        }
        // MARK: - Setup video device input
        let videoDeviceInput: AVCaptureDeviceInput
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch let error {
            fatalError("Could not create AVCaptureDeviceInput instance with error: \(error).")
        }
        guard captureSession.canAddInput(videoDeviceInput) else { fatalError() }
        captureSession.addInput(videoDeviceInput)
        // MARK: - Setup preview layer
        if let previewContainer = previewContainer {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = previewContainer.bounds
            previewLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewContainer.insertSublayer(previewLayer, at: 0)
            self.previewLayer = previewLayer
        }
        // MARK: - Setup video output
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey: NSNumber(value: kCVPixelFormatType_32BGRA)
        ]
        as
        [String: Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "com.covidsense.videosamplequeue")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        guard captureSession.canAddOutput(videoDataOutput) else { fatalError() }
        captureSession.addOutput(videoDataOutput)
        videoConnection = videoDataOutput.connection(with: .video)
    }

    func startCapture() {
        if captureSession.isRunning {
            return
        }
        captureSession.startRunning()
    }

    func stopCapture() {
        if !captureSession.isRunning {
            return
        }
        captureSession.stopRunning()
    }
}

extension HeartRateManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    // MARK: - Export buffer from video frame
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        if connection.videoOrientation != .portrait {
            connection.videoOrientation = .portrait
            return
        }
        if let imageBufferHandler = imageBufferHandler {
            imageBufferHandler(sampleBuffer)
        }
    }
}
