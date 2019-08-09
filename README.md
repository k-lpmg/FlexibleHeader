# FlexibleHeader
[![Build Status](https://travis-ci.org/k-lpmg/FlexibleHeader.svg?branch=master)](https://travis-ci.org/k-lpmg/FlexibleHeader)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Cocoapods](https://img.shields.io/cocoapods/v/FlexibleHeader.svg?style=flat)](https://cocoapods.org/pods/FlexibleHeader)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/k-lpmg/FlexibleHeader/blob/master/LICENSE)

A Container view that responds to scrolling of the UIScrollView.

normal | threshold
--- | :---:
<img src="https://user-images.githubusercontent.com/15151687/62814253-a4e5ac00-bb4a-11e9-8539-4eaf65bb3d9a.gif" width="276" height="600"> | <img src="https://user-images.githubusercontent.com/15151687/62814260-b16a0480-bb4a-11e9-89cf-8715210edaa7.gif" width="276" height="600">

- [FlexibleHeaderExecutantType](#FlexibleHeaderExecutantType)
- [Getting Started](#getting-started)
- [Progressive](#Progressive) 
- [Installation](#Installation)


## FlexibleHeaderExecutantType
The enum used in the FlexibleHeader class to determine the header type.
``` swift
public enum FlexibleHeaderExecutantType {
case normal
case threshold
case customThreshold(hiddenThreshold: CGFloat, showThreshold: CGFloat)
}
```

### 1. normal
- Header appears when offset Y of scroll is 0. In other cases, the Header is disappeared.
### 2. threshold
- Unlike the normal type, the header can be appeared or disappeared in the middle of the scroll by the threshold.
### 3. customThreshold
- You can set hidden threshold and show threshold to threshold type. The unit of threshold is the offset of UIScrollView.


## Getting Started

### FlexibleHeaderScrollView
The container view that contains the UIScrollView and the FlexibleHeader is the easiest way to implement a FlexibleHeader.

1. Create an instance of FlexibleHeaderScrollView.
``` swift
let flexibleHeaderScrollView = FlexibleHeaderScrollView(headerMaxHeight: 64, headerMinHeight: 0, headerExecutantType: .threshold)
flexibleHeaderScrollView.translatesAutoresizingMaskIntoConstraints = false
```

2. Add subviews to the contentView in FlexibleHeaderScrollView.
``` swift
let topView = UIView()
topView.translatesAutoresizingMaskIntoConstraints = false

let bottomView = UIView()
bottomView.translatesAutoresizingMaskIntoConstraints = false

topView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
topView.topAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.topAnchor).isActive = true
topView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
topView.heightAnchor.constraint(equalToConstant: 550).isActive = true

bottomView.leadingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.leadingAnchor).isActive = true
bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
bottomView.trailingAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.trailingAnchor).isActive = true
bottomView.heightAnchor.constraint(equalToConstant: 550).isActive = true
bottomView.bottomAnchor.constraint(equalTo: flexibleHeaderScrollView.contentView.bottomAnchor).isActive = true
```

### FlexibleHeader
If you want to implement the FlexibleHeader functionality in your UIScrollView,  use the FlexibleHeader class.

1. Create an instance of UIScrollView.
``` swift
let scrollView = UIScrollView()
scrollView.translatesAutoresizingMaskIntoConstraints = false
```

2. Create an instance of FlexibleHeader using an instance of UIScrollView.
``` swift
let flexibleHeader = FlexibleHeader(scrollView: scrollView, maxHeight: 64, minHeight: 0, executantType: .threshold)
flexibleHeader.translatesAutoresizingMaskIntoConstraints = false
```

3. Configure a height NSLayoutConstraint of an instance of FlexibleHeader.
``` swift
let flexibleHeaderHeight = flexibleHeader.heightAnchor.constraint(equalToConstant: 50)
flexibleHeaderHeight.isActive = true

flexibleHeader.configure(heightConstraint: flexibleHeaderHeight)
```


## Progressive
You can change the value(view properties, constant of NSLayoutConstraint) based on the start and end points as the scroll progress.

### ProgressiveViewAttribute
<img src="https://user-images.githubusercontent.com/15151687/62814282-d494b400-bb4a-11e9-91d3-ebbef5ce6e72.gif" width="276" height="600">

``` swift
let flexibleHeader = FlexibleHeader(scrollView: scrollView, maxHeight: 128, minHeight: 0, executantType: .threshold)

let initialAttribute = ProgressiveViewAttribute(view: flexibleHeader, progress: 0.0, alpha: 1.0)
let finalAttribute = ProgressiveViewAttribute(view: flexibleHeader, progress: 1.0, alpha: 0.0)
flexibleHeader.appendProgressiveViewAttribute(with: initialAttribute)
flexibleHeader.appendProgressiveViewAttribute(with: finalAttribute)
```

### ProgressiveLayoutConstraintConstant
<img src="https://user-images.githubusercontent.com/15151687/62814284-d65e7780-bb4a-11e9-975a-66d730c25a24.gif" width="276" height="600">

``` swift
let headerContentView = UIView()
headerContentView.translatesAutoresizingMaskIntoConstraints = false
headerContentView.backgroundColor = .yellow

flexibleHeader.addSubview(headerContentView)

headerContentView.centerXAnchor.constraint(equalTo: flexibleHeader.centerXAnchor).isActive = true
headerContentView.centerYAnchor.constraint(equalTo: flexibleHeader.centerYAnchor).isActive = true
headerContentView.heightAnchor.constraint(equalToConstant: 64).isActive = true
```
``` swift
let headerContentViewWidth = headerContentView.widthAnchor.constraint(equalToConstant: 0)
headerContentViewWidth.isActive = true

let initialConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 0.0, constant: 320)
let finalConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 1.0, constant: 0)
flexibleHeader.appendProgressiveConstraintConstant(with: initialConstraintConstant)
flexibleHeader.appendProgressiveConstraintConstant(with: finalConstraintConstant)
```


## Installation

#### CocoaPods (iOS 9+)

```ruby
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FlexibleHeader'
end
```

#### Carthage (iOS 9+)

```ruby
github "k-lpmg/FlexibleHeader"
```


## LICENSE

These works are available under the MIT license. See the [LICENSE][license] file
for more info.

[license]: LICENSE
