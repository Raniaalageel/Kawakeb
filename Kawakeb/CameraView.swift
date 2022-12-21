//
//  cameraViewController.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 21/05/1444 AH.
//


import UIKit
import AVFoundation
import Vision

class CameraView: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var bu: UIButton!
    
    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    var detectionOverlay: CALayer! = nil
    
    var requests = [VNRequest]()
    var boxesLayer: CALayer = CALayer()
    
    
    let label: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Guess"
        label.textAlignment = .center
        label.font = label.font.withSize(24)
        return label
    }()
    private let shuterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100) )
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    let confidentlabel: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Guess"
        label.font = label.font.withSize(24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("beforeCamera")
        
        
        //  setupCaptureSession() // Do any additional setup after loading the view.
    }
    
    func setupAVCapture() {
        let session = AVCaptureSession()
        var previewLayer: AVCaptureVideoPreviewLayer! = nil
        let deviceInput: AVCaptureDeviceInput!
        let videoDataOutput = AVCaptureVideoDataOutput()
        let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
        //search for camera
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first
        
        do{
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        }catch{
            print(error.localizedDescription)
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480
        
        guard session.canAddInput(deviceInput) else {
            print("Could not add video input to the session")
            session.commitConfiguration()
            return
        }
        
        session.addInput(deviceInput)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        
        let captureConnection = videoDataOutput.connection(with: .video)
        captureConnection?.isEnabled = true
        
        do {
            try videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        
        session.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = view.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
        session.startRunning()
    }
    
    func setupVision() {
        guard let model = try? VNCoreMLModel(for: MyObjectDetectorsh().model) else { return }
        let request = VNCoreMLRequest(model: model) { (request , err) in
            //print("request")
            if let results = request.results {
                self.drawVisionRequestResults(results: results)
            }
        }
        self.requests = [request]
    }
    
    func setupLayers() {
        detectionOverlay = CALayer()
        detectionOverlay.bounds = CGRect(x: 0, y: 0, width: bufferSize.width, height: bufferSize.height)
        detectionOverlay.position = .init(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        rootLayer.addSublayer(detectionOverlay)
    }
    
    
    
    @IBAction func startCamera(_ sender: Any) {
        
        
        setupAVCapture()
        setupLayers()
        setupVision()
        
        
        //            //setup output , add output to our capture session
        //            let captureOutput = AVCaptureVideoDataOutput()
        //            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        //            captureSession.addOutput(captureOutput)
        //
        //            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //            previewLayer.frame = view.frame
        //            view.layer.addSublayer(previewLayer)
        //
        //            captureSession.startRunning()
        //            view.addSubview(shuterButton)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("drop")
    }
    
    func drawVisionRequestResults(results: [Any]) {
        //print("drawVisionRequestResults")
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        detectionOverlay.sublayers = nil
        
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
            
            //print("~~~", objectObservation.labels[0])
            let topLabelObservation = objectObservation.labels[0]
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
            print(topLabelObservation.identifier)
            let shapeLayer = self.createRoundedRectWithBounds(objectBounds)
            print(shapeLayer.bounds)
          
            let textLayer = self.createTextSubLayerInBounds(objectBounds,identifier: topLabelObservation.identifier,confidence: topLabelObservation.confidence)
            
            shapeLayer.addSublayer(textLayer)
            
            
            detectionOverlay.addSublayer(shapeLayer)
            
            
            
        }
        
        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    func updateLayerGeometry() {
        let bounds = rootLayer.bounds
        var scale: CGFloat
        
        let xScale: CGFloat = bounds.size.width / bufferSize.height
        let yScale: CGFloat = bounds.size.height / bufferSize.width
        
        scale = fmax(xScale, yScale)
        if scale.isInfinite {
            scale = 1.0
        }
        
        CATransaction.begin()
        
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
        detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)
        CATransaction.commit()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("captureOutput")
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequsetHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try imageRequsetHandler.perform(self.requests)
        } catch {
            print(error)
        }
        
//        guard let model = try? VNCoreMLModel(for: MobileNetV2FP16().model) else { return }
//
//        let request = VNCoreMLRequest(model: model) { (request , err) in
//            print("request")
//            if let results = request.results {
//                self.drawVisionRequestResults(results: results)
//            }
//            //            guard let results = request.results as? [VNClassificationObservation] else {     print("notdefined",err);   return}
//            //            print("results")
//            //           guard let observation = results.first else {return}
//            //            print("observation")
//            //            DispatchQueue.main.async {
//            //                    print("identifier is ",observation.identifier)
//            //                    print("confidence is",observation.confidence)
//            //                }
//        }
                        
    }
    
    func createRoundedRectWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        print(bounds.midX, bounds.midY)
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.backgroundColor = .init(red: 255/255, green: 0, blue: 0, alpha: 1)
        return shapeLayer
    }
    
    func setUplabel(){
        print("setUplabel")
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        confidentlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        confidentlabel.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
    }
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
           let textLayer = CATextLayer()
           textLayer.name = "Object Label"
        
           let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfi:  %.2f", confidence))
        
           let largeFont = UIFont(name: "Helvetica", size: 18.0)!
        
           formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        
           textLayer.string = formattedString
           textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
           textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
           textLayer.shadowOpacity = 0.7
           textLayer.shadowOffset = CGSize(width: 2, height: 2)
           textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
           textLayer.contentsScale = 2.0 // retina rendering
           // rotate the layer into screen orientation and scale and mirror
           textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
           return textLayer
       }
    
    
}
