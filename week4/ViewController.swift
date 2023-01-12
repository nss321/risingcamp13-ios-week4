//
//  ViewController.swift
//  week4
//
//  Created by BAE on 2023/01/11.
//

import UIKit

var testList: [String] = []
var diceFetchList: Array<UIImage> = []

struct diceFetch{
    var first:UIImage!
    var second:UIImage!
    var third:UIImage!
    var fourth:UIImage!
    var fifth:UIImage!
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tv1: UITableView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    @IBOutlet weak var firstDiceCell: UIImageView!
    @IBOutlet weak var secondDiceCell: UIImageView!
    @IBOutlet weak var thirdDIceCell: UIImageView!
    @IBOutlet weak var fourthDiceCell: UIImageView!
    @IBOutlet weak var fifthDiceCell: UIImageView!

    
    
    var diceList: Array<UIImage> = [
        UIImage(named: "dice_1.png")!,
        UIImage(named: "dice_2.png")!,
        UIImage(named: "dice_3.png")!,
        UIImage(named: "dice_4.png")!,
        UIImage(named: "dice_5.png")!,
        UIImage(named: "dice_6.png")!
    ]
    
    var scoreList: Array<Int> = []
    
    
    
    var chance:Int = 0
    var score:Int = 0
    var turn:Bool = true
    
//    var tmp:diceFetch!
    
    var dicetest: Array<diceFetch> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        tv1.delegate = self
        tv1.dataSource = self
        
        tv1.register(UINib(nibName: "pickedDIceCell", bundle: nil), forCellReuseIdentifier: "pickedDIceCell")
    }

    @IBAction func addCell(_ sender: Any) {
        if self.turn {
            self.chance = 0
            testList.append("Hi")

            var tmp: diceFetch = diceFetch(first: firstDiceCell.image!, second: secondDiceCell.image!, third: thirdDIceCell.image!,
                                           fourth: fourthDiceCell.image!, fifth: fifthDiceCell.image!)
            
            dicetest.append(tmp)
            
            print(dicetest)
            calcScore()
            
            scoreList.append(self.score)
            tv1.reloadData()
            self.turn = false
        } else{
            showToast("턴 넘겨라", withDuration: 2, delay: 1.5)
            self.turn = true
        }
        
        
    }
    
    
    @IBAction func reRollClicked(_ sender: Any) {
        if self.chance < 3{
            reRollDiceTest()
            self.chance += 1
        } else {
            showToast("그만 눌러라", withDuration: 2, delay: 1.5)
        }
    }
    
    func reRollDice() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in (0...100) {
                DispatchQueue.main.async {
                    self.label1.text = "라벨1 \(i)"
                }
                usleep(10000)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for i in (0...100).reversed() {
                DispatchQueue.main.async {
                    self.label2.text = "라벨2 \(i)"
                }
                usleep(10000)
            }
        }
    }
    
    func reRollDiceTest() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0...100) {
                DispatchQueue.main.async {
//                    self.label1.text = "라벨1 \(i)"
                    self.firstDiceCell.image = self.diceList.randomElement()
                    
                }
                usleep(10000)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0...100).reversed() {
                DispatchQueue.main.async {
//                    self.label2.text = "라벨2 \(i)"
                    self.secondDiceCell.image = self.diceList.randomElement()
                }
                usleep(10000)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0...100) {
                DispatchQueue.main.async {
//                    self.label1.text = "라벨1 \(i)"
                    self.thirdDIceCell.image = self.diceList.randomElement()
                }
                usleep(10000)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0...100).reversed() {
                DispatchQueue.main.async {
//                    self.label2.text = "라벨2 \(i)"
                    self.fourthDiceCell.image = self.diceList.randomElement()

                }
                usleep(10000)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0...100) {
                DispatchQueue.main.async {
//                    self.label1.text = "라벨1 \(i)"
                    self.fifthDiceCell.image = self.diceList.randomElement()
                }
                usleep(10000)
            }
        }
    }
    
    func showToast(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
            
        self.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func calcScore(){
        self.score = 0
        
        if let firstIndex = self.diceList.firstIndex(of: self.firstDiceCell.image!) {
            switch firstIndex{
            case 0:
                self.score += 1
            case 1:
                self.score += 2
            case 2:
                self.score += 3
            case 3:
                self.score += 4
            case 4:
                self.score += 5
            case 5:
                self.score += 6
            default:
                print("default")
            }
        } else{
            print("값이다름")
        }
        
        if let secondIndex = self.diceList.firstIndex(of: self.secondDiceCell.image!) {
            switch secondIndex{
            case 0:
                self.score += 1
            case 1:
                self.score += 2
            case 2:
                self.score += 3
            case 3:
                self.score += 4
            case 4:
                self.score += 5
            case 5:
                self.score += 6
            default:
                print("default")
            }
        } else{
            print("값이다름")
        }
        
        if let thirdIndex = self.diceList.firstIndex(of: self.thirdDIceCell.image!) {
            switch thirdIndex{
            case 0:
                self.score += 1
            case 1:
                self.score += 2
            case 2:
                self.score += 3
            case 3:
                self.score += 4
            case 4:
                self.score += 5
            case 5:
                self.score += 6
            default:
                print("default")
            }
        } else{
            print("값이다름")
        }
        
        if let fourthIndex = self.diceList.firstIndex(of: self.fourthDiceCell.image!) {
            switch fourthIndex{
            case 0:
                self.score += 1
            case 1:
                self.score += 2
            case 2:
                self.score += 3
            case 3:
                self.score += 4
            case 4:
                self.score += 5
            case 5:
                self.score += 6
            default:
                print("default")
            }
        } else{
            print("값이다름")
        }
        
        if let fifthIndex = self.diceList.firstIndex(of: self.fifthDiceCell.image!) {
            switch fifthIndex{
            case 0:
                self.score += 1
            case 1:
                self.score += 2
            case 2:
                self.score += 3
            case 3:
                self.score += 4
            case 4:
                self.score += 5
            case 5:
                self.score += 6
            default:
                print("default")
            }
        } else{
            print("값이다름")
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 행의 개수
        return dicetest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell UI
        let cell = tableView.dequeueReusableCell(withIdentifier: "pickedDIceCell", for: indexPath) as! pickedDIceCell
        // indexPath.row => 행을 의미
        
//        cell.label.text = testList[indexPath.row]
//        cell.first.image = diceFetchList[0]
//        cell.second.image = diceFetchList[1]

        
        
        cell.first.image = dicetest[indexPath.row].first
        cell.second.image = dicetest[indexPath.row].second
        cell.third.image = dicetest[indexPath.row].third
        cell.fourth.image = dicetest[indexPath.row].fourth
        cell.fifth.image = dicetest[indexPath.row].fifth
        
        cell.score.text = String(scoreList[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
}
