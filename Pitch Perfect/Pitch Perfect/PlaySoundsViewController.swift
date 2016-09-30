//
// PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Prabhjot  on 12/09/16.
//  Copyright © 2016 Prabhjot . All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var rabbitButton : UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var reverlButton : UIButton!
    @IBOutlet weak var stoppButton : UIButton!
    
    
    
    @IBAction func PlaySoundForButton(sender:UIButton) {
        print("Play sound Button Pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate:0.5)
        case .Fast:
            playSound(rate:1.5)
        case .Chipmunk:
            playSound(pitch:1000)
        case .Vader:
            playSound(pitch:-1000)
        case .Reverb:
            playSound(echo:true)
        case .Echo:
            playSound(reverb:true)
            
        }
        configureUI(.Playing)
    }
    @IBAction func StopButtonPressed(sender:AnyObject){
        print("Stop Audio Button Pressed")
        stopAudio()
        
    }
    
    enum ButtonType: Int {case Slow=0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        snailButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        vaderButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        reverlButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        stoppButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
