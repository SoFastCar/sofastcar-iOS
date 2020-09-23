//
//  NewDriverLicenseEnrollinitVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/23.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class NewDriverLicenseEnrollinitVC: UIViewController {
  // MARK: - Properties
  let myView = NewDriverLicenseEnrollinitView()
  
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
    configureNavigationController()
    configureButtonAction()
    configureCameraFeature()
    configureMyView()
  }
  
  private func configureMyView() {
    view.addSubview(myView)
    myView.frame = self.view.frame
  }
  
  private func configureNavigationController() {
    self.navigationController?.navigationBar.topItem?.title = ""
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tapCancelButton))
    navigationController?.navigationBar.backIndicatorImage = UIImage()
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    navigationController?.navigationBar.barTintColor = CommonUI.mainDark
    navigationController?.navigationBar.tintColor = .white
  }
  
  private func configureButtonAction() {
    myView.captureButton.addTarget(self, action: #selector(cameraButtonTouchInside(_:)), for: .touchUpInside)
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
  
  // MARK: - button Action
  @objc private func tapCancelButton() {
    navigationController?.navigationBar.isHidden = false
    navigationController?.popViewController(animated: false)
  }
  
  @objc private func cameraButtonTouchInside(_ sender: Any) {
    let settings = AVCapturePhotoSettings()
    photoOutput?.capturePhoto(with: settings, delegate: self)
  }
}

extension NewDriverLicenseEnrollinitVC: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if let imageDate = photo.fileDataRepresentation() {
      print(imageDate)
      image = UIImage(data: imageDate)
    }
  }
}
