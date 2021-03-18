A sample project about UI testing using "Page Object Model" technique.  
An article can be found on [LinkedIn](https://www.linkedin.com/pulse/turning-ui-testing-pleasure-alexander-gavrilko).  
![Build Status](https://github.com/agavrilko/UITesting-into-pleasure/workflows/Build%20%26%20Test/badge.svg)

# Overview
The main idea is to incapsulate screen logic into an object called PageObject. 
To be used with XCTest framework it was implemented as follows:
```Swift
class PageObject {

    struct Consts {
        static let defaultTimeout: TimeInterval = 1.0
    }

    let application: XCUIApplication

    required init(application: XCUIApplication) {
        self.application = application
    }

    @discardableResult
    func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        return self
    }

}
```

*PageObject* is a root class. Subclasses are supposed to override *verify* method and provide extra actions that are allowed on associated page.
```Swift
class WelcomePageObject: PageObject {

    @discardableResult
    override func verify(timeout: TimeInterval = Consts.defaultTimeout) throws -> Self {
        try [
            self.application.staticTexts.element(label: "Welcome"),
            self.application.staticTexts.element(
                label: "This is a simple questionnaire app to demonstrate the power of Page Object pattern."
            ),
            self.application.staticTexts.element(label: "Tap 'Start' to begin."),
            self.application.buttons.element(label: "Start"),
        ].throwIfDoesNotExist(timeout: timeout)
        return self
    }

    @discardableResult
    func start(timeout: TimeInterval = Consts.defaultTimeout) throws -> Question1PageObject {
        try self.application.buttons.element(label: "Start").tapOrThrow(timeout: timeout)
        return Question1PageObject(application: self.application)
    }
    
}
```
