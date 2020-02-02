//
//  MainModalViewController.swift
//  UI_presentation_1
//
//  Created by WANKI KIM on 2020/01/29.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit
import AVKit
import SoundAnalysis
import RealmSwift

class MainModalViewController: UIViewController {
    private let audioEngine = AVAudioEngine()
    private var soundClassifier = SleepSoundClassification()
    public var sleepTime: Int?
    private var toWakeUp:Date? = Date()
    private var audioPlayer: AVAudioPlayer? = nil
    
    struct SleepSoundUnit {
        var identifier: String
        var confidence: Double
        var startedSecond: Double
        var endedSecond: Double
        var date: String
        var sleepDate: String
    }
    
    var recoded:[SleepSoundUnit] = []
    var currentTime = ""
    var currentLabel = ""
    var currentStarted:Double = -1
    var inputFormat: AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    var resultsObserver = ResultsObserver()
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    let transcribedText:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont(name: "Chalkduster", size: 21)
        view.textColor = .white

        return view
    }()
    let placeholderText:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 25)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let rearightnow    Date    lm = try! Realm()
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//        var DB = SleepSoundUnitDB()
        //print(sleepTime)
        let rightnow = Date()
        
        let today = DateFormatter()
        today.dateFormat = "yyyy-MM-dd"
        currentTime = today.string(from: rightnow)
        print(sleepTime)
        resultsObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        buildUI()
    }
//
    override func viewDidAppear(_ animated: Bool) {
        startAudioEngine()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        currentStarted = -1
        do {
            let realm = try Realm()
             print(Realm.Configuration.defaultConfiguration.fileURL)
            try realm.write {
                let dataToAdd:[SleepSoundUnitDB] = self.recoded.map {
//                    let obj = SleepSoundUnitDB()
//                    obj.confidence = $0.confidence
//                    obj.identifier = $0.identifier
//                    obj.startedSecond = $0.startedSecond
//                    obj.endedSecond = $0.endedSecond
//                    return obj
                    return SleepSoundUnitDB(identifier: $0.identifier, confidence: $0.confidence, startedSecond: $0.startedSecond, endedSecond: $0.endedSecond, date: $0.date, sleepDate: $0.sleepDate)
                }
                realm.add(dataToAdd)
            }
        } catch {
            print(error)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func buildUI()
    {
        self.view.addSubview(placeholderText)
        self.view.addSubview(transcribedText)
        NSLayoutConstraint.activate(
            [transcribedText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
             transcribedText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             transcribedText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             transcribedText.heightAnchor.constraint(equalToConstant: 100),
             transcribedText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
        NSLayoutConstraint.activate(
            [placeholderText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             placeholderText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             placeholderText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             placeholderText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
    

    
    private func startAudioEngine() {
        do {
            let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
            try analyzer.add(request, withObserver: resultsObserver)
        } catch {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
        
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
            self.analysisQueue.async {
                self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
            }
        }
        do{
            try audioEngine.start()
        }catch( _){
            print("error in starting the Audio Engin")
        }
    }
}

protocol SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double, seconds:Double, date: String)
}
extension MainModalViewController: SoundClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double, seconds: Double, date: String) {
        if self.currentLabel == identifier {
            print("same")
        } else {
            if self.recoded.count == 0 && self.currentStarted == -1 {
                self.currentStarted = seconds
                self.currentLabel = identifier
            } else {
                self.recoded.append(SleepSoundUnit(identifier: self.currentLabel, confidence: confidence, startedSecond: self.currentStarted, endedSecond: seconds, date: date, sleepDate: currentTime))
                self.currentLabel = identifier
                self.currentStarted = seconds
            }
        //print(self.recoded.count)
            print(self.recoded)
            if identifier == "sleeptalking", var wake = self.toWakeUp {
                print(sleepTime!)
                wake = wake + Double(sleepTime!) - 30*60
                print(wake)
                print(wake.timeIntervalSince1970)
                print(Date().timeIntervalSince1970)
                print(Date().timeIntervalSince1970 - wake.timeIntervalSince1970)
                if wake.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                    audioEngine.inputNode.removeTap(onBus: 0)
                    self.audioEngine.stop()
                    if let path = Bundle.main.url(forResource: "SundayBeatEdited", withExtension: "wav") {
                        self.audioPlayer = try? AVAudioPlayer(contentsOf: path)
                        self.audioPlayer?.play()
                    }
                    //알림창
                    let alert = UIAlertController(title: "Alarm", message: "Click 'OK' Button", preferredStyle: UIAlertController.Style.alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    //alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)

                    //오디오 재생
                }
            }
            DispatchQueue.main.async {
                self.transcribedText.text = ("Recognition: \(identifier)")
            }
        }
    }
}

class ResultsObserver: NSObject, SNResultsObserving {
    var delegate: SoundClassifierDelegate?
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        let confidence = classification.confidence * 100.0
        let allDate = Date() // --- 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // --- 2
        let date = dateFormatter.string(from: allDate) // --- 3
        if confidence > 60 {
            delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence, seconds: result.timeRange.end.seconds, date: date)
        }
        
    }
}
