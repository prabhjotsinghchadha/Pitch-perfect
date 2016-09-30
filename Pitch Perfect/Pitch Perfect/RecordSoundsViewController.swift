//
// RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Prabhjot  on 06/09/16.
//  Copyright © 2016 Prabhjot . All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoadCalled")
        stopButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    func helper(stop:Bool,recordB:Bool,recordingL:String) {
        stopButton.enabled=stop
        recordButton.enabled=recordB
        recordingLabel.text=recordingL
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        print("Record Button is Pressed")
        helper(true, recordB: false, recordingL: "Recording in Progress")
        stopButton.enabled=true
        recordButton.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func StopRecording(sender: AnyObject) {
        print("Stop Recording Button is Pressed")
        helper(false, recordB: true, recordingL: "Tap to record")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
     print("AVAudioRecorer did finished saving recording")
        if (flag){
        performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        }else {
            print("Saving the recording is failed")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }


}


