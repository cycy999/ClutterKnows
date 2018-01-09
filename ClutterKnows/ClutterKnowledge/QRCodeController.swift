//
//  QRCodeController.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/9.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    //AVCaptureSession会话是用来管理视频数据流从输入设备传送到输出端的会话过程的。
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //以合适的AVCaptureDevice对象作为输入参数去实例化一个AVCaptureSession对象
        //plist文件中添加：Privacy - Camera Usage Description 或者 NSCameraUsageDescription 权限判定
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        if captureDevice == nil {
            return
        }
        do {
            let input = try AVCaptureDeviceInput.init(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
            
        } catch {
            print("error")
            return
        }
        
        config_label()
        config_qrcode()
    }
    
    func config_label() {
        messageLabel = UILabel(frame: CGRect(x: 0, y: DEVICE_HEIGHT - 80, width: DEVICE_WIDTH, height: 80))
        messageLabel.backgroundColor = UIColor.white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        view.addSubview(messageLabel)
        
    }
    
    func config_qrcode() {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubview(toFront: qrCodeFrameView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No Qr code is detected"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            if metadataObj.stringValue != nil {
                messageLabel.text = metadataObj.stringValue
            }
            
        }
    }

    //参考 http://www.cocoachina.com/swift/20150121/10962.html
    //http://blog.csdn.net/longshihua/article/details/53065902
    /*
     媒体采集的几个东西。这里所需要明白的是，在这个流程中，这里会存在几个对象：
     a、AVCaptureDevice。这里代表抽象的硬件设备。
     b、AVCaptureInput。这里代表输入设备（可以是它的子类），它配置抽象硬件设备的ports。
     c、AVCaptureOutput。它代表输出数据，管理着输出到一个movie或者图像。
     d、AVCaptureSession。它是input和output的桥梁。它协调着intput到output的数据传输
     */
}
