//
//  BreakTimerViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/11/21.
//

import UIKit

class BreakTimerViewController: UIViewController {
    static let shared = BreakTimerViewController()
    @IBOutlet weak var breakTimer: UIDatePicker!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.layer.masksToBounds = true
        timerLabel.layer.cornerRadius = 15
        saveButton.addCornerRadius()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        PostFeedViewController.breakDate = Date()
        PostFeedViewController.breakDate =  PostFeedViewController.breakDate.addingTimeInterval(breakTimer.countDownDuration)
        
       /* print("button works")
        print( PostFeedViewController.currentDate)
        print( PostFeedViewController.breakDate)
        */
    }
}



//1- Bucket, 2- Food, 3- Gym, 4- Car Parts, 5-CEO
