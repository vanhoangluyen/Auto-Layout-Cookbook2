//
//  DynamicStackViewController.swift
//  Auto Layout Cookbook2
//
//  Created by Luyen on 9/28/17.
//  Copyright © 2017 Luyen. All rights reserved.
//

import UIKit

class DynamicStackViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup scrollview
        let insets = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK : Action methods
    @IBAction func addEntry(_ sender: AnyObject) {
        let stack = stackView
        let index = (stack?.arrangedSubviews.count)! - 1
        let addView = stack?.arrangedSubviews[index]
        
        let scroll = scrollView
        let offset = CGPoint(x: (scroll?.contentOffset.x)!,
                             y: (scroll?.contentOffset.y)! + (addView?.frame.size.height)!)
        
        let newView = createEntry()
        newView.isHidden = true
        stack?.insertArrangedSubview(newView, at: index)
        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
            scroll?.contentOffset = offset
        }
        
    }
    //MAKR: -Private methods
    private func createEntry() -> UIView {
        let date = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .short , timeStyle: .none)
        let number = "\(randomHexQuad()) - \(randomHexQuad()) - \(randomHexQuad()) - \(randomHexQuad())"
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 8
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: Selector(("deleteStackView")), for: .touchUpInside)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)
        
        return stack
    }
    
    func deleteStackView(sender: UIButton) {
        if let view = sender.superview {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                view.isHidden = true
            }, completion: { (success) -> Void in
                view.removeFromSuperview()
            })
        }
    }
    
    private func randomHexQuad() -> String {
        return NSString(format: "%X%X%X%X", arc4random() % 16 ,
                        arc4random() % 16 ,
                        arc4random() % 16 ,
                        arc4random() % 16) as String
    }
}
