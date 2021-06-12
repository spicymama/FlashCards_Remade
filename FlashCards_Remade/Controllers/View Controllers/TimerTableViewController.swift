//
//  TimerTableViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/10/21.
//

import UIKit

class TimerTableViewController: UITableViewController {
static let shared = TimerTableViewController()
    @IBOutlet weak var studyTimer: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
   
    @IBAction func saveButtonTapped(_ sender: Any) {
        FlashCardViewController.futureDate = Date()
        FlashCardViewController.futureDate = FlashCardViewController.futureDate.addingTimeInterval(studyTimer.countDownDuration)
       print("button works")
       print(Date())
        print(FlashCardViewController.futureDate)
        navigationController?.popViewController(animated: true)
      
    }
}
