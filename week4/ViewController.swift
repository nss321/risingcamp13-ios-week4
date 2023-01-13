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
    var first: UIImage!
    var second: UIImage!
    var third: UIImage!
    var fourth: UIImage!
    var fifth: UIImage!
    var score: Int!
    var player: Int! // 0: player1, 1:player2
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tv1: UITableView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
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
    var dicetest: Array<diceFetch> = []
    
    var chance: Int = 0
    var score: Int = 0
    var turn: Int = 0
    var playerChangeFlag: Int = 0
    var endFlag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.label1.text = "0"
        self.label2.text = "0"
        self.roundLabel.text = "Round 1"
        tv1.delegate = self
        tv1.dataSource = self
        tv1.register(UINib(nibName: "pickedDIceCell", bundle: nil), forCellReuseIdentifier: "pickedDIceCell")
    }

//    override func viewDidAppear(_ animated: Bool) {
//
//    }

    @IBAction func addCell(_ sender: Any) {
        var player: Int = 0
        
        if self.turn == 0 {
            self.chance = 0
            
            if self.playerChangeFlag == 0{
                player = 0
                self.playerChangeFlag = 1
            } else {
                player = 1
                self.playerChangeFlag = 0
            }
            
            calcScore()
            var tmp: diceFetch = diceFetch(first: firstDiceCell.image!, second: secondDiceCell.image!, third: thirdDIceCell.image!,
                                           fourth: fourthDiceCell.image!, fifth: fifthDiceCell.image!, score: self.score, player: player)
            
            dicetest.append(tmp)
            appendScoreToPlayer()
            
            print(dicetest)
        
            tv1.reloadData()
            showToast("턴을 넘깁니다.", withDuration: 2, delay: 1.5)
            self.turn += 1
            self.endFlag += 1
            
        } else {
            showToast("턴 넘겨라", withDuration: 2, delay: 1.5)
        }
        
        if endFlag == 6{
            noticeWinner()
            print("\n\n\n 끝입니다 \n\n\n")
        }
    }
    
    @IBAction func reRollClicked(_ sender: Any) {
        
        if self.turn != 0 {
            self.turn = 0
        }
        
        switch self.chance{
        case 0:
            reRollDiceTest()
            self.chance += 1
            showToast("2회 남았습니다.", withDuration: 2, delay: 1.5)
        case 1:
            reRollDiceTest()
            self.chance += 1
            showToast("1회 남았습니다.", withDuration: 2, delay: 1.5)
        case 2:
            reRollDiceTest()
            self.chance += 1
            showToast("마지막입니다.", withDuration: 2, delay: 1.5)
        default:
            showToast("그만 눌러라", withDuration: 2, delay: 1.5)
        }

//        if self.chance < 3{
//            reRollDiceTest()
//            self.chance += 1
//        } else {
//            showToast("그만 눌러라", withDuration: 2, delay: 1.5)
//        }
    }
    
//    func reRollDice() {
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            for i in (0...100) {
//                DispatchQueue.main.async {
//                    self.label1.text = "라벨1 \(i)"
//                }
//                usleep(10000)
//            }
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            for i in (0...100).reversed() {
//                DispatchQueue.main.async {
//                    self.label2.text = "라벨2 \(i)"
//                }
//                usleep(10000)
//            }
//        }
//    }
    
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
    
    func appendScoreToPlayer(){
//        var scoreTotalString:String = self.label1.text!
        
        if playerChangeFlag == 1{
            var scoreTotalString:String = self.label1.text!
            self.label1.text = String(Int(scoreTotalString)!+self.score)
        } else {
            var scoreTotalString:String = self.label2.text!
            self.label2.text = String(Int(scoreTotalString)!+self.score)
            if ((self.dicetest.count/2 + 1) < 4) {
                self.roundLabel.text = "Round \(self.dicetest.count/2 + 1)"
            }
        }
    }
    
    func noticeWinner(){
        let score1 = Int(self.label1.text!)
        let score2 = Int(self.label2.text!)
        var title:String = ""
        var message:String = ""
        
        if score1! < score2!{
            title = "승자는..."
            message = "\nPlayer-2 입니다!"
        } else if(score1! > score2!){
            title = "승자는..."
            message = "\nPlayer-1 입니다!"
        } else {
            title = "무승부"
            message = "\n다시하기로 승부를 가려보세요!"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let reStart = UIAlertAction(title: "다시하기", style: .default){_ in
            self.roundLabel.text = "Round 1"
            self.dicetest.removeAll()
            self.label1.text = "0"
            self.label2.text = "0"
            self.endFlag = 0
            self.tv1.reloadData()
        }
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        alert.addAction(reStart)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
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
        
        cell.first.image = dicetest[indexPath.row].first
        cell.second.image = dicetest[indexPath.row].second
        cell.third.image = dicetest[indexPath.row].third
        cell.fourth.image = dicetest[indexPath.row].fourth
        cell.fifth.image = dicetest[indexPath.row].fifth
        
//        cell.score.text = String(scoreList[indexPath.row])
        cell.score.text = String(dicetest[indexPath.row].score)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
