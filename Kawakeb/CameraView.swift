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
    
    let captureSession = AVCaptureSession()
    
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
    
    
    
    @IBAction func startCamera(_ sender: Any) {
            //search for camera
            let avliableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
            
            do{
                if let captureDevice = avliableDevice.first{
                    let captureDiviceInput = try AVCaptureDeviceInput(device: captureDevice)
                    
                    captureSession.addInput(captureDiviceInput)
                }
            }catch{
                print(error.localizedDescription)
            }
            
            //setup output , add output to our capture session
            
            let captureOutput = AVCaptureVideoDataOutput()
            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
           
            captureSession.addOutput(captureOutput)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.frame
            //previewLayer.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
//previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
            view.layer.addSublayer(previewLayer)
            captureSession.startRunning()
            
            view.addSubview(shuterButton)
       
            view.addSubview(confidentlabel)
            view.addSubview(label)
        }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("captureOutput")
        guard let model = try? VNCoreMLModel(for: MyObjectDetectorsh().model)else{return}
      //  print("here",model)  //RoadAppObjectDetector  //MobileNetV2FP16
        //objMB_1()
        let request = VNCoreMLRequest(model: model) { (finishedRequest , err) in
           // request.imageCropAndScaleOption = .scaleFit
            guard let results = finishedRequest.results as? [VNClassificationObservation] else {     print("notdefined",err);   return}
          let detections = results as! [VNRecognizedObjectObservation]
         //   for detection in detections{
            //    print("detection")
              //  print(detection.confidence)
             //   print(detection.labels.map.identifier)
           guard let observation = results.first else {return}
         //   print("observation",observation)
            DispatchQueue.main.async {
                print("identifier is ")
                    print(observation.identifier)
                
                print("confidence is")
                    print(observation.confidence)
                self.label.text = "\(observation.identifier) JJJ"
                self.confidentlabel.text = "\(observation.confidence) MMM"
                }
        }    // print("request",request)
                guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer , options: [:]).perform([request])
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
    

}
