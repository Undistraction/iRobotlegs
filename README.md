###Introduction

**iRobotlegs** is an Objective-C/Cocoa Touch port of the popular [**Robotlegs**]() MVCS Mircro-architecture for Actionscript 3. It aims to stick as closely as possible to the original framework without fighting against Cocoa-Touch. It should be familiar enough for someone who has used the original framework to find their way around easily, but it should be easy to understand for someone familiar with Objective-C but not the original framework. Where **Robotlegs** uses [**SwiftSuspenders**](https://github.com/tschneidereit/SwiftSuspenders) for its dependency injection needs, **iRobotlegs** uses a modified version of the excellent [**Objection**](https://github.com/atomicobject/objection) framework. There is an example project; 'FlickrGalleryBuilderMK2' in the examples folder and I aim to add more examples as time allows.

####Aims and Benefits

The aim of **iRobotlegs** is the same as that of robotlegs; to make application development easier and more consistant accross projects, to encourage clear separtion of the application into Model, View, Controller and Service regions,to encourage and enable loose coupling between these regions through the use of dependency injection and Event/Notification based communication, and to lower the cognitive hit from appraising or maintaining understanding of a growing project through consistancy. As with most similar frameworks it is not always the best answer, and for trivial applications it will be overkill.

###Differences

There are two primary differences between the way the framework is implemented in Cocoa Touch and Actionscript. **Robotlegs** makes heavy use of the 
DisplayList and events bubbling up through the DisplayList to the Application Root. This bubbling allows **Robotlegs** to watch for views being added and removed from the stage indirectly and automatically. If a view is added or removed, **Robotlegs** will hear about it. Whilst Objective-C uses a composite view structure, events do not bubble up and out. This means that the framework needs to be actively informed of relevant view activity through an NSNotificationCenter. Given the role that ViewControllers play in Cocoa Touch, this is not so much of a problem as it would at first seem.

ViewControllers are an interesting animal and perform a wide variety of functionality, both View-facing and Model-facing. A ViewController is responsible for its view's creation and destruction, aswell as managing its lifecycle. In many cases a ViewController may deallocate its view and allocate a new view to take its place numerous times during its own lifecycle to free memory when the view is not in use and recreate it when it is needed again.

At first glance they seem perfectly placed for notifying the framework that the view is being created or destroyed, however direct mediation of the view bypasses the ViewController, leaving it out in the cold. The ViewController is tightly coupled with the view/xib not only through shepherding it from birth to death, but also through outlets and actions. Through this two-way communication with its view (and the components it contains) the ViewController is essentially mediating it. This means the natural boundry between View and Framework that exists in Actionscript is blurred. At the same time, the ViewController is often used as a Delegate for View Components, tying it tightly to the view.

This leaves us with two options, both of which are currently supported by **iRobotlegs**. Firstly, we can remove the separate Mediator class from the framework altogether, knowing we already have mediation carried out by the ViewController. This means the ViewController must have access to the framework, fulfilling the role of a Mediator, interpreting view events to the framework and framework events to the view. 	Secondly, we can Mediate the ViewController. Though this effectively results in dual Mediators (a Mediator mediating a Mediator), it has the benefit of removing any need for the ViewController to have access to the Framework. There also seems to be more need for a separate Mediator when the ViewController in question is a Container ViewController, especially one that is responsible for switching between views (eg. UITabViewController, UINavigatorController). I think this is the aspect of the framework that has the most potential for improvement.

Objective-C has no support for meta-data or any kind of annotations, so I've echoed Objection's use of macros to allow for a kind of annotation of classes. Effectively the single iRobotlegs Macro wraps one Objection's macros. Whilst this approach isn't ideal, there is no other option available before removing the dependency declarations from the classes altogether and declaring all dependencies in some sort of configuration file. This is something I might look at later on down the line, but for the moment a macro which directly registers chosen properties with Objection is a good-enough solution. Unfortunately Objection does not support  optional dependencies and there is no way I can add it at the present time. However I have spoken to Objection's author; Justin DeWind who is going to look at supporting this functionality in a forthcoming release.

###Basic Usage

For a quick look at framework setup take a look at AppContext in the example application. There is also comprehensive documentation for Robotlegs over at [http://www.robotlegs.org/](robotlegs.org) and an [excellent book](http://www.amazon.co.uk/ActionScript-Developers-Guide-Robotlegs-Hooks/dp/1449308902/ref=sr_1_1?ie=UTF8&qid=1319298955&sr=8-1) on the framework published by O'Reilly. 

###Roadmap

At this point, the most important thing is to get some feedback from people who are using Cocoa-touch to help shape the Framework, however my primary goals at present are:

1. I want to focus on improving the view tier, whether supporting Mediators or using ViewControllers as Mediators. 
2. Once I feel that the framework is fairly stable I will fully document it. I also plan on moving over to using [Kiwi](http://www.kiwi-lib.info/) for testing.

###Author

Pedr Browne<br>
<pedr@1ndivisible.com><br>
[1ndivisible.com](http://1ndivisible.com)<br>
[github.com/1ndivisible](https://github.com/1ndivisible)

###License

The MIT License

Copyright (c) 2009, 2010 the original author or authors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

	