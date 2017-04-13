//
//  ScannerViewController.swift
//  YYSwiftDemo
//
//  Created by 余意 on 2017/3/30.
//  Copyright © 2017年 余意. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cameraView = ScanerView.init(frame: UIScreen.main.bounds)
    
    let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫一扫"
        self.view.backgroundColor = UIColor.black
        
        let barButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(selectePhotoFromPhotoLibrary(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.view.addSubview(cameraView)
        
        //初始化捕捉设备(AVMediaTypeVideo)
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input: AVCaptureDeviceInput
        
        //媒体输出流
        let output = AVCaptureMetadataOutput()
        
        do {
            //输入流
            input =  try AVCaptureDeviceInput(device:captureDevice)
            
            //输入流和输出流 添加到回话
            captureSession.addInput(input)
            captureSession.addOutput(output)
            
        } catch {
            dPrint(item: error)
        }
        
        //串行队列
        let dispatchQueue = DispatchQueue(label:"queue", attributes: [])
        
        //输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        videoPreviewLayer?.frame = cameraView.bounds
        
        //预览图层天骄到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = OCCGRect(0.2, 0.2, 0.6, 0.6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scannerStart()
        
    }
    
    func scannerStart() {
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "提示", message: metaData.stringValue, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                    self.captureSession.startRunning()
                }
                alertController.addAction(action)
                self.navigationController?.present(alertController, animated: true, completion: nil)
                
                self.captureSession.stopRunning()
            }
            
        }
    }
    
    func selectePhotoFromPhotoLibrary(_ sender: AnyObject) {
        let picture = UIImagePickerController()
        picture.sourceType = .photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        
        let result: CIQRCodeFeature = array!.first as! CIQRCodeFeature
        
        if result.messageString != nil {
            dPrint(item: result.messageString as Any)
        }
        
    }
    

}







































