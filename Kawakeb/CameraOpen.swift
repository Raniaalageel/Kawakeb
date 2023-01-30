//
//  CameraOpen.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 03/06/1444 AH.
//


import UIKit
import AVFoundation
import Vision

class CameraOpen: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate  {

        
        var bufferSize: CGSize = .zero
        var rootLayer: CALayer! = nil
        var detectionOverlay: CALayer! = nil
        
        var requests = [VNRequest]()
        var boxesLayer: CALayer = CALayer()
        
        //var allLablels = [String]()
        
        var labels = ""
        
        //var enabled = false
      
        //var stopis = false
        
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
            
           setupAVCapture()
    //          //  setupLayers()
            setupVision()

           
        }
    
        @objc func buttonAction(sender: UIButton!) {
          print("Button tapped")
        
            Global.shared.enabled = true
            
            if session.isRunning {
        print("session.isRunning",session.isRunning)
                    DispatchQueue.global().async {
                    print("STOP Session")
                        self.session.stopRunning()
                    }
                }
          //  forArray()
        }
        func Stopsessyion(){
            print("Button tapped")
            if session.isRunning {
                print("is closed")
                   DispatchQueue.global().async {
                   print("STOP Session")
                       self.session.stopRunning()
                   }
               }
            
          
            
   
        }
        
        
        
        func setupAVCapture() {
            
           // self.view.addSubview(button)
            
         //   let session = AVCaptureSession()
            var previewLayer: AVCaptureVideoPreviewLayer! = nil
            let deviceInput: AVCaptureDeviceInput!
            
            
            
            
            let videoDataOutput = AVCaptureVideoDataOutput()
            let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
            //search for camera
            let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices.first
            
            do{
                deviceInput = try AVCaptureDeviceInput.init(device: videoDevice!)
                
              //  try AVCaptureDeviceInput(device: videoDevice!)
                print("deviceInput",deviceInput)
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
                print("adddddd")
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
            
//            if (Global.shared.stopis == true){
//            print("last try",session.isRunning )
//                    if session.isRunning {
//                           DispatchQueue.global().async {
//                           print("STOP Session")
//                               self.session.stopRunning()
//                           }                      }
           // }
          //  else if (Global.shared.stopis == false){
            session.startRunning()
             //   print("Stop camera @@@")
           // }
            
            self.view.addSubview(button)
        }
        
        func setupVision() {
            guard let model = try? VNCoreMLModel(for: MyObjectDetector2023().model) else { return }
            let request = VNCoreMLRequest(model: model) { [self] (request , err) in
                //print("request")
                if let results = request.results {
                    self.drawVisionRequestResults(results: results)
                   
                 
                    if ( Global.shared.EmptyStopArray == false ){
                        stopTheCamera()
                        print("stop the camera if the array is emty opencamera **")
                    }
                    if ( Global.shared.GoBackHomeStopCamera == false ){
                        stopTheCamera()
                        print("stop the camera if the go back to home page ^^ ")
                    }
                  //  forArray()
                    
                    print("results stop now ")
                }
            }
            self.requests = [request]
        }
        
        func setupLayers() {
            detectionOverlay = CALayer()
            detectionOverlay.bounds = CGRect(x: 0, y: 0, width: bufferSize.width, height: bufferSize.height)
            detectionOverlay.position = .init(x: rootLayer!.bounds.midX, y: rootLayer!.bounds.midY)
            rootLayer!.addSublayer(detectionOverlay)
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
            print("session.isRunning drawVisionRequestResults",session.isRunning )

       
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            
      // detectionOverlay.sublayers = nil
            print("stopis",Global.shared.stopis)
            
//            if (Global.shared.stopis == true){
//            print("last try",session.isRunning )
//                    if session.isRunning {
//                           DispatchQueue.global().async {
//                           print("STOP Session")
//                               self.session.stopRunning()
//                           }
//                       }
//            }
            
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
                
                
              //  detectionOverlay.addSublayer(shapeLayer)
                
                
            }
       
            
          // self.updateLayerGeometry()
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
          //  print("imageRequsetHandler",imageRequsetHandler)
            do {
                try imageRequsetHandler.perform(self.requests)
            } catch {
                print(error)
            }
            
       
        }
        
        func createRoundedRectWithBounds(_ bounds: CGRect) -> CALayer {
            let shapeLayer = CALayer()
            
            shapeLayer.bounds = bounds
            
        // if enabled == true {
            if Global.shared.enabled == true{
            
                print("bounds.midX, bounds.midY",bounds.midX, bounds.midY)
            var numberofx = Int(bounds.midX)
            var numberofy = Int(bounds.midY)
            
    var numberofx2 = String(describing: numberofx)
    var numberofy2 = String(describing: numberofy)
            
            labels = labels + ":" + numberofx2 + ":" + numberofy2
            
            print("labels",labels)
            
                Global.shared.allLablels.append(labels)
            print(" allLablels with append forArray ", Global.shared.allLablels)
                
            forArray()
            removeDuplicate()
                
                if session.isRunning {
                    print("!!")
                       DispatchQueue.global().async {
                       print("????bbb")
                           self.session.stopRunning()
                       }
                   }
                
            }
          
            
            shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            print("shapeLayer.position ",shapeLayer.position )
            shapeLayer.backgroundColor = .init(red: 255/255, green: 0, blue: 0, alpha: 1)
            return shapeLayer
        }
        
        func forArray(){
            var alliteration = 0
            
            while alliteration < Global.shared.allLablels.count  {
                var ch = Character(":")
     var result = Global.shared.allLablels[alliteration].split(separator: ch)
                
                var resultx = Int(result[1])!
                var resulty = Int(result[2])!
                var resullabel = String(result[0])
                
                print("resultx ",resultx)
                print("resulty ",resulty)
              print("resullabel",resullabel)

          var indexin = alliteration + 1
                while indexin < Global.shared.allLablels.count  {
                    print("indexin",indexin)
                    var result2 = Global.shared.allLablels[indexin].split(separator: ch)

                    var resultxnext = Int(result2[1])!
                    var resultynext = Int(result2[2])!
                    var resullabelnext = String(result2[0])
                    print("resultxnext",resultxnext)
                    print("resultynext ",resultynext)
                    print("resullabelnext",resullabelnext)
                    
                    
                    var temp = ""
                    var indexinpostion = alliteration + 1

                    if(Global.shared.allLablels.indices.contains(indexin)){
                        
        var resultpostion = Global.shared.allLablels[indexin].split(separator: ch)

                    var resultXnextPostion = Int(resultpostion[1])!

      

                        if(resultx > resultXnextPostion){
                        print("eneter   ???",resultx,">",resultXnextPostion)
            temp = Global.shared.allLablels[alliteration]
                            Global.shared.allLablels[alliteration] = Global.shared.allLablels[indexin]
                            Global.shared.allLablels[indexin] =  temp
                    }
        }
                    
//        if  ( resullabel.elementsEqual(resullabelnext)  ) {
//                        print("resullabel==resullabelnext",resullabel,resullabelnext)
//
//
////     if  ( resultx + 17 >= resultxnext  && resulty + 17 >= resultynext ){
//        if  ( resultx + 2 >= resultxnext ){
//                    print(" if  ( resultx <= resultxnext + 10 || resulty <= resultynext + 10 )",resultx + 25,resultxnext , resulty + 25 , resultynext)
//                        print(" remove XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
//
//         Global.shared.allLablels.remove(at: indexin)
//                        print(" allLablels after remove ", Global.shared.allLablels)
//                    }
//                    }
            
                    
                  indexin += 1
                }
                    
                
                print("alliteration",   alliteration)
            alliteration += 1
                }
            print(" FINAL allLablels after sort  ",Global.shared.allLablels)
            
//            removeDuplicate()
        }
    func removeDuplicate(){
        
        print("remove func")
        var alliteration = 0
        
        while alliteration < Global.shared.allLablels.count  {
        var ch = Character(":")
        var result = Global.shared.allLablels[alliteration].split(separator: ch)
            
            var resultx = Int(result[1])!
            var resulty = Int(result[2])!
            var resullabel = String(result[0])
            
            print("resultx ",resultx)
            print("resulty ",resulty)
            print("resullabel",resullabel)

            var indexin = alliteration + 1
            
            while indexin < Global.shared.allLablels.count  {
                print("indexin",indexin)
                var result2 = Global.shared.allLablels[indexin].split(separator: ch)

                var resultxnext = Int(result2[1])!
                var resultynext = Int(result2[2])!
                var resullabelnext = String(result2[0])
                print("resultxnext",resultxnext)
                print("resultynext ",resultynext)
                print("resullabelnext",resullabelnext)
                
                
            
            
                
        if  ( resullabel.elementsEqual(resullabelnext)  ) {
                        print("resullabel==resullabelnext",resullabel,resullabelnext)


//     if  ( resultx + 17 >= resultxnext  && resulty + 17 >= resultynext ){
        if  ( resultx + 2 >= resultxnext ){
                    print(" if  ( resultx <= resultxnext + 10 || resulty <= resultynext + 10 )",resultx + 25,resultxnext , resulty + 25 , resultynext)
                        print(" remove XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

         Global.shared.allLablels.remove(at: indexin)
                        print(" allLablels after remove ", Global.shared.allLablels)
                    }
                    }
        
                
              indexin += 1
            }
                
            
            print("alliteration",   alliteration)
        alliteration += 1
            }
        print(" ******* FINAL allLablels after sort and remove  ",Global.shared.allLablels)
        
        
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
        
    
    func stopTheCamera(){
        
        print("before if sesstion is running")
        if session.isRunning {
            print("empty stop camera")
               DispatchQueue.global().async {
               print("&&")
                   self.session.stopRunning()
               }
           }
    }
        
    }

