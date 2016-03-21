//
//  FolioReaderFontsMenu.swift
//  FolioReaderKit
//
//  Created by Heberti Almeida on 27/08/15.
//  Copyright (c) 2015 Folio Reader. All rights reserved.
//

import UIKit

class FolioReaderFontsMenu: UIViewController, SMSegmentViewDelegate {
    
    var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clearColor()
        
        // Tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        // Menu view
        menuView = UIView(frame: CGRectMake(0, view.frame.height-170-56-56, view.frame.width, view.frame.height))
        menuView.backgroundColor = isNight(readerConfig.nightModeMenuBackground, UIColor.whiteColor())
        menuView.autoresizingMask = .FlexibleWidth
        menuView.layer.shadowColor = UIColor.blackColor().CGColor
        menuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        menuView.layer.shadowOpacity = 0.3
        menuView.layer.shadowRadius = 6
        menuView.layer.shadowPath = UIBezierPath(rect: menuView.bounds).CGPath
        menuView.layer.rasterizationScale = UIScreen.mainScreen().scale
        menuView.layer.shouldRasterize = true
        view.addSubview(menuView)
        
        let normalColor = UIColor(white: 0.5, alpha: 0.7)
        let selectedColor = readerConfig.tintColor
        let sun = UIImage(readerImageNamed: "icon-sun")
        let moon = UIImage(readerImageNamed: "icon-moon")
        let fontSmall = UIImage(readerImageNamed: "icon-font-small")
        let fontBig = UIImage(readerImageNamed: "icon-font-big")
        let lineHeightSmall = UIImage(readerImageNamed: "icon-lineHeight-small")
        let lineHeightBig = UIImage(readerImageNamed: "icon-lineHeight-big")
        
        let sunNormal = sun!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        let moonNormal = moon!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        let fontSmallNormal = fontSmall!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        let fontBigNormal = fontBig!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        let lineHeightSmallNormal = lineHeightSmall!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        let lineHeightBigNormal = lineHeightBig!.imageTintColor(normalColor).imageWithRenderingMode(.AlwaysOriginal)
        
        let sunSelected = sun!.imageTintColor(selectedColor).imageWithRenderingMode(.AlwaysOriginal)
        let moonSelected = moon!.imageTintColor(selectedColor).imageWithRenderingMode(.AlwaysOriginal)
        
        // Day night mode
        let dayNight = SMSegmentView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 55),
            separatorColour: readerConfig.nightModeSeparatorColor,
            separatorWidth: 1,
            segmentProperties:  [
                keySegmentTitleFont: UIFont(name: "Avenir-Light", size: 17)!,
                keySegmentOnSelectionColour: UIColor.clearColor(),
                keySegmentOffSelectionColour: UIColor.clearColor(),
                keySegmentOnSelectionTextColour: selectedColor,
                keySegmentOffSelectionTextColour: normalColor,
                keyContentVerticalMargin: 17
            ])
        dayNight.delegate = self
        dayNight.tag = 1
        dayNight.addSegmentWithTitle(readerConfig.localizedFontMenuDay, onSelectionImage: sunSelected, offSelectionImage: sunNormal)
        dayNight.addSegmentWithTitle(readerConfig.localizedFontMenuNight, onSelectionImage: moonSelected, offSelectionImage: moonNormal)
        dayNight.selectSegmentAtIndex(Int(FolioReader.sharedInstance.nightMode))
        menuView.addSubview(dayNight)
        
        
        // Separator
        let line = UIView(frame: CGRectMake(0, dayNight.frame.height+dayNight.frame.origin.y, view.frame.width, 1))
        line.backgroundColor = readerConfig.nightModeSeparatorColor
        menuView.addSubview(line)

        // Fonts adjust
        let fontName = SMSegmentView(frame: CGRect(x: 15, y: line.frame.height+line.frame.origin.y, width: view.frame.width-30, height: 55),
            separatorColour: UIColor.clearColor(),
            separatorWidth: 0,
            segmentProperties:  [
                keySegmentOnSelectionColour: UIColor.clearColor(),
                keySegmentOffSelectionColour: UIColor.clearColor(),
                keySegmentOnSelectionTextColour: selectedColor,
                keySegmentOffSelectionTextColour: normalColor,
                keyContentVerticalMargin: 17
            ])
        fontName.delegate = self
        fontName.tag = 2
        fontName.addSegmentWithTitle("Andada", onSelectionImage: nil, offSelectionImage: nil)
        fontName.addSegmentWithTitle("Lato", onSelectionImage: nil, offSelectionImage: nil)
        fontName.addSegmentWithTitle("Lora", onSelectionImage: nil, offSelectionImage: nil)
        fontName.addSegmentWithTitle("Raleway", onSelectionImage: nil, offSelectionImage: nil)
        fontName.segments[0].titleFont = UIFont(name: "Andada-Regular", size: 18)!
        fontName.segments[1].titleFont = UIFont(name: "Lato-Regular", size: 18)!
        fontName.segments[2].titleFont = UIFont(name: "Lora-Regular", size: 18)!
        fontName.segments[3].titleFont = UIFont(name: "Raleway-Regular", size: 18)!
        fontName.selectSegmentAtIndex(FolioReader.sharedInstance.currentFontName)
        menuView.addSubview(fontName)
        
        // Separator 2
        let line2 = UIView(frame: CGRectMake(0, fontName.frame.height+fontName.frame.origin.y, view.frame.width, 1))
        line2.backgroundColor = readerConfig.nightModeSeparatorColor
        menuView.addSubview(line2)
        
        // Font slider size
        let fontSlider = HADiscreteSlider(frame: CGRect(x: 60, y: line2.frame.origin.y+2, width: view.frame.width-120, height: 55))
        fontSlider.tickStyle = ComponentStyle.Rounded
        fontSlider.tickCount = 5
        fontSlider.tickSize = CGSize(width: 8, height: 8)
        
        fontSlider.thumbStyle = ComponentStyle.Rounded
        fontSlider.thumbSize = CGSize(width: 28, height: 28)
        fontSlider.thumbShadowOffset = CGSize(width: 0, height: 2)
        fontSlider.thumbShadowRadius = 3
        fontSlider.thumbColor = selectedColor
        
        fontSlider.backgroundColor = UIColor.clearColor()
        fontSlider.tintColor = readerConfig.nightModeSeparatorColor
        fontSlider.minimumValue = 0
        fontSlider.value = CGFloat(FolioReader.sharedInstance.currentFontSize)
        fontSlider.addTarget(self, action: "fontSliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Force remove fill color
        for layer in fontSlider.layer.sublayers! {
            layer.backgroundColor = UIColor.clearColor().CGColor
        }
        
        menuView.addSubview(fontSlider)
        
        // Font icons
        let fontSmallView = UIImageView(frame: CGRect(x: 20, y: line2.frame.origin.y+14, width: 30, height: 30))
        fontSmallView.image = fontSmallNormal
        fontSmallView.contentMode = UIViewContentMode.Center
        menuView.addSubview(fontSmallView)
        
        let fontBigView = UIImageView(frame: CGRect(x: view.frame.width-50, y: line2.frame.origin.y+14, width: 30, height: 30))
        fontBigView.image = fontBigNormal
        fontBigView.contentMode = UIViewContentMode.Center
        menuView.addSubview(fontBigView)
        
        // Separator 3
        let line3 = UIView(frame: CGRectMake(0, line2.frame.origin.y+56, view.frame.width, 1))
        line3.backgroundColor = readerConfig.nightModeSeparatorColor
        menuView.addSubview(line3)
        
        // LineHeight slider size
        let lineSlider = HADiscreteSlider(frame: CGRect(x: 60, y: line3.frame.origin.y+2, width: view.frame.width-120, height: 55))
        lineSlider.tickStyle = ComponentStyle.Rounded
        lineSlider.tickCount = 5
        lineSlider.tickSize = CGSize(width: 8, height: 8)
        
        lineSlider.thumbStyle = ComponentStyle.Rounded
        lineSlider.thumbSize = CGSize(width: 28, height: 28)
        lineSlider.thumbShadowOffset = CGSize(width: 0, height: 2)
        lineSlider.thumbShadowRadius = 3
        lineSlider.thumbColor = selectedColor
        
        lineSlider.backgroundColor = UIColor.clearColor()
        lineSlider.tintColor = readerConfig.nightModeSeparatorColor
        lineSlider.minimumValue = 0
        lineSlider.value = CGFloat(FolioReader.sharedInstance.currentLineHeight)
        lineSlider.addTarget(self, action: "lineHeightSliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Force remove fill color
        for layer in lineSlider.layer.sublayers! {
            layer.backgroundColor = UIColor.clearColor().CGColor
        }
        
        menuView.addSubview(lineSlider)
        
        // LineHeight icons
        let lineHeightSmallView = UIImageView(frame: CGRect(x: 20, y: line3.frame.origin.y+14, width: 30, height: 30))
        lineHeightSmallView.image = lineHeightSmallNormal
        lineHeightSmallView.contentMode = UIViewContentMode.Center
        menuView.addSubview(lineHeightSmallView)
        
        let lineHeightBigView = UIImageView(frame: CGRect(x: view.frame.width-50, y: line3.frame.origin.y+14, width: 30, height: 30))
        lineHeightBigView.image = lineHeightBigNormal
        lineHeightBigView.contentMode = UIViewContentMode.Center
        menuView.addSubview(lineHeightBigView)
        
        // Separator 4
        let line4 = UIView(frame: CGRectMake(0, line3.frame.origin.y+56, view.frame.width, 1))
        line4.backgroundColor = readerConfig.nightModeSeparatorColor
        menuView.addSubview(line4)
        
        // Browse mode
        let browseMode = SMSegmentView(frame: CGRect(x: 15, y: line4.frame.height+line4.frame.origin.y, width: view.frame.width-30, height: 55),
            separatorColour: UIColor.clearColor(),
            separatorWidth: 0,
            segmentProperties:  [
                keySegmentOnSelectionColour: UIColor.clearColor(),
                keySegmentOffSelectionColour: UIColor.clearColor(),
                keySegmentOnSelectionTextColour: selectedColor,
                keySegmentOffSelectionTextColour: normalColor,
                keyContentVerticalMargin: 17
            ])
        browseMode.delegate = self
        browseMode.tag = 3
        browseMode.addSegmentWithTitle("Slide", onSelectionImage: nil, offSelectionImage: nil)
        browseMode.addSegmentWithTitle("Scroll", onSelectionImage: nil, offSelectionImage: nil)
        browseMode.addSegmentWithTitle("Book", onSelectionImage: nil, offSelectionImage: nil)
        browseMode.addSegmentWithTitle("Simple", onSelectionImage: nil, offSelectionImage: nil)
        browseMode.segments[0].titleFont = UIFont(name: "Avenir-Light", size: 18)!
        browseMode.segments[1].titleFont = UIFont(name: "Avenir-Light", size: 18)!
        browseMode.segments[2].titleFont = UIFont(name: "Avenir-Light", size: 18)!
        browseMode.segments[3].titleFont = UIFont(name: "Avenir-Light", size: 18)!
        browseMode.selectSegmentAtIndex(FolioReader.sharedInstance.currentBrowseMode)
        menuView.addSubview(browseMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return readerConfig.shouldHideNavigationOnTap == true
    }
    
    // MARK: - SMSegmentView delegate
    
    func segmentView(segmentView: SMSegmentView, didSelectSegmentAtIndex index: Int) {
        let currentPage = FolioReader.sharedInstance.readerCenter.currentPage
        
        if segmentView.tag == 1 {

            FolioReader.sharedInstance.nightMode = Bool(index)
            
            let readerCenter = FolioReader.sharedInstance.readerCenter
            let readerSidePanel = FolioReader.sharedInstance.readerSidePanel
            
            switch index {
            case 0:
                currentPage.webView.js("nightMode(false)")
                UIView.animateWithDuration(0.6, animations: {
                    self.menuView.backgroundColor = UIColor.whiteColor()
                    readerCenter.collectionView.backgroundColor = UIColor.whiteColor()
                    readerCenter.configureNavBar()
                    readerCenter.scrollScrubber.updateColors()
                })
                readerSidePanel.tableView.backgroundColor = readerConfig.menuBackgroundColor
                readerSidePanel.tableView.separatorColor = readerConfig.menuSeparatorColor
                break
            case 1:
                currentPage.webView.js("nightMode(true)")
                UIView.animateWithDuration(0.6, animations: {
                    self.menuView.backgroundColor = readerConfig.nightModeMenuBackground
                    readerCenter.collectionView.backgroundColor = readerConfig.nightModeBackground
                    readerCenter.configureNavBar()
                    readerCenter.scrollScrubber.updateColors()
                })
                readerSidePanel.tableView.backgroundColor = readerConfig.nightModeMenuBackground
                readerSidePanel.tableView.separatorColor = readerConfig.nightModeSeparatorColor
                break
            default:
                break
            }
            
        }
        
        if segmentView.tag == 2 {
            switch index {
            case 0:
                currentPage.webView.js("setFontName('andada')")
                break
            case 1:
                currentPage.webView.js("setFontName('lato')")
                break
            case 2:
                currentPage.webView.js("setFontName('lora')")
                break
            case 3:
                currentPage.webView.js("setFontName('raleway')")
                break
            default:
                break
            }
            
            FolioReader.sharedInstance.currentFontName = index
        }
        
        if segmentView.tag == 3 {
        
            
        //htmlを(left pages毎に)切って 用意しておく?
        //collectionviewの各cellに詰める?
        //→おそらく、FolioReaderPageを横向きにするだけでできる
           //FolioReaderPageのwebview.scrollviewを横長に1枚、かつ横スクロールを設定
           //collectionviewも横向きに設定
           //ジェスチャーを3つの位置に分ける(全体の恒常設定にする)
            
            
            
            
            
            
          //slide
            //切ってあるhtmlを 左から順に横に並べる
            //scrollviewを横向きにしてページングをオンにする
            
            //もしくは、collectionviewを横向きでページングさせる
            
            
        
          //Scroll
            //他モードと切り替えできるようにする
            
        
          //book
            //ライブラリ使用
            //各ページ uiviewを設定?
            //ライブラリを書き換え？
            
            
            
            
          //simple
            //タップ位置に応じて pagesを切り替える(切ってあるhtmlから選択し、viewに表示)
            //左タップ 1つ前のpages を表示
            //右タップ 1つ次のpages を表示
            //真ん中タップ ナビゲーションバーを表示
            
            
            
            
            
            switch index {
            case 0:
                currentPage.webView.js("setBrowseMode('slide')")
                break
            case 1:
                currentPage.webView.js("setBrowseMode('scroll')")
                break
            case 2:
                currentPage.webView.js("setBrowseMode('book')")
                break
            case 3:
                currentPage.webView.js("setBrowseMode('simple')")
                break
            default:
                break
            }
            
            FolioReader.sharedInstance.currentBrowseMode = index
        }
    }
    
    // MARK: - Font slider changed
    
    func fontSliderValueChanged(sender: HADiscreteSlider) {
        let currentPage = FolioReader.sharedInstance.readerCenter.currentPage
        let index = Int(sender.value)
        
        switch index {
        case 0:
            currentPage.webView.js("setFontSize('textSizeOne')")
            break
        case 1:
            currentPage.webView.js("setFontSize('textSizeTwo')")
            break
        case 2:
            currentPage.webView.js("setFontSize('textSizeThree')")
            break
        case 3:
            currentPage.webView.js("setFontSize('textSizeFour')")
            break
        case 4:
            currentPage.webView.js("setFontSize('textSizeFive')")
            break
        default:
            break
        }
        
        FolioReader.sharedInstance.currentFontSize = index
    }
    
    // MARK: - LineHeight slider changed
    
    func lineHeightSliderValueChanged(sender: HADiscreteSlider) {
        let currentPage = FolioReader.sharedInstance.readerCenter.currentPage
        let index = Int(sender.value)
        
        switch index {
        case 0:
            currentPage.webView.js("setLineHeight('lineHeightOne')")
            break
        case 1:
            currentPage.webView.js("setLineHeight('lineHeightTwo')")
            break
        case 2:
            currentPage.webView.js("setLineHeight('lineHeightThree')")
            break
        case 3:
            currentPage.webView.js("setLineHeight('lineHeightFour')")
            break
        case 4:
            currentPage.webView.js("setLineHeight('lineHeightFive')")
            break
        default:
            break
        }
        
        FolioReader.sharedInstance.currentLineHeight = index
    }
    
    // MARK: - Gestures
    
    func tapGesture() {
        dismissViewControllerAnimated(true, completion: nil)
        
        if readerConfig.shouldHideNavigationOnTap == false {
            FolioReader.sharedInstance.readerCenter.showBars()
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer && touch.view == view {
            return true
        }
        return false
    }
}
