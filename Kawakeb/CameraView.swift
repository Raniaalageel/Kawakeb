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
    
    var allLablels = [String]()
    
    var labels = ""
    
  
    
    let button = UIButton(frame: CGRect(x: 100, y: 700, width: 100, height: 50))
    
    let session = AVCaptureSession()
    
    
    private let shuterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100) )
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("beforeCamera")
        
        
        
        button.backgroundColor = .green
       button.setTitle("stop Button", for: .normal)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        //  setupCaptureSession() // Do any additional setup after loading the view.
    }
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    
        
        if session.isRunning {
                DispatchQueue.global().async {
                    self.session.stopRunning()
                }
            }
      //  forArray()
        print(" allLablels STOP REUNING", allLablels)
    }

    
    func setupAVCapture() {
        
       // self.view.addSubview(button)
        
     //   let session = AVCaptureSession()
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
        
        self.view.addSubview(button)
    }
    
    func setupVision() {
        guard let model = try? VNCoreMLModel(for: MyObjectDetector20dec().model) else { return }
        let request = VNCoreMLRequest(model: model) { [self] (request , err) in
            //print("request")
            if let results = request.results {
                self.drawVisionRequestResults(results: results)
               // let uniqueUnordered = Array(Set(allLablels))
               // let uniqueOrdered = Array(NSOrderedSet(array: allLablels))
               
               // print("uniqueUnordered",uniqueUnordered)
                //print("uniqueOrdered",uniqueOrdered)
             
                forArray()
                
                print("results stop now ")
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
            print("---")
            print("topLabelObservation.identifier",topLabelObservation.identifier)
           
            labels = topLabelObservation.identifier
            

            let shapeLayer = self.createRoundedRectWithBounds(objectBounds)
            
            print("shapeLayer.bounds",shapeLayer.bounds)
          
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
        //print("imageRequsetHandler",imageRequsetHandler)
       // print("sampleBuffer",sampleBuffer)
        do {
            try imageRequsetHandler.perform(self.requests)
        } catch {
            print(error)
        }
        
   
    }
    
    func createRoundedRectWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        
        
        shapeLayer.bounds = bounds
        
        print("bounds.midX, bounds.midY",bounds.midX, bounds.midY)
        var numberofx = Int(bounds.midX)
        var numberofy = Int(bounds.midY)
        
var numberofx2 = String(describing: numberofx)
var numberofy2 = String(describing: numberofy)
        
        labels = labels + ":" + numberofx2 + ":" + numberofy2
        
        print("labels",labels)
        
    allLablels.append(labels)
        print(" allLablels with append forArray ", allLablels)
        forArray()
      
        
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        shapeLayer.backgroundColor = .init(red: 255/255, green: 0, blue: 0, alpha: 1)
        return shapeLayer
    }
    
    func forArray(){
        var alliteration = 0
        while alliteration < allLablels.count  {
            var ch = Character(":")
            var result = allLablels[alliteration].split(separator: ch)
            
            var resultx = Int(result[1])!
            var resulty = Int(result[2])!
            var resullabel = String(result[0])
            
            print("resultx ",resultx)
            print("resulty ",resulty)
          print("resullabel",resullabel)

      var indexin = alliteration + 1
            while indexin < allLablels.count  {
                print("indexin",indexin)
                var result2 = allLablels[indexin].split(separator: ch)

                var resultxnext = Int(result2[1])!
                var resultynext = Int(result2[2])!
                var resullabelnext = String(result2[0])
                print("resultxnext",resultxnext)
                print("resultynext ",resultynext)
              print("resullabelnext",resullabelnext)
                
                if  ( resullabel.elementsEqual(resullabelnext)  ) {
                    print("resullabel==resullabelnext",resullabel,resullabelnext)

                if  ( resultx + 15 >= resultxnext  && resulty + 15 >= resultynext ){
                print(" if  ( resultx <= resultxnext + 10 || resulty <= resultynext + 10 )",resultx + 10,resultxnext , resulty + 10 , resultynext)
                    print(" remove XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

                    allLablels.remove(at: indexin)
                    print(" allLablels after remove ", allLablels)
                }
                }
              indexin += 1
            }
                
            
            print("alliteration",   alliteration)
        alliteration += 1
            }
        print(" FINAL allLablels  ", allLablels)
          
    }
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        
//        labels = identifier
//            print("labels",labels)
//
//        allLablels.append(labels)
//        print(" allLablels", allLablels)
        
        
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
