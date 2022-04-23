//
//  QuizViewController.swift
//  PsychologicalTest
//
//  Created by Hsiao-Han Chi on 2022/4/20.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var optionButton: [UIButton]! //三個選項的按鈕存成陣列，Segue依序拉到按鈕上

    
    var questionIndex = 0  //用來判定顯示第幾個問題
    var chooseOptionIndex = 0  //用來判定選第幾個選項
    var choices = [String]()  //用來儲存選擇的選項文字
    var results = [String]()  //用來儲存選項對應的結果文字
    
    var questions = [
        Question(question: "白色的長條物，可以吃的東西，以上形容你會想到以下哪個？", options: [Option(option: "香菸", result: "沈穩的你就算心裡很激動，也不會到處宣揚自己有喜歡的人了。"), Option(option: "冰棒", result: "表情、語氣、行動瞬間改變，不用說明，周圍的人也會馬上知道。"), Option(option: "麵條", result: "表面上裝作很鎮定，內心早就小鹿亂撞的偽裝派。") ]),
        Question(question: "可以提供人們幫助，會發光的圓形物品，以上形容你會想到以下哪個？", options: [Option(option: "太陽", result: "算是主動但走低調路線，直到對方注意到之前都會默默地接近。"), Option(option: "燈泡", result: "默默守護型，會一直等待對方發現你。"), Option(option: "錢幣", result: "為了愛情可以奉獻一切，為了他可以做任何事只為了獲得好感。") ]),
        Question(question: "隨手可得，但可以讓你聽到、看到你觸摸不到的東西，以上形容你會想到以下哪個？", options: [Option(option: "電話", result: "現實派，認為喜歡的對象與想像中的憧憬角色不是一樣的。"), Option(option: "電視", result: "對於愛情對象有期待，期待會一場美好的戀愛。"), Option(option: "望遠鏡", result: "內心充滿對愛情的幻想。")]),
        Question(question: "白色且柔軟，卻用手抓不住的東西，以上形容你會想到以下哪個？", options: [Option(option: "奶油慕斯", result: "幾乎無壓力，對於現狀很滿意。"), Option(option: "雲朵", result: "積累了很多壓力，對於現實有很多不滿。"), Option(option: "肥皂泡沫", result: "看起來沒什麼壓力，其實內心有一點不滿，只是還可以忍受。")])
    ]
    
    
    
    func initialUI(){

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 1, green: 145/255, blue: 167/255, alpha: 1).cgColor, UIColor(red: 1, green: 251/255, blue: 167/255, alpha: 1).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }
    
    func qna(){
        //題目文字顯示，依照 questionIndex 的值判斷是第幾題
        questionLabel.text = questions[questionIndex].question
        //選項文字顯示，依照 questionIndex 的值及按鈕順序判斷要顯示哪個選項
        optionButton[0].setTitle(questions[questionIndex].options[0].option, for: .normal)
        optionButton[1].setTitle(questions[questionIndex].options[1].option, for: .normal)
        optionButton[2].setTitle(questions[questionIndex].options[2].option, for: .normal)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI()
        qna()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func chooseOption(_ sender: UIButton) {
        
        //用switch設定每個選項點擊時chooseOptionIndex代表的值，後續用來判斷是選第幾個選項
        switch sender{
        case optionButton[0]:
            chooseOptionIndex = 0
        case optionButton[1]:
            chooseOptionIndex = 1
        case optionButton[2]:
            chooseOptionIndex = 2
            
        default:
            print("No option button")
        }
        
        //點擊按鈕後將選項文字及結果文字加入到陣列中儲存，questionIndex判斷是第幾題，chooseOptionIndex判斷是第幾個選項
        choices.append(questions[questionIndex].options[chooseOptionIndex].option)
        results.append(questions[questionIndex].options[chooseOptionIndex].result)
        
        //如果作答題數questionIndex<=2，表示只做了1～3題，因此questionIndex+1，繼續進入下一題，顯示題目及選項文字
        if questionIndex <= 2 {
            questionIndex += 1
            qna()
        //如果questionIndex = 3，表示已經做完4題，觸發顯示結果的Segue執行
        }else if questionIndex == 3{
            performSegue(withIdentifier: "showResult", sender: nil)
            
        }
    }
    
    
    @IBSegueAction func showResult(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ResultViewController? {
        
//結果頁面的choiceArray的資料由choices陣列提供，resultArray的資料由results陣列提供
            return ResultViewController(coder: coder, choiceArray: choices, resultArray: results)
        
        
        
        /*
        let controller = ResultViewController(coder: coder)
        for i in 0...3{
            controller?.choiceArray[i] = questions[i].options[choiceArray[i]].option
            controller?.resultArray[i] = questions[i].options[choiceArray[i]].result
            
        }
        return controller
         */
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
