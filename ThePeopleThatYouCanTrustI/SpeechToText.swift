//
//  SpeechToText.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 4/29/24.
//

//
//  SwiftUI Speech.swift
//  Speech to Text
//
//  Created by Joel Joseph on 3/22/20.
//  Copyright © 2020 Joel Joseph. All rights reserved.
//

import Speech
import SwiftUI
import Foundation

class SwiftUISpeech: ObservableObject {
    
    @Published var isRecording:Bool = false
    @Published var button = SpeechButton()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let authStat = SFSpeechRecognizer.authorizationStatus()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    public var outputText:String = "";
    init(){
        //Requests auth from User
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                    case .authorized:
                        break

                    case .denied:
                        break
                    
                    case .restricted:
                        break
                      
                    case .notDetermined:
                        break
                      
                    default:
                        break
                }
            }
        }// end of auth request
        
        recognitionTask?.cancel()
        self.recognitionTask = nil

    }
    
    func requestMicrophone() async {
        if #available(iOS 17, *) {
            if await (AVAudioApplication.requestRecordPermission()) {
                print("access granted mic")
            } else {
                print("mic access denied")
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission() { granted in
                if(granted) {
                    print("ios 16 mic granted")
                } else {
                    print("ios 16 mic denied")
                }
            }
        }
      
    }
    
    func getButton()-> SpeechButton{ // returns the button
        return button
    }// end of get button
    
    func startRecording(){// starts the recording sequence
        
        // restarts the text
        outputText = "";
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
         //try catch to start audio session
        do{
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            print("OutputText: \(self.outputText)")
        }catch let error as NSError {
            print("ERROR:", error)
        }
        
         
        
        // Configure the microphone input and request auth
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true

        // Create a recognition task for the speech recognition session.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ result, error in
            if (result != nil){
                self.outputText = result?.bestTranscription.formattedString ?? "Try again"
                print(self.outputText)
            }
            if let result = result{
                // Update the text view with the results.
                self.outputText = result.bestTranscription.formattedString 

                print(self.outputText)
            }
            if error != nil {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                recognitionRequest.endAudio()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                print("error does not equal null\(error)")
                
            }
        }
    }// end of stop recording
//    [inputNode removeTapOnBus:0];
//              [inputNode reset];
//              [audioEngine stop];
//              [recognitionRequest endAudio];
//              [recognitionTask cancel];
//              recognitionTask = nil;
//              recognitionRequest = nil;
    
    func stopRecording(){// end recording
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.audioEngine.inputNode.reset()
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        //self.audioEngine.inputNode.removeTap(onBus: 0)
        //self.recognitionTask?.finish()
        recognitionRequest = nil
        recognitionTask = nil
        
    }// restarts the variables
    
    
    func getSpeechStatus()->String{// gets the status of authorization
        
        switch authStat{
            
            case .authorized:
                return "Authorized"
            
            case .notDetermined:
                return "Not yet Determined"
            
            case .denied:
                return "Denied - Close the App"
            
            case .restricted:
                return "Restricted - Close the App"
            
            default:
                return "ERROR: No Status Defined"
    
        }// end of switch
        
    }// end of get speech status
    
    /* Variables **/

    
    
}
