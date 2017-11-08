import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  Image,
  View
} from 'react-native';

class Greeting extends React.Component{
  render(){
    return (
      <Text>Hello {this.props.name}!</Text>
    );
  }
}

class Blink extends React.Component {
  constructor(props) {
    super(props)
      this.state = {showText: true};
      //每1000毫秒对showText状态做一次取反操作
      setInterval(() => {
        this.setState(previousState => {
          return {showText:!previousState};
        });
      },1000);
    }
    render() {
        // 根据当前showText的值决定是否显示text内容
    let display = this.state.showText ? this.props.text : ''
        return (
            <Text>{display}</Text>
        );

    }
}

class AboutUs extends React.Component {
  render() {
    let pic = {
      uri: 'http://img3.redocn.com/tupian/20150312/haixinghezhenzhubeikeshiliangbeijing_3937174.jpg'
    };
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,\n Cmd+D or shake for dev menu,awesome!
        </Text>
        <Image source={pic} style={{width: 193, height: 180}} />
        <Greeting name='Rexxar' />
        <Greeting name='Jaina' />
        <Blink text='I love to blink' />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    color: '#FF0000',
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
    red: {
    color: 'red',
    },
    bigblue: {
        color: 'blue',
        fontWeight: 'bold',
        fontSize: 30,
    },
});

// 整体js模块的名称
AppRegistry.registerComponent('MyReactNativeApp', () => AboutUs);