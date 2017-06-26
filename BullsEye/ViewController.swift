//
//  ViewController.swift
//  BullsEye
//
//  Created by Gabriela on 14/06/17.
//  Copyright © 2017 Gabriela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    
    let maxPointsPerRound = 100
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var currentRound = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSlider()
        currentValue = lroundf(slider.value)
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let points = calculatePoints()
        calculateScore(points: points)
        let messageTitle = buildAlertTitle(points: points)
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { action in
                                    self.startNewRound()
                                    })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        currentValue = 0
        score = 0
        currentRound = 0
        startNewRound()
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        currentRound += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundsLabel.text = String(currentRound)
    }
    
    func calculateScore(points: Int) {
        score += points
    }
    
    func calculatePoints() -> Int {
        if (currentValue == targetValue) {
            return maxPointsPerRound * 2
        }
        return maxPointsPerRound - abs(targetValue - currentValue)
    }
    
    func buildAlertTitle(points: Int) -> String {
        let title: String
        if points == maxPointsPerRound {
            title = "Perfect!"
        } else if points > 95 {
            title = "You almost had it!"
        } else if points > 90 {
           title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        return title
    }
    
    func configureSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
}

