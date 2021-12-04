//
//  ViewController.swift
//  Tipster
//
//  Created by Safa Falaqi on 04/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var groubLabel: UILabel!
    
    @IBOutlet weak var lower: UILabel!
    @IBOutlet weak var mid: UILabel!
    @IBOutlet weak var higher: UILabel!
    
    @IBOutlet weak var lowerTipPerPerson: UILabel!
    @IBOutlet weak var midTipPerPerson: UILabel!
    @IBOutlet weak var higherTipPerPerson: UILabel!
    
    @IBOutlet weak var lowerTotal: UILabel!
    @IBOutlet weak var midTotal: UILabel!
    @IBOutlet weak var higherTotal: UILabel!
    
    @IBOutlet weak var sliderTipPercent: UISlider!
    @IBOutlet weak var sliderGroupSize: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    //when button clicked it will check the tag to decide the action
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.tag{
        case 0:  clearAmount() //c
        case 1:  numberEntered("0")//0
        case 2:  numberEntered(".")//.
        case 3:  numberEntered("1")//1
        case 4:  numberEntered("2")//2
        case 5:  numberEntered("3")//3
        case 6:  numberEntered("4")//4
        case 7:  numberEntered("5")//5
        case 8:  numberEntered("6")//6
        case 9:  numberEntered("7")//7
        case 10: numberEntered("8")//8
        default: numberEntered("9")//9
        }
    }
    
    func numberEntered(_ number:String){
        //if the initial value is zero clear it to be replaced by a the new number
        if amount.text == "0" {
            amount.text = ""
        }
        
        switch number{
        case "0","1","2","3","4","5","6","7","8","9" :  if let text = amount.text {
            amount.text = text + "\(number)"
        }
        default:
            //here we will check for "." to be entered only one time and if entered first concatenate it with 0
            if let text = amount.text{
                //if the label is empty
                if text.isEmpty
                {
                    amount.text = "0" + "."
                    //if not empty and doesnt contain "."
                } else if !text.contains(".") && !text.isEmpty{
                    amount.text = text + "."
                }
            }
        }
        //calculate the tip in each time the user enter a number
        calculateTip()
    }
    
    func clearAmount()
    {
        amount.text = "0"
        tipPerPerson(value:1)
        calculateTip()
    }
    
    func calculateTip(){
        //to display the percentage from the tip slider
        lower.text = String(format: "%.0f%%", sliderTipPercent.value*100)
        mid.text = String(format: "%.0f%%", sliderTipPercent.value*100 + 5)
        higher.text = String(format: "%.0f%%", sliderTipPercent.value*100 + 10)
        
        //to calculate the tip per person
        tipPerPerson(value:Int(sliderGroupSize.value * 100))
        
        //to display the total amount including the tip for each percentage
        if let a = amount.text , let l = lower.text ,
           let  aValue:Double = Double(a),
           let lValue:Double = Double(l.digitString) {
            lowerTotal.text =
            String(format: "%.2f",(((aValue * lValue)/100.0)+aValue))
        }
        
        if let a = amount.text , let m = mid.text ,
           let  aValue:Double = Double(a),
           let mValue:Double = Double(m.digitString) {
            midTotal.text =
            String(format: "%.2f",(((aValue * mValue)/100.0)+aValue))
        }
        
        if let a = amount.text , let h = higher.text ,
           let  aValue:Double = Double(a),
           let hValue:Double = Double(h.digitString) {
            higherTotal.text =
            String(format: "%.2f",(((aValue * hValue)/100.0)+aValue))
        }
      
    }
    //to calculate tip per person and disply it in the label
    func tipPerPerson(value:Int){
        
        if let a = amount.text , let l = lower.text ,
           let  aValue:Double = Double(a),
           let lValue:Double = Double(l.digitString) {
            lowerTipPerPerson.text =
            String(format: "%.2f",((aValue * lValue)/100.0)/Double(value))
        }
        if let a = amount.text , let m = mid.text , let  aValue = Double(a), let mValue = Double(m.digitString) {
            midTipPerPerson.text =    String(format: "%.2f",((aValue * mValue)/100.0)/Double(value))
        }
        if let a = amount.text , let h = higher.text , let  aValue = Double(a), let hValue = Double(h.digitString) {
            higherTipPerPerson.text =
            String(format: "%.2f", ((aValue * hValue)/100.0)/Double(value))
        }
        
    }
   // a function for the tip slider when moved to update the view according to the new value
    @IBAction func tipSliderChanged(_ sender: UISlider) {
        
        sliderTipPercent.minimumValue = 0
        sliderTipPercent.maximumValue = 0.20
 
        calculateTip()
    }
    
    // a function for the group size slider when moved to update the view according to the new value
    @IBAction func groupSizeSliderChanged(_ sender: UISlider) {
        
        let currentValue = Int(sender.value * 100 )
        tipPerPerson(value:currentValue)
        groubLabel.text = "Group Size: \(currentValue)"
    }
}
//an extention is used to execlude the percentage sign "%" from the digits when taking the percentage label to calculate the tip
extension String
{
    var digitString: String { filter { ("0"..."9").contains($0) } }
}

