# CarSelect

- ## Description
  Basically using MVVM + RxSwift + Moya + PromiseKit to build this demo app.

  The main file is inside `CarSelect/Modules/`, `CarSelect/Service/ServerProvider` and `CarSelect/Constants/ServerAPI`, with some other files just for extension and other purposes

- ## Requirements
  - Xcode Version 13.1 (13A1030d)
  - Swift Version 5.5 (swiftlang-1300.0.31.1 clang-1300.0.29.1)

- ## Installation Instructions
  Install Xcode Version 13.1 (13A1030d) and open CarSelect.xcworkspace file with Xcode

  You can try `pod install` in case there's some pods missing

- ## Problems founded
  - Of cause the dynamic key first. Using `try decoder.singleValueContainer().decode([String: String].self)` in `Codable` to solve the problem
  - There's something there when you copy`​wa_key=coding-puzzle-client-449cc9d` from the pdf file. So it always gets 401 when you're requesting data from the server. You can find it out using atom with a little red spot there

- ## About test
  You can find it in `CarSelectTests.swift`, only added a few test cases since it's just a demo app

- ## File tree
  Check `Tree.md` file
