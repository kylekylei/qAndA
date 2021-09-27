//
//  ViewController.swift
//  qAndA
//
//  Created by Kyle Lei on 2021/8/31.
//

import UIKit
//import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var containView: UIView! {
        didSet {
            containView.layer.shadowColor = UIColor.black.cgColor
            containView.layer.shadowOpacity = 0.1
            containView.layer.shadowRadius = 16
            containView.layer.shadowOffset = CGSize(width: 0, height: 8)
        }
    }
    
    @IBOutlet weak var questionView: UIView!{
        didSet {
            questionView.layer.cornerRadius = 20
            questionView.clipsToBounds = true
        }
    }
    @IBOutlet weak var answerView: UIView!{
        didSet {
            answerView.layer.cornerRadius = 20
            answerView.clipsToBounds = true
        }
    }
    
    @IBOutlet var ansswerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var numberImage: [UIImageView]!
    
    var Questions = [Question]()
    var indext = 0
    
   
    func updateUI() {
        questionLabel.text = Questions[indext].description
        ansswerLabel.text = ""
    }
    
    @objc func flipBack() {
        UIView.transition(from: answerView, to: questionView, duration: 1, options: .transitionFlipFromRight, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containView.addSubview(questionView)
        

        
        let question1 = Question(description: "哪一條街永不下雨?", answer: "芝麻街美語 (沒雨)")
        Questions.append(question1)
        let question2 = Question(description: "茉莉花.太陽花.玫瑰花,哪一朵花最沒力?", answer: "茉莉花，因為好一朵美麗（沒力）的茉莉花")
        Questions.append(question2)
        let question3 = Question(description: "氧和二氧化碳哪個比較美?", answer: "氧，因為自然（助燃）就是美")
        Questions.append(question3)
        let question4 = Question(description: "猴子最討厭什麼線？", answer: "平行線，因為沒有相交（香蕉）")
        Questions.append(question4)
        let question5 = Question(description: "象皮、老虎皮、獅子皮哪一個比較差？", answer: "因為橡皮擦（象皮差）")
        Questions.append(question5)
        let question6 = Question(description: "木魚掉進海裡會變成什麼? ", answer: "虱目魚(濕木魚)")
        Questions.append(question6)
        let question7 = Question(description: "狼、老虎和獅子誰玩遊戲一定會被淘汰?", answer: "狼，因為：桃太郎（淘汰狼）")
        Questions.append(question7)
        let question8 = Question(description: "20歲~30歲之間在第幾歲會發瘋?", answer: "24歲，因為24孝（24肖）")
        Questions.append(question8)
        let question9 = Question(description: "孔子有三位徒弟子貢.子路.和子游,請問哪一位不是人？", answer: "子路，因為指鹿為馬（子路為馬）")
        Questions.append(question9)
        let question10 = Question(description: "什麼情況下2大於5，5大於0，0大於2呢？", answer: "猜拳ㄉ時候")
        Questions.append(question10)
        
        Questions.shuffle()
        updateUI()
    }

    @IBAction func nextQuestion(_ sender: Any) {
        
        if indext < 9 {
            indext = (indext + 1) % (Questions.count)
            updateUI()
            
            for number in numberImage {
                let image = UIImage(systemName: "\(indext + 1).square.fill")
                number.image = image
            }
                    
            
            /*
            if indext < Questions.count-1{
                indext += 1
                updateUI()
            }else {
                indext = 0
                questionLable.text = Questions[indext].description
                updateUI()
            }
             */
        }else{
            let alertController = UIAlertController(title: "Good Job", message: "You finish this round of questions!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
                (action:UIAlertAction!) -> Void in
                self.indext = 0
                
                for number in self.numberImage {
                    let image = UIImage(systemName: "\(self.indext + 1).square.fill")
                    number.image = image
                }
                self.Questions.shuffle()
                self.updateUI()
                
            }))
            present(alertController, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        answerView.isHidden = false
        ansswerLabel.text = Questions[indext].answer
        
        UIView.transition(from: questionView, to: answerView, duration: 1, options: .transitionFlipFromLeft, completion: nil)
        perform(#selector(flipBack), with: nil, afterDelay: 2)
        
        /*
        let answerString = String(Questions[indext].answer)
        let answerUtterance = AVSpeechUtterance(string: answerString)
        let answerSynthesizer = AVSpeechSynthesizer()
        answerUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        answerSynthesizer.speak(answerUtterance)
         */
                
    }
}

