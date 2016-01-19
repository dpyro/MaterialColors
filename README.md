MaterialColors.swift
====================

Everything you need to use the Google Material Design Colors!

### Usage

Either add MaterialColors.swift to your project or MaterialColors.framework
to your Linked Frameworks and Library section in Xcode under your Target.
Don't forget to also do `import MaterialColors`.

To use the base Red color:

    let color: UIColor = MaterialColors.Red.primaryColor

To use the text color for Light Blue 300:

    let color: UIColor = MaterialColors.LightBlue.P300.textColor

To pick a random color:

    let materialColors: [MaterialColor] = MaterialColors.P500
    let randomIndex: Int = Int(arc4random_uniform(UInt32(materialColors.count)))
    let randomColor: UIColor = materialColors[randomIndex].color


### License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
