import UIKit
import SnapKit
import AVFoundation
import MobileCoreServices
import AWSS3
import AWSCognito
import Alamofire
import SwiftyJSON
import SwiftyGif

class SelfMadeVideoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickers:UIImagePickerController?
    
    var view14 = UIView()
    
    let view4 = UIView()
    let view5 = UIView()
    
    let view6 = UIView()
    let CameraScreenTransitionButton = UIButton()
    
    let view12 = UIView()
    
    let CloseButton = UIButton()
    
    let view7 = UIView()
    let SoundChoiceButton = UIButton()
    
    let view8 = UIView()
    
    let view9 = UIView()
    let CameraRecordButton = UIButton()
    
    let view10 = UIView()
    let view11 = UIView()
    
    var TimerView = UIView()
    var TimerLabel = UILabel()
    var seconds = 4
    var timer:Timer?
    var isTimerRunning = false
    
    let token = UserDefaults.standard.string(forKey: "loginID") ?? "" //이메일
    let token2 = UserDefaults.standard.string(forKey: "session") ?? "" //로그인 세션
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    let logoAnimationView = BackgroundAnimtionView()
    
    var noreceivedValueFromBeforeVC = "" //사운드 주소
    var no2receivedValueFromBeforeVC = "" //사운드 id
    
    var secondAsset: AVAsset?
    var audioAsset: AVAsset?
    
    var backgroundView = UIView()
    var gifImageView = UIImageView()
    
    weak var navi: UINavigationController!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        view14.backgroundColor = UIColor.clear
        view14.isUserInteractionEnabled = true
        view14.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view14)
        
        view14.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
        self.view.addSubview(view4)
        
        view4.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view.snp.left)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(view5)
        view5.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view4.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(view6)
        view6.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view5.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
        CameraScreenTransitionButton.setImage(UIImage(named: "img_btn_recoard_screenchange"), for: .normal)
        CameraScreenTransitionButton.setImage(UIImage(named: "img_btn_recoard_screenchange"), for: .selected)
        CameraScreenTransitionButton.addTarget(self, action: #selector(CameraScreenTransitionButtonPressed), for: .touchUpInside)
        view6.addSubview(CameraScreenTransitionButton)
        
        CameraScreenTransitionButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        
        self.view.addSubview(view12)
        view12.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view6.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
        let image = UIImage(named: "img_btn_ranking_close")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        CloseButton.setImage(image, for: .normal)
        CloseButton.addTarget(self, action: #selector(self.CloseButtonTapped), for: .touchUpInside)
        self.view.addSubview(CloseButton)
        
        CloseButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.trailing.equalTo(-17)
        }
        
        
        self.view.addSubview(view7)
        view7.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        let image2 = UIImage(named: "img_btn_recoard_sound")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        SoundChoiceButton.setImage(image2, for: .normal)
        SoundChoiceButton.addTarget(self, action: #selector(self.SoundChoiceButtonTapped), for: .touchUpInside)
        self.view.addSubview(SoundChoiceButton)
        
        SoundChoiceButton.snp.makeConstraints { (make) in
            make.leading.equalTo(17)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-25)
        }
        
        
        self.view.addSubview(view8)
        view8.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view7.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        self.view.addSubview(view9)
        view9.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view8.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        CameraRecordButton.setImage(UIImage(named: "img_btn_recoard_recoard"), for: .normal)
        CameraRecordButton.setImage(UIImage(named: "img_btn_recoard_recoard"), for: .selected)
        CameraRecordButton.clipsToBounds = true
        CameraRecordButton.imageView?.contentMode = .scaleAspectFit
        CameraRecordButton.addTarget(self, action: #selector(CameraRecordButtonPressed), for: .touchUpInside)
        view9.addSubview(CameraRecordButton)
        
        CameraRecordButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        
        self.view.addSubview(view10)
        view10.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view9.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        view10.addSubview(view11)
        view11.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).dividedBy(5)
            make.height.equalTo(view.snp.width).dividedBy(5)
            make.left.equalTo(view10.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        TimerView.backgroundColor = UIColor(red: 106/255, green: 106/255, blue: 106/255, alpha: 1.0)
        TimerView.isHidden = true
        TimerView.layer.cornerRadius = 45
        self.view.addSubview(TimerView)
        
        TimerView.snp.makeConstraints { (make) in
            make.width.height.equalTo(88)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
        TimerLabel.text = "3"
        TimerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        TimerLabel.textColor = UIColor.white
        TimerLabel.isHidden = true
        TimerView.addSubview(TimerLabel)
        
        TimerLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.imagePickers?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("SelfMadeVideoUploadViewController의 view가 Load됨")
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if self.seconds == 1 {
            self.TimerView.isHidden = true
            self.TimerLabel.isHidden = true
            
            self.timer?.invalidate()
            self.seconds = 4
            self.isTimerRunning = false
        }
        
        if (seconds > 1) {
            seconds -= 1
            TimerView.isHidden = true
            TimerLabel.isHidden = true
            TimerLabel.text = "\(seconds)"
        }
        
        addImagePickerToContainerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SelfMadeVideoUploadViewController의 view가 화면에 나타남")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SelfMadeVideoUploadViewController의 view가 사라지기 전")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SelfMadeVideoUploadViewController의 view가 사라짐")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("SelfMadeVideoUploadViewController의 SubView를 레이아웃 하려함")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("SelfMadeVideoUploadViewController의 SubView를 레이아웃 함")
        
        checkCameraPermissopn()
        checkMicroPermission()
        
        imagePickers?.delegate = self
        imagePickers?.sourceType = .camera
    }
    
    //상태바 숨김
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func CameraScreenTransitionButtonPressed(_ sender: UIButton) {
        if self.imagePickers?.cameraDevice == UIImagePickerController.CameraDevice.rear {
            imagePickers?.cameraDevice = .front
            
            imagePickers?.sourceType = UIImagePickerController.SourceType.camera
            imagePickers?.videoQuality = .typeHigh
            addChild(imagePickers!)
            
        } else {
            imagePickers?.cameraDevice = .rear
            
            imagePickers?.sourceType = UIImagePickerController.SourceType.camera
            imagePickers?.videoQuality = .typeHigh
            addChild(imagePickers!)
        }
    }
    
    func addImagePickerToContainerView() {
        imagePickers = UIImagePickerController()
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front) {
            imagePickers?.sourceType = UIImagePickerController.SourceType.camera
            addChild(imagePickers!)
            
            self.view14.addSubview((imagePickers?.view)!)
            imagePickers?.delegate = self
            imagePickers?.view.frame = view14.bounds
            imagePickers?.allowsEditing = true
            imagePickers?.showsCameraControls = false
            imagePickers?.cameraViewTransform = CGAffineTransform(scaleX: 1, y: 1)
            imagePickers?.cameraDevice = .rear
        }
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) {
            imagePickers?.mediaTypes = ["public.movie"]
            imagePickers?.cameraCaptureMode = .video
            imagePickers?.view.frame = view14.bounds
            imagePickers?.cameraDevice = .front
            imagePickers?.videoQuality = .typeHigh
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SelfMadeVideoUploadViewController.update)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func CameraRecordButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            TimerView.isHidden = false
            TimerLabel.isHidden = false
            runTimer()
            
            CameraRecordButton.isHidden = true
            SoundChoiceButton.isHidden = true
            CameraScreenTransitionButton.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                self.imagePickers?.startVideoCapture()
                
                self.TimerView.isHidden = false
                self.TimerLabel.isHidden = false
                
                //self.audio()
                if self.noreceivedValueFromBeforeVC.isEmpty == false {
                    self.audio()
                }
                
                self.player?.play()
                self.CameraRecordButton.isHidden = false
            })
            
        } else if sender.isSelected == false {
            sender.isSelected = false
            
            self.view.addSubview(self.logoAnimationView)
            self.logoAnimationView.pinEdgesToSuperView()
            self.logoAnimationView.logoGifImageView.delegate = self
            
            self.imagePickers?.stopVideoCapture()
            self.setUpUI()
            self.player?.pause()
            
            self.CameraScreenTransitionButton.isHidden = false
            
            self.SoundChoiceButton.isHidden = false
            
            self.CameraRecordButton.isEnabled = true
            self.CameraRecordButton.isMultipleTouchEnabled = true
            
            self.CameraRecordButton.isHidden = false
        }
    }
    
    @objc func SoundChoiceButtonTapped(_ sender: UIButton) {
        let vc = SoundListViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.transitioningDelegate = self
        
        vc.navi = self.navigationController
        vc.navi.pushViewController(vc, animated: true)
    }
    
    @objc func CloseButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "알림", message: "녹화가 취소됩니다. 계속 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .default) { action in
            
            let alert = UIAlertController(title: "알림", message: "녹화가 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
                
                func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                    self.dismiss(animated: true, completion: nil)
                }
                
                let vc = TabBarViewController()
                let nvc = CustomNavigationController(rootViewController: vc)
                nvc.modalPresentationStyle = .fullScreen
                self.hidesBottomBarWhenPushed = true
                
                if var array = self.navigationController?.viewControllers {
                    array.removeLast()
                    array.append(vc)
                    self.navigationController?.setViewControllers(array, animated: true)
                } else {
                    self.present(nvc, animated: true, completion: nil)
                }
            })
            self.present(alert, animated: true, completion: nil)
            
        })
        alert.addAction(UIAlertAction(title: "아니오", style: .default) { action in
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func audio() {
        //let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        let url = URL(string: noreceivedValueFromBeforeVC)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
    }
    
    @objc func update() {
        if (seconds > 1) {
            seconds -= 1
            TimerView.isHidden = false
            TimerLabel.isHidden = false
            TimerLabel.text = "\(seconds)"
            
        } else if (seconds == 1) {
            TimerLabel.text = "GO"
            TimerView.isHidden = true
            TimerLabel.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if token == "" {
            let alert = UIAlertController(title: "로그인이 필요한 서비스 입니다.", message: "로그인 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "예", style: .default) { (action) in

                let vc = EmailLogin3ViewController()
                let nvc = CustomNavigationController(rootViewController: vc)
                nvc.modalPresentationStyle = .fullScreen
                self.hidesBottomBarWhenPushed = true
                
                if var array = self.navigationController?.viewControllers {
                    array.removeLast()
                    array.append(vc)
                    self.navigationController?.setViewControllers(array, animated: true)
                } else {
                    self.present(nvc, animated: true, completion: nil)
                }
            }
            
            let noAction = UIAlertAction(title: "아니오", style: .default) { (action) in
                
                let alert = UIAlertController(title: "알림", message: "녹화가 취소 되었습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                    let vc = TabBarViewController()
                    let nvc = CustomNavigationController(rootViewController: vc)
                    nvc.modalPresentationStyle = .fullScreen
                    self.hidesBottomBarWhenPushed = true
                    
                    if var array = self.navigationController?.viewControllers {
                        array.removeLast()
                        array.append(vc)
                        self.navigationController?.setViewControllers(array, animated: true)
                    } else {
                        self.present(nvc, animated: true, completion: nil)
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            alert.addAction(okAction)
            alert.addAction(noAction)
            
            present(alert, animated: false, completion: nil)
            
        } else {
            
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
            if mediaType.isEqual(kUTTypeImage as String) {
                
                let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                print(captureImage)
                
            } else if mediaType.isEqual(kUTTypeMovie as String) {
                
                let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                
                let sec = AVAsset(url: videoURL)
                
                var dataVideo = Data()
                print(dataVideo)
                
                let fileData = try? Data(contentsOf: videoURL, options: .mappedIfSafe)
                dataVideo = fileData!
              
                let err: NSError? = nil
                print("err:", err as Any)
                
                let asset = AVURLAsset(url: NSURL(fileURLWithPath: videoURL.relativePath) as URL, options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                let cgImage = try? imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                
                let rotatedCGImage = cgImage?.rotate(radians: .pi/2) // .pi/2는 90도 회전을 나타냅니다.
                let rotatedCGImage2 = rotatedCGImage?.rotate(radians: .pi / 2)
                let rotatedCGImage3 = rotatedCGImage2?.rotate(radians: .pi / 2)
                
                let data3 = UIImage(cgImage: rotatedCGImage3!).pngData() as NSData?
                let imagePt = UIImage(data: (data3!) as Data)
              
                let secondAsset = sec
                let mixComposition = AVMutableComposition()
                
                guard let secondTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { return }
                
                do {
                    try secondTrack.insertTimeRange(CMTimeRangeMake(start: .zero, duration: secondAsset.duration), of: secondAsset.tracks(withMediaType: .video)[0], at: .zero)
                } catch {
                    print("Failed to load second track")
                    return
                }
                
                let mainInstruction = AVMutableVideoCompositionInstruction()
                mainInstruction.timeRange = CMTimeRangeMake(start: .zero, duration: CMTimeAdd(secondAsset.duration, secondAsset.duration))
                
                let secondInstruction = VideoHelper.videoCompositionInstruction(secondTrack, asset: secondAsset)
                mainInstruction.layerInstructions = [secondInstruction]
                
                let mainComposition = AVMutableVideoComposition()
                
                mainComposition.instructions = [mainInstruction]
                mainComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
                mainComposition.renderSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) //비디오 화면 크기

                //선택한 사운드가 있을 경우
                if self.noreceivedValueFromBeforeVC.isEmpty == false {
                    let myUrl = URL(string: noreceivedValueFromBeforeVC)!
                    audioAsset = AVAsset(url: myUrl)
                    
                    if let loadedAudioAsset = audioAsset {
                        let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: 0)
                        
                        do {
                            try audioTrack?.insertTimeRange(
                                CMTimeRangeMake(start: CMTime.zero, duration: CMTimeAdd(secondAsset.duration, secondAsset.duration)), of: loadedAudioAsset.tracks(withMediaType: .audio)[0], at: .zero)
                        } catch {
                            print("Failed to load Audio track")
                        }
                    }
                    
                    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .long
                    dateFormatter.timeStyle = .short
                    let date = dateFormatter.string(from: Date())
                    let url = documentDirectory.appendingPathComponent("mergeVideo-\(date).mov")
                    print("url:", url)
                    
                    guard let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) else { return }
                    exporter.outputURL = url
                    exporter.outputFileType = AVFileType.mov
                    exporter.shouldOptimizeForNetworkUse = true
                    exporter.videoComposition = mainComposition
                    
                    exporter.exportAsynchronously {
                        DispatchQueue.main.async {
                            
                            self.exportDidFinish(exporter)
                            
                            let fileData2 = try? Data(contentsOf: url, options: .mappedIfSafe)
                            
                            self.imagePickers?.removeFromParent()
                            self.imagePickers?.videoQuality = .typeHigh
                            
                            let vc = SelfMadeVideoPostViewController()
                            vc.modalPresentationStyle = .fullScreen
                            
                            vc.fileData = fileData2
                            vc.data3 = data3 as Data?
                            vc.noreceivedValueFromBeforeVC = self.no2receivedValueFromBeforeVC //사운드 id
                            vc.no3receivedValueFromBeforeVC = self.noreceivedValueFromBeforeVC //사운드 주소
                            
                            vc.navi = self.navigationController
                            vc.navi.pushViewController(vc, animated: true)
                        }
                    }
                    
                //선택한 사운드가 없을 경우
                } else {
                    self.imagePickers?.removeFromParent()
                    self.imagePickers?.videoQuality = .typeHigh
                    
                    let vc = SelfMadeVideoPostViewController()
                    vc.modalPresentationStyle = .fullScreen
                    
                    vc.fileData = fileData
                    vc.data3 = data3 as Data?
                    vc.noreceivedValueFromBeforeVC = self.no2receivedValueFromBeforeVC //사운드 id
                    vc.no3receivedValueFromBeforeVC = self.noreceivedValueFromBeforeVC //사운드 주소
                    
                    vc.navi = self.navigationController
                    vc.navi.pushViewController(vc, animated: true)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func exportDidFinish(_ session: AVAssetExportSession) {
        secondAsset = nil
        audioAsset = nil
    }
    
    func checkCameraPermissopn() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .notDetermined:
            print("권한 요청 전 상태")
            
            AVCaptureDevice.requestAccess(for: .video) { grated in
                if grated {
                    print("권한 허용")
                } else {
                    print("권한 거부")
                    self.showAlertGoToSetting()
                }
            }
            
        case .authorized:
            print("권한 허용 상태")
            
        case .denied:
            print("권한 거부 상태")
            self.showAlertGoToSetting()
            
        case .restricted:
            print("액세스 불가 상태")
            
        @unknown default:
            print("unknown default")
        }
    }
    
    func checkMicroPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("Mic: 권한 허용")
            } else {
                print("Mic: 권한 거부")
                self.showAlertGoToSetting2()
            }
        })
    }
    
    func showAlertGoToSetting() {
        let alert = UIAlertController(title: "카메라 권한 요청", message: "카메라 권한을 허용해야만 앱을 사용하실 수 있습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("설정페이지로 이동", comment: "Default action"), style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                })
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertGoToSetting2() {
        let alert = UIAlertController(title: "마이크 권한 요청", message: "마이크 권한을 허용해야만 앱을 사용하실 수 있습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("설정페이지로 이동", comment: "Default action"), style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                })
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SelfMadeVideoUploadViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension SelfMadeVideoUploadViewController {
    func setUpUI() {
        imagePickers = UIImagePickerController()
        imagePickers!.delegate = self
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        imagePickers!.sourceType = sourceType
        imagePickers!.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        imagePickers!.modalPresentationStyle = .fullScreen
        imagePickers!.videoQuality = .typeHigh
        present(imagePickers!, animated: true, completion: nil)
    }
}

extension SelfMadeVideoUploadViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}

extension CGImage {
    func rotate(radians: Float) -> CGImage? {
        let width = self.width
        let height = self.height

        let bytesPerRow = self.bytesPerRow
        let bitsPerComponent = self.bitsPerComponent
        let colorSpace = self.colorSpace
        let bitmapInfo = self.bitmapInfo

        let context = CGContext(data: nil, width: height, height: width, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: bitmapInfo.rawValue)

        context?.translateBy(x: CGFloat(height), y: 0)
        context?.rotate(by: CGFloat(radians))

        context?.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))

        return context?.makeImage()
    }
}
