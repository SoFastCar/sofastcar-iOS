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
  var isRecognizeImageInRect: Bool = false
  
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
    cameraPreviewLayer?.frame = self.view.frame
    myView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
  }
  
  private func startRunningCAptureSession() {
    captureSession.startRunning()
  }
  
  // MARK: - Setting Vision For Recognize Rectangle
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
    request.minimumSize = Float(0.4)
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
    
    if topRecSucess && bottomRecSucess == true {
      print("capture")
      let settings = AVCapturePhotoSettings()
      photoOutput?.capturePhoto(with: settings, delegate: self)
      captureSession.stopRunning()
      myView.activityIndicator.startAnimating()
    }
  }
  
  // MARK: - Vision For Recognize Text
  private func createTextBox(in bounds: CGRect) {
    let layer = CALayer()
    view.layer.addSublayer(layer)
    layer.borderWidth = 2
    layer.borderColor = UIColor.green.cgColor

//    let rect = cameraPreviewLayer?.layerRectConverted(fromMetadataOutputRect: bounds)
    layer.frame = boundingBox(forRegionOfInterest: myView.rect, withinImageBounds: bounds)
    cameraPreviewLayer?.addSublayer(layer)
  }
  
  fileprivate func boundingBox(forRegionOfInterest: CGRect, withinImageBounds bounds: CGRect) -> CGRect {
      let imageWidth = bounds.width
      let imageHeight = bounds.height
      
      // Begin with input rect.
      var rect = forRegionOfInterest
      
      // Reposition origin.
      rect.origin.x *= imageWidth
      rect.origin.x += bounds.origin.x
      rect.origin.y = (1 - rect.origin.y) * imageHeight + bounds.origin.y
      
      // Rescale normalized coordinates.
      rect.size.width *= imageWidth
      rect.size.height *= imageHeight
      
      return rect
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

// Convert UIImageOrientation to CGImageOrientation for use in Vision analysis.
extension CGImagePropertyOrientation {
    init(_ uiImageOrientation: UIImage.Orientation) {
        switch uiImageOrientation {
        case .up: self = .up
        case .down: self = .down
        case .left: self = .left
        case .right: self = .right
        case .upMirrored: self = .upMirrored
        case .downMirrored: self = .downMirrored
        case .leftMirrored: self = .leftMirrored
        case .rightMirrored: self = .rightMirrored
        @unknown default:
          fatalError()
        }
    }
}
