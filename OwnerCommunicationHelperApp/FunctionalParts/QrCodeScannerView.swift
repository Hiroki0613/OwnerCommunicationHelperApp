//
//  QrCodeScannerView.swift
//  OwnerCommunicationHelperApp
//
//  Created by 近藤宏輝 on 2023/01/13.
//

//import ComposableArchitecture
//import AVFoundation
//import SwiftUI
//import UIKit
//
//// https://github.com/jollyjoester/QRReaderSample
//struct QrCodeScannerView: UIViewControllerRepresentable {
//    let viewStore: ViewStore<WorkerNewRegistrationQrScanState, WorkerNewRegistrationQrScanAction>
//
//    func makeUIViewController(context: Context) -> QrCodeScannerVC {
//        QrCodeScannerVC(
//            viewStore: viewStore
//        )
//    }
//
//    func updateUIViewController(_ uiViewController: QrCodeScannerVC, context: Context) {
//    }
//}
//
//final class QrCodeScannerVC: UIViewController {
//    let viewStore: ViewStore<WorkerNewRegistrationQrScanState, WorkerNewRegistrationQrScanAction>
//
//    var preview = UIView()
//    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
//        let layer = AVCaptureVideoPreviewLayer(session: self.session)
//        layer.frame = preview.bounds
//        layer.videoGravity = .resizeAspectFill
//        layer.connection?.videoOrientation = .portrait
//        return layer
//    }()
//    var detectArea = UIView() {
//        didSet {
//            detectArea.layer.borderWidth = 3.0
//            detectArea.layer.borderColor = UIColor.red.cgColor
//        }
//    }
//    private var boundingBox = CAShapeLayer()
//    private var scannedQRs = Set<String>()
//    private let session = AVCaptureSession()
//    private let sessionQueue = DispatchQueue(label: "sessionQueue")
//    private var videoDevice: AVCaptureDevice?
//    private var videoDeviceInput: AVCaptureDeviceInput?
//    private let metadataOutput = AVCaptureMetadataOutput()
//    private let metadataObjectQueue = DispatchQueue(label: "metadataObjectQueue")
//
//    init(viewStore: ViewStore<WorkerNewRegistrationQrScanState, WorkerNewRegistrationQrScanAction>) {
//        self.viewStore = viewStore
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        preview = UIView(
//            frame: CGRect(
//                x: 0,
//                y: 0,
//                width: UIScreen.main.bounds.size.width,
//                height: UIScreen.main.bounds.size.height
//            )
//        )
//        preview.contentMode = UIView.ContentMode.scaleAspectFit
//        view.addSubview(preview)
//        detectArea = UIView(
//            frame: CGRect(
//                x: view.frame.width / 4,
//                y: view.frame.height / 4,
//                width: view.frame.width / 2,
//                height: view.frame.width / 2
//            )
//        )
//        view.addSubview(detectArea)
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            break
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if !granted {
//                    // 😭
//                }
//            }
//        default:
//            print("The user has previously denied access.")
//        }
//        DispatchQueue.main.async {
//            self.setupBoundingBox()
//        }
//        sessionQueue.async {
//            self.configureSession()
//        }
//        preview.layer.addSublayer(previewLayer)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        sessionQueue.async {
//            DispatchQueue.main.async {
//                let metadataOutputRectOfInterest =
//                self.previewLayer.metadataOutputRectConverted(
//                    fromLayerRect: self.detectArea.frame
//                )
//                self.sessionQueue.async {
//                    self.metadataOutput.rectOfInterest = metadataOutputRectOfInterest
//                }
//            }
//            self.session.startRunning()
//        }
//    }
//
//    // MARK: configureSession
//    private func configureSession() {
//        session.beginConfiguration()
//        let defaultVideoDevice = AVCaptureDevice.default(
//            .builtInWideAngleCamera,
//            for: .video,
//            position: .back
//        )
//        guard let videoDevice = defaultVideoDevice else {
//            session.commitConfiguration()
//            return
//        }
//        do {
//            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
//            if session.canAddInput(videoDeviceInput) {
//                session.addInput(videoDeviceInput)
//                self.videoDeviceInput = videoDeviceInput
//            }
//        } catch {
//            session.commitConfiguration()
//            return
//        }
//        if session.canAddOutput(metadataOutput) {
//            session.addOutput(metadataOutput)
//            metadataOutput.setMetadataObjectsDelegate(self, queue: metadataObjectQueue)
//            metadataOutput.metadataObjectTypes = [.qr]
//        } else {
//            session.commitConfiguration()
//        }
//        session.commitConfiguration()
//    }
//
//    // Draw bounding box
//    private func updateBoundingBox(_ points: [CGPoint]) {
//        guard let firstPoint = points.first else {
//            return
//        }
//        let path = UIBezierPath()
//        path.move(to: firstPoint)
//        var newPoints = points
//        newPoints.removeFirst()
//        newPoints.append(firstPoint)
//        newPoints.forEach { path.addLine(to: $0) }
//        boundingBox.path = path.cgPath
//        boundingBox.isHidden = false
//    }
//
//    private var resetTimer: Timer?
//    fileprivate func hideBoundingBox(after: Double) {
//        resetTimer?.invalidate()
//        resetTimer = Timer.scheduledTimer(
//            withTimeInterval: TimeInterval() + after,
//            repeats: false) { [weak self] _ in
//                self?.boundingBox.isHidden = true
//            }
//    }
//
//    private func setupBoundingBox() {
//        boundingBox.frame = preview.layer.bounds
//        boundingBox.strokeColor = UIColor.green.cgColor
//        boundingBox.lineWidth = 4.0
//        boundingBox.fillColor = UIColor.clear.cgColor
//        preview.layer.addSublayer(boundingBox)
//    }
//
//    // MARK: Haptic feedback
//    private func hapticSuccessNotification() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.prepare()
//        generator.notificationOccurred(.success)
//    }
//}

//extension QrCodeScannerVC: AVCaptureMetadataOutputObjectsDelegate {
//    func metadataOutput(
//        _ output: AVCaptureMetadataOutput,
//        didOutput metadataObjects: [AVMetadataObject],
//        from connection: AVCaptureConnection
//    ) {
//        for metadataObject in metadataObjects {
//            guard let machineReadableCode = metadataObject as? AVMetadataMachineReadableCodeObject,
//                  machineReadableCode.type == .qr,
//                  let stringValue = machineReadableCode.stringValue
//            else { return }
//            print("hirohiro_new_stringValue: ", stringValue)
//            guard let transformedObject = previewLayer.transformedMetadataObject(for: machineReadableCode) as? AVMetadataMachineReadableCodeObject else { return }
//            DispatchQueue.main.async {
//                self.updateBoundingBox(transformedObject.corners)
//                if !self.scannedQRs.contains(stringValue) {
//                    self.scannedQRs.insert(stringValue)
//                    self.hapticSuccessNotification()
//                }
//                self.hideBoundingBox(after: 0.1)
//                self.viewStore.send(.scanQrCodeResult(result: stringValue))
//            }
//        }
//    }
//}
