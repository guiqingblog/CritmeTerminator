//
//  AVMovieSessionManager.swift
//  CrimeTerminator
//
//  Created by kenny on 5/10/16.
//  Copyright © 2016 kenny. All rights reserved.
//

import UIKit
import AVFoundation
import ImageIO

class AVMovieSessionManager: NSObject,AVCaptureFileOutputRecordingDelegate {
  
    static let sharedInstance = AVMovieSessionManager()
    
    lazy var captureSession:AVCaptureSession = {
        let captureSession = AVCaptureSession()
        return captureSession

    }()
    
    lazy var movieOutput:AVCaptureMovieFileOutput = {
        let movieOutput = AVCaptureMovieFileOutput()
        return AVCaptureMovieFileOutput()
    }()
    
    lazy var selectors:[Selector] = {
        return [
            #selector(AVMovieSessionManager.stopRecording),
            #selector(AVMovieSessionManager.startRecording)
        ]
    }()
    
    
    
    //MARK: - interface
    func toggleRecording(){
        
        movieOutput.recording ? self.performSelector(selectors[0]) : self.performSelector(selectors[1])
    
    }
   
    @objc private func startRecording(){
        GUIHUDTool().showMessage("更新内容");
        movieOutput.startRecordingToOutputFileURL(movieStoreURL(), recordingDelegate: self)
    }
    
    @objc private func stopRecording(){
        GUIHUDTool().showMessage("更新完成");
        movieOutput.stopRecording()
    
    }
    
    //MARK: - private
    private func movieStoreURL()->NSURL{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,NSSearchPathDomainMask.UserDomainMask, true).last
        let pathURL = NSURL.fileURLWithPath(path!)
        let fileURL = pathURL.URLByAppendingPathComponent("movie\(NSDate()).mov")
        print(fileURL)
        return fileURL
    }
    
    private override init() {
        super.init()
        configSession()
    }
    
    private func configSession(){
        //1. back and fore camera devices
        let videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        //2. create camera input (first is back , last is fore)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevices.first as! AVCaptureDevice)
        //3. create mic device
        let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        //4. create mic input
        let audioInput = try! AVCaptureDeviceInput.init(device: audioDevice)
        
        // init session
        captureSession.beginConfiguration()
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        if captureSession.canAddInput(audioInput) {
            captureSession.addInput(audioInput)
        }
        
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        
        captureSession.commitConfiguration()
        
        

        
        
        // start session
        captureSession .startRunning()
    }
    
    //MARK: - AVCaptureFileOutputRecordingDelegate
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        print("start recording")
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        print("stop recording")
    }
 
    
    
}

