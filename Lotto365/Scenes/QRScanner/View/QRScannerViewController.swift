//
//  QRScannerViewController.swift
//  Lotto365
//
//  Created by Song on 20/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import AVFoundation
import RxSwift
import RxCocoa
import UIKit

class QRScannerViewController: BaseViewController {
    public var viewModel: QRScannerViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "imageToolbarCloseWhite"), for: .normal)
        return btn
    }()
    
    private let qrCaptureFrameImgView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "imgTransferQrcodeFrame"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCaptureSession()
        captureSession.startRunning()
        
        setUI()
        
        let input = QRScannerViewModel.Input(closeTrigger: closeBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        output.close
            .drive()
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
            dismiss(animated: true) {
                guard let url = URL(string: stringValue) else { return }
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }

}

//MARK: - Private
extension QRScannerViewController {
    private func configureCaptureSession() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.black
        
        self.view.addSubview(closeBtn)
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            closeBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.view.addSubview(qrCaptureFrameImgView)
        NSLayoutConstraint.activate([
            qrCaptureFrameImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCaptureFrameImgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCaptureFrameImgView.widthAnchor.constraint(equalToConstant: 260),
            qrCaptureFrameImgView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    private func found(code: String) {
        print(code)
    }
}
