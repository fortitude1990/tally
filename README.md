# 熊猫记账

## 简介
一款记账类APP，参考了鲨鱼记账、支付宝、网易有钱等APP，其中包含了网易有钱下拉退出动画、鲨鱼记账上拉切换月份列表动画等。
## 语言
[Swift](http://www.swift51.com/swift4.0/)
## 第三方框架
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [SQLite.swift](https://github.com/stephencelis/SQLite.swift)
![add image](https://github.com/fortitude1990/tally/blob/master/images/2.0/WechatIMG4.jpeg)

## 截图
<div>
  <img style="float:left margin:20" 
       src = "https://github.com/fortitude1990/tally/blob/master/images/2.0/WechatIMG4.jpeg" 
       width = "25%" 
       alt = "账单列表"/>
    <img style="float:left margin:20" 
       src = "https://github.com/fortitude1990/tally/blob/master/images/2.0/WechatIMG5.jpeg" 
       width = "25%" 
       alt = "详情"/>
    <img style="float:left margin:20" 
       src = "https://github.com/fortitude1990/tally/blob/master/images/2.0/WechatIMG6.jpeg" 
       width = "25%" 
       alt = "添加"/>
</div>

## 动效

<div>
  <img style="float:left margin:20" 
       src = "https://github.com/fortitude1990/tally/blob/master/images/tally%E5%8A%A8%E7%94%BB.gif" 
       width = "25%" 
       alt = "账单列表"/>
</div>

## 开发中遇到的问题
### 1、如何让UICollectionView横向翻页滑动
自定义UICollectionViewFlowLayout

1）定义一个数组，存放UICollectionViewLayoutAttributes
```
var attArray: NSMutableArray = NSMutableArray.init()
```
2）重写prepare()
```
 override func prepare() {
        
       super.prepare()
        
        self.attArray.removeAllObjects()
        //定义当前行数、页数变量
        var lineNum: NSInteger = 1;
        var page: NSInteger = 0;
        //定义itemsize
        
        let originX: CGFloat = self.collectionView?.frame.width ?? 0
        let attWidth: CGFloat =  (self.collectionView?.frame.width ?? 0 - 22) / 5

        let attHeight: CGFloat = self.itemSize.height;

        let items: NSInteger = self.collectionView?.numberOfItems(inSection: 0) ?? 0

        for i in 0...(items - 1) {
            
            let index: NSIndexPath = NSIndexPath.init(row: i, section: 0)
            let att: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: index as IndexPath)
            
            //因为我是一行显示5个，所以取计算5的余数，如果==0就换行，一来i = 0，所以lineNum初始值为0，从第一行开始添加
            if (i % 5 == 0) {
                lineNum = lineNum == 0 ? 1 : 0;
            }
            //超过10个就加一页，让x坐标加上页数 * collectionview宽度
            if ((NSInteger)(i / 10) >= 0) {
                page = i / 10;
            }
            //计算frame
            att.frame = CGRect.init(x: CGFloat.init((i % 5))  * attWidth + (originX * CGFloat.init(page)), y: CGFloat.init(lineNum) * (attHeight + self.minimumLineSpacing) + self.sectionInset.top, width: attWidth, height: attHeight)
            
            self.attArray.add(att)
            
            
        }
        
    }
```
3）设置contentSize
```
    override var collectionViewContentSize: CGSize{

        let items: NSInteger = self.collectionView?.numberOfItems(inSection: 0) ?? 0

        var pages: NSInteger?
        if items % 10 == 0 {
            pages = items / 10;
        }else{
            pages = items / 10 + 1
        }

        return CGSize.init(width: (self.collectionView?.frame.width ?? 0 ) * CGFloat.init(pages ?? 0), height:0)

    }
```
4）重写layoutAttributesForElements(in rect: CGRect)
```
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array: NSMutableArray = NSMutableArray.init()
        for att:UICollectionViewLayoutAttributes in self.attArray as! [UICollectionViewLayoutAttributes]{
            if rect.intersects(att.frame){
                array.add(att)
            }
        }
        
        return array as? [UICollectionViewLayoutAttributes]
    }
```
### 2、手指在UICollectionView上，self.view页面可以进行流畅的竖向滑动

实现下滑退出功能，是在touchesMoved里获取手指滑动的竖向距离，来改变self.view的frame，然后判断frame.maxY是否大于临界值，大于临界值就退出，小于临界值就恢复原样。在self.view上添加了UICollectionView，手指放在UICollectionView，touchesMoved函数无响应，所以就出现了手指在UICollectionView上无法竖向滑动的问题

1）为了解决这个问题，首先想到了让UICollectionView的touchesMoved传递到self.view层，让self.view层的touchesMoved有响应
```
extension UICollectionView{
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        self.next?.next?.next?.touchesMoved(touches, with: event)
    }
    
}
```
这样做发现有一个问题，当手指头滑出了UICollectionView， UICollectionView的touchesMoved就不再响应，self.view层的touchesMoved也不响应，滑动效果就会丧失，体验效果不好，所以这个方案不行

2）为了解决第一种方案的问题，就在第一种上面进行了优化。当手指滑出了UICollectionView，就让self.view直接响应
```
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if point.y > self.frame.height || point.y < 0{
            return self.next?.next?.next as? UIView
        }
        return super.hitTest(point, with: event)
    }
```
这种方法虽然解决了第一种方案问题，但是动画效果不是特别理想

3）全部否决第一种，第二种方案，在UICollectionView的父视图上添加一个手势，如果手势在UICollectionView上，就根据手势的偏移量，来进行动画，如果在self.view上，就根据touchesMoved的偏移量进行动画(注：手势响应和touchesMoved，不会冲突)
```
        let panGes: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureAction(panGes:)))
        panGes.delegate = self
        self.addGestureRecognizer(panGes)
```
只有在 point.y / point.x > 1.5时，才让手势进行响应
```
     // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) {
            let point: CGPoint = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: self)
            if point.y / point.x > 1.5{
                return true
            }
        }
        
        return false
        
    }
    
```
手势响应的处理
```
 // MARK: - ConsumeTypeViewDelegate
    
    func consumeTypeViewPanGesture(ges: UIPanGestureRecognizer) {
        
        switch ges.state {
        case .changed:
            
            let point: CGPoint = ges.translation(in: self.view)
            movement(value: point.y, type: MovementSpaceType.pointY)
            
            break
        case .ended:
            movementEnd()
            break
        default: break
            
        }
        
    }
```
touchMoved的响应处理
```
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: UITouch in touches {
            
            let length: CGFloat = touch.location(in: UIApplication.shared.delegate?.window ?? UIView.init()).y - touch.previousLocation(in: UIApplication.shared.delegate?.window ?? UIView.init()).y
            movement(value: length, type: MovementSpaceType.increasingY)
            
        }
        
    }

```

### 3、如何获取系统键盘的实例
```
func getHostView() -> UIView {
        
        var hostView: UIView?
        var containerView: UIView?
        let windowsArray =  UIApplication.shared.windows

        for window: UIWindow in windowsArray {

            let subArray = window.subviews

            for view: UIView in subArray {
                if view.description.hasPrefix("<UIInputSetContainerView"){
                    containerView = view
                    break
                }
            }

        }
        
        hostView = containerView?.subviews.first
        
        return hostView ?? UIView.init()
           
    }
```

## 结语
这里只是记录一下在项目中遇到的问题，及解决方案的思考

## Contact
* Email : lizhijing1209@163.com 
* QQ    : 2631578708 



