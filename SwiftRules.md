# Swift 基本规范

## 命名规范

## 声明规范

1. 声明对象，变量使用 var，常量使用 let；
2. typealias 声明别名，作用域尽量包含在类中，e.g.`typealias FinishHandler = (String) -> Void`；
3. 使用 String、Array、Dictionary、Int、Bool 代替 NSString、NSArray、NSDictionary、NSNumber、BOOL；
4. 使用 struct 代替 Class，使用 print 代替 NSLog 等；

## 推荐语法

1. 优先使用 guard 和 ?? 进行解包，`guard let > ?? > if let`；
2. JSON序列化与逆序列化，为了程序的健壮性，成员变量尽量设置为可选类型（Optional）；
3. 数组推荐声明方式，e.g.`var list: [Any]? // Any 更改为指定类型`
4. 字典推荐声明方式，e.g.`var dict: [String: Any]? // Any 更改为指定类型`
5. 方法的参数和返回值推荐声明方式，e.g.
```swift
// 返回 Void 省略
func m1() {}
// 返回数组
func m2() -> [Any]? { return[] }
// 返回字典
func m3() -> [String: Any]? { return[:] }
// 参数直接指定为对应类型
func m4(v1: [String: Any]?, v2: [Any]?) {}
```
6. 字典或数组中取出的值为 Any 类型的可选值，转换使用`as?`，尽量不使用`as!`，防止程序 Crash；
7. Array、Set、String、Dictionary 对象判空时，使用 `obj.isEmpty` 方法代替 `obj.count == 0`；
8. 闭包中需要显式地引用 self，如果处理循环引用，用 weak 修饰 self，e.g.
```swift
table.es.addPullToRefresh { [weak self] in
    guard let strongSelf = self else { return }
    strongSelf.tableView.es.stopLoadingMore()
}
```
9. 省略 self，访问成员变量和方法时，除闭包中需要显式引用 self 外，其余不需要像 ObjC 那样使用 self 引用；
10. 省略 `init()`，e.g.使用`let label = UILabel()`，而不是`let label = UILabel.init()`；

---------
待整理
---------

## 函数设计

设计接口，及命名函数时，可以灵活利用 swift 特性简化函数。

**使用默认形参**

所有包含默认值的形参，调用函数时都可以忽略。例如同一个接口需要不同类型参数，可以利用默认参数简化。

```swift
// not bad 设计接口时，需要传入不同的参数
func test() {}
func test(param1: String) {}
func test(param2: Int) {}
// better 设计接口时，不需要为每一个形参编写一个方法，有默认值，参数可省略
func test(param1: String = "", param2: Int = 0) {}
```

**使用 _ 忽略调用的参数名**

对于调用时不需要显示的参数名，使用 `_` 省略形参名称。

```swift
// not bad
func updateWithView(view:UIView)
updateWithView(view:viewA)
// better
func updateWithView(_ view:UIView)
updateWith(viewA)
```

**关键词with/to/at/for/in等关键词设计为形参别名**

Swift 允许参数起两个名字：一个供调用时使用，一个在函数内部使用。

```swift
// not bad
func didSelectAtIndex(index:Int)
didSelectAtIndex(index:2)
// better
func didSelect(at index:Int)
didSelect(at:2)
// UITableView 系统 API 参考学习
open func rect(forSection section: Int) -> CGRect // includes header, footer and all rows
open func rectForFooter(inSection section: Int) -> CGRect
open func indexPathForRow(at point: CGPoint) -> IndexPath?
open func indexPath(for cell: UITableViewCell) -> IndexPath?
open func indexPathsForRows(in rect: CGRect) -> [IndexPath]?
```

**使用@discardableResult忽略函数返回值**

设计接口时，如果返回值无关紧要，可以使用 `@discardableResult` 标记函数，否则使用 _ 表示不使用的返回值。

```swift
@discardableResult
public func hideEmptyView() -> Self {
    emptyView.removeFromSuperview()
    return self
}
// 使用 _ 表示不使用的返回值
var a = [0]
let _ = a.removeLast()
[0].forEach{ _ in print("hello")}
```

## extension 分割代码

Swift 的扩展与 ObjC 的分类相似，但不相同，Swift 扩展是没有名字的，且功能更强大。
Swift 扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能，这里仅演示如何李勇扩展分割代码块。

```swift
class CustomVC: UIViewController {}
// 实现 UITextFieldDelegate 代理的监听方法
extension CustomVC: UITextFieldDelegate {}
// 实现 UITableView 数据源
extension CustomVC: UICollectionViewDataSource {}
// 实现 UITableView 代理
extension CustomVC: UICollectionViewDelegate {}
```

## lazy 关键字

懒加载不需要像 ObjC 一样重写 getter 方法，并判空了，在属性前面加上 lazy 关键字就可以实现了。

```swift
lazy var view = UIView(frame:.zero)
```

## 使用自动推断

可以借助 Swift 强大的自动推断能力，简化代码。

```swift
var names = ["Chris","Alex","Ewa","Barry","Daniella"]
// 完整格式
names.sorted { (s1:String, s2:String) -> Bool in
    return s1 > s2
}
// 闭包的函数整体部分由关键字 in 导入，但表达式时可以省略 return，所以可以省略为一行
names_sorted = names.sorted { (s1:String, s2:String) -> Bool in s1 > s2 }
// 由于排序闭包为实际参数来传递给方法，Swift 就能推断它的形式参数类型和返回类型
names_sorted = names.sorted(by: { (s1, s2) -> Bool in s1 > s2 })
// Swift 自动对行内闭包提供简写实际参数名，你也可以通过 $0 , $1 , $2 等名字来引用闭包的实际参数值。
names_sorted = names.sorted(by: { $0 > $1 })
// Swift 的 String 类型定义了关于大于号（ >）的特定字符串实现
names_sorted = names.sorted(by: >)
```

## 使用高阶函数

高阶函数可方便快速的完成原本复杂的操作，优化代码。

* filter：对给定数组的每个元素，执行闭包中的操作，将符合条件的元素放在数组中返回。
* map：对给定数组每个元素，执行闭包中的映射，将映射结果放置在数组中返回。
* flatMap：对给定数组的每个元素，执行闭包中的映射，对映射结果进行合并操作，然后将合并操作后的结果放置在数组中返回。
* compactMap：对给定数组的每个元素，执行闭包中的映射，将非空的映射结果放置在数组中返回。
* reduce：对给定数组的每个元素，执行闭包中的操作对元素进行合并，并将合并结果返回。

**使用 filter 函数，筛选出符合条件的元素**

```swift
@objc func textFieldTextChanged(_ textField: UITextField) {
    filterList = dataList.filter({ model in
        if let name = model.goodname, let txt = textField.text {
            return name.contains(txt.charactersArray)
        }
        return false
    })
    tableView.reloadData()
}
```

**使用 map 函数，进行快速结果映射**

```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let lowercaseNames = cast.map { $0.lowercased() }
// map 函数执行结果：'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]
let letterCounts = cast.map { $0.count }
// map 函数执行结果：'letterCounts' == [6, 6, 3, 4]
```

**flatMap 函数与 map 函数对比，会对映射结果进行合并操作**

```swift
let numbers = [1, 2, 3, 4]
let mapped = numbers.map { Array(repeating: $0, count: $0) }
// map 函数执行结果：[[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
// flatMap 函数执行结果：[1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
```

**compactMap 函数与 map 函数对比，会自动过滤空值结果**

```swift
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// map 函数执行结果：[1, 2, nil, nil, 5]
let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
// compactMap 函数执行结果：[1, 2, 5]
```

**使用 reduce 函数对数组元素进行合并**

```swift
let numbers = [1, 2, 3, 4]
// reduce(0) 中 0 为设置的 result 初始值
let total = numbers.reduce(0) { result, num in
    return result + num
}
// reduce 函数执行结果：10
```
