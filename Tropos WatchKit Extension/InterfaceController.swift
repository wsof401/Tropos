import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var phraseLabel: WKInterfaceLabel!
    @IBOutlet weak var weatherImage: WKInterfaceImage!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.

        self.dynamicType.openParentApplication(
            ["foo": "bar"], reply: { (data, error) in
                if error != nil {
                    println(error.localizedDescription)
                }
                else if let text = data["phrase"] as? String {
                    if let image = data["image"] as? String {
                        self.phraseLabel.setText(text)
                        self.weatherImage.setImageNamed(image)
                    }
                }
            }
        )
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
