## Welcome to NB





![Image](https://github.com/NicolasBarbara/NBSideTabBarController/blob/master/image1.png)
![Image](https://github.com/NicolasBarbara/NBSideTabBarController/blob/master/image2.png)
![Image](https://github.com/NicolasBarbara/NBSideTabBarController/blob/master/image3.png)
![Image](https://github.com/NicolasBarbara/NBSideTabBarController/blob/master/image4.png)
### Example
```
let v0 = NBView()
v0.backgroundColor = .blue
let ds0 = NBSideTabBarControllerDataSource(tableViewCell: NBSideTableViewCell.init(text: "Blue"), view: v0)
let v1 = NBView()
v1.backgroundColor = .green
let ds1 = NBSideTabBarControllerDataSource(tableViewCell: NBSideTableViewCell.init(text: "Green"), view: v1)
let v2 = NBView()
v2.backgroundColor = .yellow
let ds2 = NBSideTabBarControllerDataSource(tableViewCell: NBSideTableViewCell.init(text: "Yellow"), view: v2)
let dataSource = [ds0,ds1,ds2]
let vc = NBSideTabBarController(dataSource: dataSource, width: 60, anchor: .left, colors: [.blue,.green,.yellow])
```
