# css

<https://github.com/AllThingsSmitty/css-protips>
<https://github.com/AllThingsSmitty/css-protips/tree/master/translations/zh-CN>

## TODO: 做一个整体的,每次项目都加

```css
// css复位
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

// 继承 box-sizing ,与上面只用一个就可以
html {
    box-sizing: border-box;
}
*, *::before, *::after {
    box-sizing: inherit;
}

// unset
button {
    all: unset;
}

// :not 决定表单是否显示边框
.nav li {
    border-right: 1px solid #666;
}
.nav li:last-child {
    border-right: none;
}
// bad ->  good
.nav li:not(:last-child) {
    border-right: 1px solid #666;
}

// body 加行高
body {
    line-height: 1.5;
}

// 垂直居中所有元素 <https://css-tricks.com/centering-css-complete-guide/>
html, body {
    height: 100%;
    margin: 0;
}
body {
    -webkit-align-items: center;
    -ms-flex-align: center;
    align-items: center;
    display: -webkit-flex;
    display: flex;
}

// 逗号分隔列表
ul > li:not(last-child)::after {
    content: ",";
}

// 用负 nth-child 选择元素
li {
    display: none;
}
li:nth-child(-n+3) {
    display: block;
}

//  or
li:not(:nth-child(-n+3)) {
    display: none;
}

// 用SVG
.logo {
    background: url("logo.svg");
}

// 猫头鹰选择器
* + * {
    margin-top: 1.5em;
}

// max-height 来建立纯css滑块

.slider {
    max-height: 200px;
    overflow-y: hidden;
    width: 300px;
}
.slider:hover {
    max-height: 600px;
    overflow-y: scroll;
}

// 等宽表格
.calender table {
    table-layout: fixed;
}

// Flexbox 去多余外边距

.list {
    display: flex;
    justify-content: space-between;
}
.list .person {
    flex-basis: 23%;
}

// 利用属性选择器来选择空链接
a[href^="http"]:empty::before {
    content: attr(href);
}

// 默认链接定义样式
a[href]:not([class]) {
    color: #008000;
    text-decoration: under-line;
}

// 一致垂直节奏
.intro > * {
    margin-bottom: 1.25rem;
}

// 固定比例盒子
.container {
    height: 0;
    padding-bottom: 20%;
    position: relative;
}
.container div {
    border: 2px dashed #ddd;
    height: 100%;
    left: 0;
    position: absolute;
    top: 0;
    width: 100%;
}

// 破图定义样式
img {
    display: block;
    font-family: Helvetica, Arial, sans-serif;
    font-weight: 300;
    height: auto;
    line-height: 2;
    position: relative;
    text-align: center;
    width: 100%;
}
img:before {
    content: "we're sorry, the image below is broken :(";
    display: block;
    margin-bottom: 10px;
}
img:after {
    content: "(url: " attr(src) ")";
    display: block;
    font-size: 12px;
}

// 用rem 调整全局大小;用em调整局部大小
h2 {
    font-size: 2em;
}
p {
    font-size: 1em;
}
article {
    font-size: 1.25rem;
}
aside .module {
    font-size: .9rem
}

// 隐藏没有静音、自动播放的影片
video[autoplay]:not([muted]) {
    display: none;
}

// :root 控制字体弹性
:root {
    font-size: calc(1vw + 1vh + .5vmin)
}
body {
    font: 1rem/1.6 sans-serif;
}

// 为表单元素设置大小
input[type="text"],
input[type="number"],
select,
textarea {
    font-size: 16px;
}

// 使用指针事件控制 鼠标事件
.button-disabled {
    opacity: .5;
    pointer-events: none;
}
```















