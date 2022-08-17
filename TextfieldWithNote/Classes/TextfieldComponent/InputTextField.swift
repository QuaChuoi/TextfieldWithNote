//
//  InputTextField.swift
//  Simple
//
//  Created by Hiển Huỳnh on 20/05/2021.
//

import Foundation
import UIKit

class InputTextField: UIView {
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var field_Input: CustomTextField!
    @IBOutlet weak var viewError: UIView!
    @IBOutlet weak var lb_Error: UILabel!
    @IBOutlet weak var bt_TextSecure: UIButton!
    
    private var errorMessages: [String]?
    private var fieldStatus = false
    private var isBlankField = false
    private var callValidateField: (() -> Int)?
    private var maxContentHieght: CGFloat = 77
    private var minContentHieght: CGFloat = 44
    private var durationTime: Double = 0.4
    
    lazy var contentHeightAnchor = viewContent.heightAnchor.constraint(equalToConstant: maxContentHieght)
    
    //  init used if the view is created programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    //  init used if the view is created through IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    //  Do custom initialization here
    private func customInit() {
        Bundle.main.loadNibNamed("InputTextField", owner: self, options: nil)
        addSubview(viewContent)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewContent.frame = self.bounds
        field_Input.delegate = self
        
        setupView()
    }
    
    private func setupView() {
        field_Input.layer.borderColor = UIColor.black.cgColor
        field_Input.layer.cornerRadius = 8
        
        viewError.isHidden = true
        viewError.alpha = 0.0
        viewError.layer.borderWidth = 1.0
        viewError.layer.borderColor = UIColor.darkGray.cgColor
        viewError.layer.cornerRadius = 8.0
        
        bt_TextSecure.setTitle("Show", for: .normal)
        bt_TextSecure.setTitleColor(.black, for: .normal)
        bt_TextSecure.setTitle("Hide", for: .selected)
        bt_TextSecure.setTitleColor(.gray, for: .selected)
    }
    
    func showErrorDetail(errorIndex: Int = 0) {
        viewError.isHidden = false
        fieldStatus = false
        if errorIndex < errorMessages?.count ?? 0 {
            if let errorMess = errorMessages?[errorIndex] {
                lb_Error.text = errorMess
            } else {
                lb_Error.text = "#Unknow error"
            }
            UIView.animate(withDuration: durationTime, animations: {
                self.contentHeightAnchor.constant = self.maxContentHieght
                self.contentHeightAnchor.isActive = true
                self.viewContent.layoutIfNeeded()
                self.viewError.transform = CGAffineTransform(translationX: 0, y: 34)
                
            })
            UIView.animate(withDuration: 1.0, animations: {
                self.viewError.alpha = 1.0
            })
        }
    }
    
    func hideErrorDetail() {
        if fieldStatus == false {
        fieldStatus = true
        UIView.animate(withDuration: durationTime, animations: {
            self.viewError.transform = .identity
            self.viewError.alpha = 0.0
            
        }) { (done) -> Void in
            self.contentHeightAnchor.constant = self.minContentHieght
            self.contentHeightAnchor.isActive = true
            self.viewContent.layoutIfNeeded()
            self.viewError.isHidden = true
        }
        }
    }
    
    @IBAction func bt_ShowTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        field_Input.isSecureTextEntry = !sender.isSelected
    }
    
    private func checkTFCondition() {
        if field_Input.text?.count == 0, !isBlankField {
            showErrorDetail()
        }
        else {
            hideErrorDetail()
        }
    }
    
    func initialize(
        UITextfieldWithNoteView: UIView,
        fontSize: CGFloat? = nil,
        noteTextColor: UIColor? = nil,
        placeHolder: String = "",
        errorNotes: [String]?,
        isSecureTextField: Bool = false,
        isBlankField: Bool = false,
        validateFunc: (() -> Int)? ) {
        
            if let newFontSize = fontSize {
                field_Input.font = field_Input.font?.withSize(newFontSize)
                self.maxContentHieght = CGFloat(Float(newFontSize-16) + Float(self.maxContentHieght))
                self.minContentHieght = CGFloat(Float(newFontSize-16) + Float(self.minContentHieght))
            }
            
            self.renewHeightConstraint(heightConstraint: &(UITextfieldWithNoteView.heightConstraint)!, view: UITextfieldWithNoteView)
            
            field_Input.placeholder = placeHolder
            
            if let newNoteColor = noteTextColor {
                lb_Error.textColor = newNoteColor
            }
                        
            if let errors = errorNotes {
                self.errorMessages = errors
            } else {
                self.errorMessages = [""]
            }
            
            bt_TextSecure.isHidden = !isSecureTextField
            field_Input.isSecureTextEntry = isSecureTextField
            
            self.isBlankField = isBlankField
            
            self.callValidateField = validateFunc
    }
    
    private func renewHeightConstraint(heightConstraint: inout NSLayoutConstraint, view: UIView) {
        heightConstraint.isActive = false
        heightConstraint = view.heightAnchor.constraint(greaterThanOrEqualToConstant: minContentHieght)
        heightConstraint.isActive = true
    }
    
    func getFieldStatus() -> Bool {
        return self.fieldStatus
    }
    
}

extension InputTextField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 0 {
            checkTFCondition()
        } else {
            if let index = callValidateField?(), index > 0 {
                showErrorDetail(errorIndex: index)
            } else {
                hideErrorDetail()
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        field_Input.layer.borderWidth = 1.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        field_Input.layer.borderWidth = 0.0
    }
}
