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
  var mySuperView: DriverLicenseEnrollinitVC?
  
  var captureSession = AVCaptureSession()
  var backCamera: AVCaptureDevice?
  var frontCamera: AVCaptureDevice?
  var currentCamera: AVCaptureDevice?
  
  var photoOutput: AVCapturePhotoOutput?
  
  var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
  let videoDataOutput = AVCaptureVideoDataOutput()
  
  var image: UIImage?
  var isRecognizeImageInRect: Bool = false
  var isFinish: Bool = false
  var croppedImages: [UIImage] = []
  var mainImage: UIImage = UIImage()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    configureButtonAction()
    configureCameraFeature()
    configureMyView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  private func configureMyView() {
    view.addSubview(myView)
    myView.frame = self.view.frame
  }
  
  private func configureNavigationController() {
    self.navigationController?.navigationBar.topItem?.title = ""
    let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tapCancelButton))
    navigationItem.rightBarButtonItem = cancelButton
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
      //      videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "MyQueue"))
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
    isRecognizeImageInRect = false
    if topRecSucess && bottomRecSucess == true {
      isRecognizeImageInRect = true
    }
  }
  
  // MARK: - Vision For Recognize Text
  private func detectTextRectangle(in image: CVPixelBuffer) {
    let request = VNDetectTextRectanglesRequest { (request, error) in
      if let error = error {
        print("Error", error.localizedDescription)
        return
      } else {
        DispatchQueue.main.async {
          guard let results = request.results as? [VNTextObservation] else { return }
          self.drawTextBoundingBox(rect: results)
        }
      }
    }
    request.reportCharacterBoxes = true
    
    let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
    try? imageRequestHandler.perform([request])
  }
  
  func drawTextBoundingBox(rect: [VNTextObservation]) {
    guard let cameraPreviewLayer = cameraPreviewLayer else { return }
    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -cameraPreviewLayer.frame.height)
    let scale = CGAffineTransform.identity.scaledBy(x: cameraPreviewLayer.frame.width, y: cameraPreviewLayer.frame.height)
    rect.forEach {
      let bounds = $0.boundingBox.applying(scale).applying(transform)
      print(bounds)
      createTextBox(in: bounds)
      
      let croppedCGImage: CGImage = (mainImage.cgImage?.cropping(to: $0.boundingBox))!
      let croppedImage = UIImage(cgImage: croppedCGImage)
      croppedImages.append(croppedImage)
    }
    myView.activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.myView.activityIndicator.stopAnimating()
      self.dismiss(animated: true) {
        guard let superView = self.mySuperView else { return }
        let checkDriverLicenseVC = CheckDriverLicenseVC()
        superView.navigationController?.pushViewController(checkDriverLicenseVC, animated: true)
      }
    }
  }
  
  private func createTextBox(in bounds: CGRect) {
    let layer = CALayer()
    layer.borderWidth = 2
    layer.borderColor = UIColor.green.cgColor
    layer.frame = bounds
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
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func cameraButtonTouchInside(_ sender: Any) {
    let settings = AVCapturePhotoSettings()
    photoOutput?.capturePhoto(with: settings, delegate: self)
  }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CustomCameraVC: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    print("Get Image")
    if let imageDate = photo.fileDataRepresentation() {
      print(imageDate)
      image = UIImage(data: imageDate)
      myView.backgroundView.image = image
      captureSession.stopRunning()
      myView.activityIndicator.startAnimating()
    }
  }
  
  func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    let  imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly)
    
    // Get the number of bytes per row for the pixel buffer
    let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer!)
    
    // Get the number of bytes per row for the pixel buffer
    let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer!)
    // Get the pixel buffer width and height
    let width = CVPixelBufferGetWidth(imageBuffer!)
    let height = CVPixelBufferGetHeight(imageBuffer!)
    
    // Create a device-dependent RGB color space
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    // Create a bitmap graphics context with the sample buffer data
    var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Little.rawValue
    bitmapInfo |= CGImageAlphaInfo.premultipliedFirst.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
    //let bitmapInfo: UInt32 = CGBitmapInfo.alphaInfoMask.rawValue
    let context = CGContext.init(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
    // Create a Quartz image from the pixel data in the bitmap graphics context
    let quartzImage = context?.makeImage()
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer!, CVPixelBufferLockFlags.readOnly)
    
    // Create an image object from the Quartz image
    return  UIImage.init(cgImage: quartzImage!)
  }
}

extension CustomCameraVC: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      debugPrint("unable to get image from sample buffer")
      return
    }
    self.detectRectangle(in: imageBuffer)
    if isRecognizeImageInRect == true {
      mainImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer)
      if isFinish == false {
        self.detectTextRectangle(in: imageBuffer)
        isFinish = true
      }
    }
  }
  
  func orientation() -> UIImage.Orientation {
    let curDeviceOrientation = UIDevice.current.orientation
    var exifOrientation: UIImage.Orientation
    switch curDeviceOrientation {
    case .portraitUpsideDown:  // Device oriented vertically, Home button on the top
      exifOrientation = .left
    case .landscapeLeft:       // Device oriented horizontally, Home button on the right
      exifOrientation = .upMirrored
    case .landscapeRight:      // Device oriented horizontally, Home button on the left
      exifOrientation = .down
    case .portrait:            // Device oriented vertically, Home button on the bottom
      exifOrientation = .up
    default:
      exifOrientation = .up
    }
    return exifOrientation
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

extension UIImage {
  func crop( rect: CGRect) -> UIImage {
    var rect = rect
    rect.origin.x*=self.scale
    rect.origin.y*=self.scale
    rect.size.width*=self.scale
    rect.size.height*=self.scale
    
    let imageRef = self.cgImage!.cropping(to: rect)
    let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
    return image
  }
}
