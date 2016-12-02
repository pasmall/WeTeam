//
//  AddWorkViewController.swift
//  WeTools
//
//  Created by lhtb on 16/11/4.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import UIKit
import Speech
import Alamofire

class AddWorkViewController: BaseViewController , UITextViewDelegate ,SFSpeechRecognizerDelegate{
    
    
    let  nameTF  = UITextField()
    let conTF = UITextView()
    let siribtn = UIButton()

    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh-CN"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "创建项目"
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .done, target: self, action: #selector(AddWorkViewController.tapNext))
        
        setUI()
        
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.siribtn.isEnabled = isButtonEnabled
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        
        let attStr = NSMutableAttributedString.init(string: "请输入项目名称")
        attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange.init(location: 0, length: attStr.length))
        attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 20), range: NSRange.init(location: 0, length: attStr.length))
        nameTF.frame = CGRect.init(x: 8, y: 64, width: SCREEN_WIDTH - 16, height: 60)
        nameTF.font = UIFont.systemFont(ofSize: 20)
        nameTF.attributedPlaceholder = attStr
        self.view.addSubview(nameTF)
        
        let line  = UIView()
        line.backgroundColor = backColor
        line.frame = CGRect.init(x: 5, y: 125, width: SCREEN_WIDTH - 10, height: 1)
        self.view.addSubview(line)
        
        
        conTF.frame = CGRect.init(x: 5, y: 126, width: SCREEN_WIDTH - 10, height: SCREEN_HEIGHT - 126)
        conTF.font = UIFont.systemFont(ofSize: 15)
        conTF.delegate = self
        conTF.text = "请输入项目介绍"
        self.view.addSubview(conTF)
        
        
        
        
        siribtn.setWidth(w: 150)
        siribtn.setHeight(h: 21)
        siribtn.setCenterX(cx: SCREEN_WIDTH * 0.5)
        siribtn.setY(y: SCREEN_HEIGHT - 64);
        siribtn.setTitle("使用语音输入", for: .normal)
        siribtn.setTitleColor(UIColor.blue, for: .normal)
        siribtn.addTarget(self, action: #selector(startRecording), for: .touchUpInside)
        self.view.addSubview(siribtn)
        
    
        
    }
    
    
    func tapNext()  {
        
        
        self.showSimpleHUD()
        Alamofire.request( IP + "creatproject.php", method: .post, parameters: ["proname":nameTF.text!,"prodes":conTF.text! , "procreator":UserInfo.sharedInstance.user_id ]).responseJSON { (data) in
            if let json = data.result.value as? [String:Any]{
                
                print(json)
                if json["code"] as! Int == 200{
                    self.hidSimpleHUD()
                    
                    _ = self.alert.showAlert("", subTitle: "创建成功", style: AlertStyle.success, buttonTitle: "返回", action: { (true) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    
                } else if json["code"] as! Int == 202{
                    
                    _ = self.alert.showAlert("创建失败")
                }
            }
            
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请输入项目介绍" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "请输入项目介绍"
        }
    }
    
    
    func updateProgress() {
        
    }
    
    func startRecording() {

        
        self.siribtn.setTitle("正在语音输入", for: .normal)
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true  //6
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                
                self.conTF.text = result?.bestTranscription.formattedString  //9
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.siribtn.isEnabled = true
                self.siribtn.setTitle("使用语音输入", for: .normal)
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        conTF.text = "说吧，我来帮你输入"
        
    }
    
    
    
    

}
