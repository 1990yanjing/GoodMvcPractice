# GoodMvcPractice
mvc的正确实现

- 现在主流框架模式，例如MVVM，MVP等都是为了解决胖C而产生的基于MVC的实现，但是MVC的使用仍有自己的价值，正确使用MVC也是值得学习的事情
- 正确的使用MVC，需要注意的有两点
    - 将Model独立出来，独立的提供数据访问的API，不要与Controller或者View耦合在一起
    - 严格遵守MVC要求的数据流动规则；View与Model没有直接的数据通路，View和Model之间的通讯交互，完全通过Controller来完成；数据的流动是单向的：UI变化（交互驱动） --> 通过Controller作用到Model，更新Model --> 更新后的Model通过Controller作用到View，引起UI的改变 --> 等待下一次UI的变化
    - Demo中采用KVO的方式，将Model与Controller解耦
- Demo中还是使用一些第三方库
    - Alamofire作为联网库
    - ObjectMapper，作为Json -> Model的解析库
    - PromiseKit，链式调用，使得一步操作更加简洁直接
