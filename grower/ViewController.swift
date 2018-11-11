//
//  ViewController.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate,
    UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var shelvesView: ShelvesView! {
        didSet {
            let kaleImage = filterBlueBackground(UIImage(named: "Kale.jpg")!)
            let bbImage = filterBlueBackground(UIImage(named: "Blueberry.jpg")!)
            
            shelvesView.kaleImage = kaleImage
            shelvesView.blueberryImage = bbImage
        }
    }
    
    @IBOutlet weak var boxView: BoxView! {
        didSet {
            let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(openCloseBox))
            upSwipe.direction = .up
            let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(openCloseBox))
            downSwipe.direction = .down
            boxView.addGestureRecognizer(upSwipe)
            boxView.addGestureRecognizer(downSwipe)
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(showLightCollection))
            singleTap.numberOfTapsRequired = 1
            boxView.addGestureRecognizer(singleTap)
            boxView.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    var lightCollectionVisible = false {
        didSet {
            lightCollectionView.isHidden = !lightCollectionVisible
        }
    }
    @IBOutlet weak var lightCollectionView: UICollectionView! {
        didSet {
            lightCollectionView.isHidden = true
            lightCollectionView.dataSource = self
            lightCollectionView.delegate = self
        }
    }
    
    var lightPictures = ["Lightbulb80.jpg", "Lightbulb130.jpg", "Lightbulb200.jpg", "Lightbulb400.jpg"]
    var lightWatts: [UInt] = [80, 130, 200, 400]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lightPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LightCell", for: indexPath)
        if let lightCell = cell as? LightCollectionViewCell {
            let lightImage = filterBlueBackground(UIImage(named: lightPictures[indexPath.item])!)
            lightCell.image.image = lightImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt: IndexPath) {
        print("selected \(didSelectItemAt.item)")
        boxView.lightChoice = didSelectItemAt.item
        lightCollectionVisible = false
    }
    
    @IBOutlet weak var monitorView: MonitorView!
    @IBOutlet weak var plantCondition: UILabel!
    @IBOutlet weak var timeOfExperiment: UILabel!
    
    @IBOutlet weak var playView: PlayView!
    
    @objc func openCloseBox(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            boxView.lidOpen = true
        case .down:
            boxView.lidOpen = false
        default:
            break
        }
    }
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self) && boxView.lidOpen
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print("Drop has happend")
        
        
        session.loadObjects(ofClass: NSString.self) { [unowned self] plants in
            if let plant = plants.first as? String{
                print("Dropped\(plant)")
                self.boxView.plantInBox = Plant(rawValue: plant)
            }
            
        }
    }
    
    @objc func showLightCollection(_ sender: UITapGestureRecognizer) {
        if boxView.lidOpen {
            let fingerLocation = sender.location(in: boxView)
            if (fingerLocation.y < boxView.bounds.size.height / 2 &&
                fingerLocation.y > 150) {
                lightCollectionVisible = !lightCollectionVisible
            }
        }
    }
    
    var playing = false {
        didSet {
            if playing {
                controlButton.setBackgroundImage(UIImage(named: "stop button.png"), for: UIControlState.normal)
            } else {
                controlButton.setBackgroundImage(UIImage(named: "play button.png"), for: UIControlState.normal)
            }
        }
    }
    @IBOutlet weak var controlButton: UIButton!
    
    @IBAction func playButton(_ sender: UIButton) {
        if (playing) {
            playing = false
        } else {
            if let plant = boxView.plantInBox {
                let lightWatt = lightWatts[boxView.lightChoice]
                if let data = growerDatabase.getExperiment(
                    plant: plant, watt: lightWatt) {
                    print("\(data)")
                    currentExperiment = data
                    currentSet = 0
                    playTimer = Timer.scheduledTimer(
                        timeInterval: 1.0, target: self, selector: #selector(showData),
                        userInfo: nil, repeats: true)
                    boxView.lidOpen = false
                    playing = true
                    timeOfExperiment.text = "Time"
                    plantCondition.text = "Result"
                }
            }
        }
        
    }
    
    @objc func showData() {
        if let timer = playTimer {
            if let experiment = currentExperiment {
                if currentSet >= experiment.measurements.count {
                    timer.invalidate()
                    playing = false
                    plantCondition.text = experiment.result.rawValue
                } else {
                    let data = experiment.measurements[currentSet]
                    timeOfExperiment.text = data.time
                    monitorView.temperature = data.temp
                    monitorView.lux = data.brightness
                    currentSet += 1
                }
            } else {
                timer.invalidate()
                playing = false
            }
        }
    }
    
    let growerDatabase = GrowerDatabase()
    var currentExperiment: Experiment?
    var currentSet = 0
    var playTimer: Timer?
}
