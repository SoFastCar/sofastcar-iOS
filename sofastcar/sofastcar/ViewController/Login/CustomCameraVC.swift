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
import Vision

class CustomCameraVC: UIViewController {
  // MARK: - Properties
  let myView = CustomCameraView()
  
  var captureSession = AVCaptureSession()
  var backCamera: AVCaptureDevice?
  var frontCamera: AVCaptureDevice?
  var currentCamera: AVCaptureDevice?
  
  var photoOutput: AVCapturePhotoOutput?
  
  var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
  let videoDataOutput = AVCaptureVideoDataOutput()
  
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
      
      self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
      videoDataOutput.alwaysDiscardsLateVideoFrames = true
      videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
      captureSession.addOutput(self.videoDataOutput)
      guard let connection = self.videoDataOutput.connection(with: AVMediaType.video),
            connection.isVideoOrientationSupported else { return }
      connection.videoOrientation = .portrait
      
    } catch {
      print(error)
    }
  }
  
  private func setupPreviewLayer() {
    cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer?.videoGravity = .resizeAspectFill
    cameraPreviewLayer?.connection?.videoOrientation = .portrait
    
    let maskWidth = UIScreen.main.bounds.width*0.9
    let mastheight = maskWidth*0.63
    let rect = CGRect(x: UIScreen.main.bounds.width*0.05,
                      y: UIScreen.main.bounds.height/2-mastheight/2,
                      width: maskWidth,
                      height: mastheight)
    
    cameraPreviewLayer?.frame = self.view.frame
    myView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
  }
  
  private func startRunningCAptureSession() {
    captureSession.startRunning()
  }
  
  private func detectRectangle(in image: CVPixelBuffer) {
    let request = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, _: Error?) in
      DispatchQueue.main.async {
        guard let results = request.results as? [VNRectangleObservation] else { return }
        guard let rect = results.first else { return }
        self.drawBoundingBox(rect: rect)
        //        if self.isTapped{
        //          self.isTapped = false
        //          self.doPerspectiveCorrection(rect, from: image)
        //        }
      }
    })
    request.minimumAspectRatio = VNAspectRatio(1.5)
    request.maximumAspectRatio = VNAspectRatio(1.6)
    request.minimumSize = Float(0.3)
    request.maximumObservations = 1
    
    let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
    try? imageRequestHandler.perform([request])
  }
  
  func drawBoundingBox(rect: VNRectangleObservation) {
    guard let cameraPreviewLayer = cameraPreviewLayer else { return }
    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -cameraPreviewLayer.frame.height)
    let scale = CGAffineTransform.identity.scaledBy(x: cameraPreviewLayer.frame.width, y: cameraPreviewLayer.frame.height)
    let bounds = rect.boundingBox.applying(scale).applying(transform)
    createRecongSucessLayer(in: bounds)
  }
  
  private func createRecongSucessLayer(in rect: CGRect) {
    var topRecSucess = false
    var bottomRecSucess = false
    if rect.minY > myView.rect.minY { topRecSucess = true }
    if rect.maxY < myView.rect.maxY { bottomRecSucess = true }
    myView.regonSucessTopLine.backgroundColor = topRecSucess == true ? CommonUI.mainBlue : .clear
    myView.regonSucessBottomLine.backgroundColor = bottomRecSucess == true ? CommonUI.mainBlue : .clear
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

extension CustomCameraVC: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if let imageDate = photo.fileDataRepresentation() {
      print(imageDate)
      image = UIImage(data: imageDate)
    }
  }
}

extension CustomCameraVC: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      debugPrint("unable to get image from sample buffer")
      return
    }
    self.detectRectangle(in: frame)
  }
}
