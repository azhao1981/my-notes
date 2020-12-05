# hello react

## 开始

npx create-react-app react-demo
yarn start

code/js/react-demo

## 首页的类

<https://zh-hans.reactjs.org/>

### HelloMessage

```Typescript
// HelloMessage.js
import React from "react";

class HelloMessage extends React.Component {
  render() {
    return (
      <div>
        独立文件 Hello {this.props.name}
      </div>
    );
  }
}

export default HelloMessage;

// index.js
ReactDOM.render(
  <React.StrictMode>
    <HelloMessage name="weiz"/>
  </React.StrictMode>,
  document.getElementById('root')
);
```

## Timer

error: 参数“props”隐式具有“any”类型。ts(7006) 等等,编译不通过
