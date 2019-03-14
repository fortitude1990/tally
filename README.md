# 仿网易有钱APP动画

## 简介
最近在使用网易有钱APP的时候，感觉添加一笔账单的页面动效挺不错的，所以就模仿着写了一下这个页面的动画效果

##语言
swift

## 第三方
[SnapKit](https://github.com/SnapKit/SnapKit)

## 开发中遇到的问题
* 输入框处于FirstResponder下，如何不弹出键盘
* 如何让UICollectionView横向翻页滑动
* 手指在UICollectionView上，self.view页面可以进行流畅的竖向滑动
  + UICollectionView的touchesMoved无响应
  + UICollectionView上的手势冲突
* 如何获取系统键盘的实例
* 系统键盘和自定义键盘之间的流畅切换
* 动画效果的调试

## 奇葩问题
* 代理函数中使用switch，只写一个case下，导致代理函数偶尔无响应

## 图样
<div>
<img style="float:left margin:5" src = "https://github.com/fortitude1990/tally/blob/master/images/WechatIMG2.jpeg" 
width = "25%" alt = "记录一笔"/>
</div>





