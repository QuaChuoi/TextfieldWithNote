# TextfieldWithNote

[![CI Status](https://img.shields.io/travis/QuaChuoi/TextfieldWithNote.svg?style=flat)](https://travis-ci.org/QuaChuoi/TextfieldWithNote)
[![Version](https://img.shields.io/cocoapods/v/TextfieldWithNote.svg?style=flat)](https://cocoapods.org/pods/TextfieldWithNote)
[![License](https://img.shields.io/cocoapods/l/TextfieldWithNote.svg?style=flat)](https://cocoapods.org/pods/TextfieldWithNote)
[![Platform](https://img.shields.io/cocoapods/p/TextfieldWithNote.svg?style=flat)](https://cocoapods.org/pods/TextfieldWithNote)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TextfieldWithNote is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TextfieldWithNote'
```
## Usage
Swift
- add an UIView, change it's custom class to InputTextField and reference to assitant.
- view's hieght constraint must be set (active)
 
```swift
    override func viewDidLoad() {
        InputTextField.initialize(UITextfieldWithNoteView: <#T##UIView#>, errorNotes: <#T##[String]?#>, validateFunc: <#T##(() -> Int)?##(() -> Int)?##() -> Int#>)
    }
```
 UITextfieldWithNoteView: Custom InputTextField's view
 errorNotes: Note contents; errorNote[0] use for blank field message
 validateFunc: Your custom validate func; return 0 if no issue; return Int value to show corresponding note content.
 
Full custom usage:
```swift
    override func viewDidLoad() {
        InputTextField.initialize(UITextfieldWithNoteView: <#T##UIView#>, fontSize: <#T##CGFloat?#>, noteTextColor: <#T##UIColor?#>, placeHolder: <#T##String#>, errorNotes: <#T##[String]?#>, isSecureTextField: <#T##Bool#>, isBlankField: <#T##Bool#>, validateFunc: <#T##(() -> Int)?##(() -> Int)?##() -> Int#>)
    }
``` 
 fontSize: custom textField's font size
 noteTextColor: note text color
 placeHolder: textfield's placeholder
 isSecureTextField: true - to enable secure text and Show/Hide button
 isBlankField: true - to allow textfield can be blank (no message)

## Author

QuaChuoi, huynhvngochien@brickmate.kr

## License

TextfieldWithNote is available under the MIT license. See the LICENSE file for more info.
