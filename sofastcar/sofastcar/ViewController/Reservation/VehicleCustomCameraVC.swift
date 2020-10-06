//
//  VehicleCustomCameraVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/10/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class VehicleCustomCameraVC: UIViewController {
  // MARK: - Properties
  let myView = VehicleCustomCameraView()
  
  var captureSession = AVCaptureSession()
  var backCamera: AVCaptureDevice?
  var frontCamera: AVCaptureDevice?
  var currentCamera: AVCaptureDevice?
  var photoOutput: AVCapturePhotoOutput?
  var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
  var image: UIImage?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureButtonAction()
    configureCameraFeature()
    configureMyView()
    setNavigation()
  }
  
  private func configureMyView() {
    view.addSubview(myView)
    myView.frame = self.view.frame
  }
  
  private func configureButtonAction() {
    myView.captureButton.addTarget(self, action: #selector(cameraButtonTouchInside(_:)), for: .touchUpInside)
  }
  
  fileprivate func setNavigation() {
    self.navigationController?.isNavigationBarHidden = true
  }
  
  // MARK: - configure Camera
  private func configureCameraFeature() {
    setupCaptureSession()
    setupDevice()
    setupInputOutput()
    setupPreviewLayer()
    startRunningCAptureSession()
  }
  
  private func setupCaptureSession() {
    captureSession.sessionPreset = .photo
  }
  
  private func setupDevice() {
    let deviceDiscroverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
    let devices = deviceDiscroverySession.devices
    
    for device in devices {
      if device.position == AVCaptureDevice.Position.back {
        backCamera = device
      } else if device.position == AVCaptureDevice.Position.front {
        frontCamera = device
      }
    }
    currentCamera = backCamera
  }
  
  private func setupInputOutput() {
    do {
      let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
      captureSession.addInput(captureDeviceInput)
      photoOutput = AVCapturePhotoOutput()
      photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
      captureSession.addOutput(photoOutput!)
    } catch {
      print(error)
    }
  }
  
  private func setupPreviewLayer() {
    cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
    cameraPreviewLayer?.frame = self.view.frame
    myView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
  }
  
  private func startRunningCAptureSession() {
    captureSession.startRunning()
  }
  
  // MARK: - Action
  
  @objc private func cameraButtonTouchInside(_ sender: Any) {
    let settings = AVCapturePhotoSettings()
    photoOutput?.capturePhoto(with: settings, delegate: self)
  }
}

extension VehicleCustomCameraVC: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if let imageDate = photo.fileDataRepresentation() {
      print(imageDate)
      image = UIImage(data: imageDate)
    }
  }
}
