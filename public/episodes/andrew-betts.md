## Transcript

*Transcription by Seth Lavelle.*

**Andrew Betts:** So, I have never run in an election before in my life, and it has been fascinating to look at how the voting system works, and to understand who the electorate are, who do I need to take out to dinner… It’s not quite Hillary Clinton’s campaign. So, it’s interesting…

---

**Rebecca:** Hello. I’m Rebecca Murphey and this is the TTL podcast.

The TTL podcast is sponsored by the fantastic folks at [Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform that makes it possible to test your app across browsers as part of your continuous integration or continuous delivery workflow. Plus, they give you manual access to more than 500 browser-platform combinations. Try it for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo code.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and deploy with confidence. Sync your GitHub projects with Travis CI and you’ll be testing your code in minutes. Travis CI is offering a free trial to the first ten listeners of this episode who sign up with the promo code on [ttlpodcast.com](http://ttlpodcast.com).

---

**Rebecca:** Hello, I’m Rebecca Murphey and this is the TTL podcast. Today, I’m here with Andrew Betts from [FT.com](http://ft.com), or the *Financial Times*, if you haven’t heard of FT.com. How are you doing, Andrew?

**Andrew:** I’m good, Rebecca. How are you?

**Rebecca:** I’m doing great. Thanks for coming on today.

**Andrew:** No problem.

**Rebecca:** So, you’re at FT.com, specifically working on [FT Labs](http://labs.ft.com/). Can you tell me a little bit about what you do there?

**Andrew:** Sure. So, I have a sort of dual responsibility at the FT. I’m director of FT Labs, which is a small team that makes prototypes. We experiment with new technology—so, things like watches and wearables, new web technologies, like [Service Workers](http://www.html5rocks.com/en/tutorials/service-worker/introduction/) that we can’t really use in production yet because there’s not enough browser support. All kinds of different ideas that really aren’t yet ready for our product team, we experiment with those in very short one-month-or-less projects.

And the other thing that I do is I lead a team called [Origami](http://origami.ft.com/), which is our component team, and they are responsible for building components and tools for front-end developers across the company, to build what we call “brand consistent experiences,” which is kind of like enterprise speak for “make it all look the same.”

**Rebecca:** So, I want to talk about Origami, and that’s actually why I wanted to bring you on the show, was I came across Origami and was really interested in that. But before we talk about that, I wanted to talk about FT Labs and that work that you’re doing. Who decides what you’re working on? Who decides, “Today, we should look at Service Workers” or, “Today, we should play with Apple Watch”?

**Andrew:** So, that’s a really interesting question. Of course, something that was hotly debated when we set the team up: How exactly should you choose what you’re going to spend time on? Because if you just put yourself out there and say hello everybody, we’re here, what would you like us to work on, then it’s not going to be a short list. And quite a lot of the time, it’s just going to be fairly boring stuff. It’s going to be teams saying, “Well, we have this huge backlog of stuff that we want to do and we don’t have time to do it, so can you do some of it for us?” and that’s really not what the team is for.

So, we need to find things that are sufficiently innovative, things that don’t have a natural home somewhere else in the company—you know, a team that’s just too busy to work on them. I think there needs to be an element of virality to it, as well. There needs to be a sense that this is cool, this is something that people will find notable. So, we put together a series of evaluation criteria and we invite anyone, whether they’re in the company or just a reader, fans on Twitter, whoever, to submit whatever ideas they like and then they go through that system of evaluating them on various criteria.

Another one which is quite interesting is we try to find ideas for which there is an advocate within the company that’s not a developer. So, ideally you’ve got a journalist, or a designer, or someone from our events and conferences team, someone in the company who has an idea and they’d really like to step outside of their normal job for a few weeks and go and work with a team who can build it for them.

**Rebecca:** Backing up a little bit, tell me about the *Financial Times*. What’s the scope of the business, and the audience, and the challenges of working at a company of that size and history?

**Andrew:** Well, the history is amazing. To work as a developer at a company that’s 127 years old, I think—I’ve almost certainly gotten that wrong, but I think 1888 we were founded. Obviously it’s changed an awful lot in that time. Most of that change, though, has been in the last 15 years. So, the FT has all the same challenges as every other old media organization, particularly newspapers, in adapting to the web, adapting to people’s willingness to pay for content and all of this kind of thing.

The FT is quite unique in a number of ways. We have something like three quarters of a million paying subscribers, and that includes corporate subscribers, individuals, business-to-business sales, all of that kind of thing.

But these days, it’s much more about the kinds of services that we can offer around the content itself. So, people aren’t just paying for the content, they’re paying for the whole experience of the interactives, the professional services, all of the events, the whole kind of FT universe of stuff that we can do for them.

**Rebecca:** What are the front-end challenges of that audience, and what devices are you dealing with, and browsers, and locations, and speeds? What are the landscapes of your users?

**Andrew:** The FT’s users are disproportionately corporate. So, we have a lot of users who work for banks, a lot of users who work for large enterprises, and the front-end challenge that comes with that is you have a lot of lockdown enterprise systems that run potentially fairly old software. So, more than others, we have to deal with fairly old versions of IE, for example; we still have a fairly significant contingent of users on IE8. I shouldn’t complain too much—our colleagues in Beijing, who run FT Chinese, have a fairly significant number of people in IE6, so…

**Rebecca:** [laughs] It could be worse, it could be worse…

**Andrew:** And we have to work with IE6 as a result, because the Origami team provides tools and components to FT Chinese. So, we still have—not that we try to think about it too much, or let it slow us down too much—but we do have to think about a lot of legacy browsers.

**Rebecca:** So, I got in touch with you after I learned about Origami. I was doing some research for some work that I’m doing and came across this site that you’ve put out there that is just this really comprehensive way of thinking about front-end development—and a very *opinionated* way of thinking about front-end development—but also a really methodical way of thinking about front-end development across this very diverse set of sites that you maintain. Can you tell me a little bit about Origami, for people who haven’t heard of it, and just how that came to be?

**Andrew:** Sure. And actually the opinionatedness—if I can call it that—is a really interesting property of it, because, yes, it is incredibly opinionated, and we spend a lot of time—probably more time than we should—arguing over whether something is opinionated or not. [laughs] But it is intentionally opinionated. The idea is very much that we are trying to save people time, and the easiest way to save people time is to provide one single agreed way of doing something so that we can all just kind of put whatever argument it is behind us and move on to the next thing.

So, to step back a little bit: the origins of Origami are that the FT registered its first domain name in the early ’90s, very, very early on, and today we have something like 600 domain names. So, it’s this proliferation of web properties. Now, we certainly don’t have 600 web products, but we have a lot—so many that I can’t count them and I don’t know on a day-to-day basis exactly how many we have. So, when you’re in that situation of having so many web properties, you have to do something to try and bring some order to the chaos, effectively. You’ve got lots of different teams building all sorts of different products. In some cases, you’ve got third parties that our marketing or comms department are working with to produce microsites for marketing campaigns.

There needs to be some kind of process to ensure that the readers actually experience the FT in one single coherent voice. You talk to our editors and you find that we have an extraordinary amount of effort going into giving the FT a consistent voice. So when you read our content, you get that. That is something that the FT has had for tens of years, since the early twentieth century. But we still can’t get it right in terms of the user experience. We are still very, very early days when it comes to providing a single consistent voice in terms of our user experience because we are too fragmented in terms of the products that we create. So, Origami was a way to address that.

**Rebecca:** Did the motivation for Origami come from below or above? And I’m using air quotes when I say “below” or “above.”

**Andrew:** I don’t know whether it would be—below or above what? Did it come from the top or the bottom, I suppose is what you’re saying.

**Rebecca:** Yeah, I don’t know if the FT has a CEO or how you’re organized, but was there a CEO saying, “Let’s do this!” or where did that come from?

**Andrew:** Well, so our CEO doesn’t really… He’s not really known for micromanagement. He likes to set his strategic direction, and so what we try to do is extrapolate what we feel that strategic direction means in practical terms. For me, the strategy of providing a whole suite of content, and interactive services, and kind of associated things like events, and emails, all kinds of different stuff to our readers meant that increasingly the FT isn’t just one type of thing anymore, it’s lots of types of things. And so, if readers are going to be flowing seamlessly between all of these different things, then they have to feel like they’re getting all of those things from the same source, from the FT that they’re paying their money too. For me, it kind of fell out of that strategy of how we build a modern set of products that are customers are going to want to buy.

**Rebecca:** Origami really prescribes a lot of things—a lot of approaches to how you will develop things at the FT. How does that jive with the fast-paced news world, where people might say, “I don’t have time to do it the way you tell me to! I’ve got to do it the fastest way possible.”

**Andrew:** Yeah, for sure. So, the best example of that is our interactives team, which is a team of developers that worked in the newsroom to produce software applications that effectively support stories. One of my favorite of those is the coalition builder that we built for the UK general election. The principle was that you could adjust the number of seats that each party won—you’d be predicting how many seats they would win—and then you would be able to see what kind of coalitions might be workable from those numbers of seats. It was a fantastic tool because it was exactly what people needed. In the UK, we’ve only had a coalition once before. People don’t really yet understand how coalitions work, and this kind of interactive made it *really* clear. You could play around with the numbers and see exactly how that affected the outcome. And that tool was built using a number of Origami components.

So, it’s really important that if we do set out to provide something that is universally applicable to all of our products and is intended to provide this consistent experience across everything, then it needs to be possible to use it for everything. It’s really important that there aren’t exceptions where one team decides, “Well, it’s too difficult for us to use,” and then another team will look at that team and say, “Well, they didn’t use it, so it’s probably not any good. We won’t use it either,” and it’s a very, very slippery slope and you end up with the whole thing just being an expensive waste of time.

**Rebecca:** Does that end up being something that you are personally doing the political work of evangelizing, or is that something that kind of comes down, again, from above, saying, “You *will* use this Origami thing!” Where does that come from, that mandate?

**Andrew:** This is so important; this is actually one of the topics that I think is most important about what I do, is to ensure that when we create these kinds of platform services, something which there’s a team that is producing it and other teams that are consuming it, you have to get that communication right. If you don’t, then very quickly you get to the point where neither team really cares, and the quality of the product is then extremely poor. And I’ve seen this at so many other components, which I won’t go into specifics on. [laughs]

But there are so many examples of where you have a frameworks team, or a platforms team, and everybody hates them because they’re responsible for slowing your site down. You have to use their stuff, you’re required to use their standard header and footer and framework or grid or whatever, and you think your team can do it better but you don’t have a choice because you’re locked into that kind of brand standard. I was very clear that we weren’t going to do that. I wanted it to be almost entirely carrot and not stick. I think the only sense in which a stick should be involved in this is to say to teams, “You have to make a site that is brand consistent. It is really important. Think about it from the reader’s point of view: if you’re moving from one product to another, you need to feel like things are changing for good reasons and not just because one team couldn’t be bothered to talk to another team.” The logo moves slightly or changes, or is an old version—it just gives a really unprofessional view of the company to our readers.

So, if there’s one mandatory element to this, it’s saying to all of the different product teams, “You must produce high quality sites that give the readers that impression of quality. If you choose to do that using Origami, then fantastic. And if you can’t use Origami and instead you do succeed in creating a high quality site but you do it another way, then we’ll learn from you and we’ll build that back into Origami.”

**Rebecca:** How do you define what a high quality site is? Obviously the brand compliance is part of it. What other definitions do you put around high quality?

**Andrew:** Well, I think there are quite a number of quantifiable metrics that you can use, things like Google’s PageSpeed Insights service, for example, give you a lot of insight into performance. And things like WebPageTest—you could do usability studies, you could do user research. Even things as cheap and simple as quick hallway usability questions just to gauge is this a product that someone has thought about, is this something that readers can use, is it doing things which we have a standard way of doing and it’s invented a new way of doing them. There are a number of fairly simple questions that you can apply to a product just to see whether someone has actually thought about that experience properly.

**Rebecca:** And do you work with the teams to ask those questions? Or are those questions just sort of implied?

**Andrew:** We do work with people to ensure that they are asking those questions. So, I think partly it’s a matter of education, of going to maybe some teams that haven’t been used to doing that in the past, where they’re producing, say, marketing microsites where perhaps our quality standard in the past has been lower, and convincing them of the need for a higher standard. Once you’ve got to that point, once that persuasion has happened and has been successful, then you’ve really won almost all of the battle because at that point they’re going to be actively looking for ways to meet that new standard. And if you then provide them with ways to meet that new standard where you make their job easier, then they’re going to be lapping it up.

**Rebecca:** We talked earlier about how you’re opinionated with Origami, and you mentioned a little bit that there are a lot of debates about what to be opinionated about and what not to be. Can you talk a little bit more about that and how you decide what to be opinionated about, where it’s worth having an opinion and where it’s worth letting teams do their own thing?

**Andrew:** Sure. I’m just trying to think of a good example of that, really. We’ve certainly had a lot of discussion on all sorts of different topics where we have our weekly spec meeting, and anyone can come to that meeting and essentially make a pitch for something to be standardized, and we will have a discussion, we’ll see what the various opinions are. Sometimes the opinions are so diverse that it’s essentially impossible to come to a consensus that everybody is willing to accept—not just happy with, but even willing to accept. In that sort of situation, there’s really no point in trying to standardize it against the better judgement of members of the team because it’ll make them really reluctant to use it.

So, in other cases where you find that there is reasonable consensus but maybe there are a few detractors, then actually the benefits of convincing the whole group to agree on one approach I think are significant. So, we do try and push it over the line whenever we can. And that means that when people move from one project to another, even if they move to a totally different team working on a totally different product, they quite often find the techniques and the tools are very similar, and they land on their feet ready to run because they’re already using all the same best practices and all the same standards. I think the benefits of that really can’t be overstated.

So, we try where we can to be flexible, all come together and agree on the same best practice, and that does result in us being very opinionated about a lot of things. But there are certainly many things where we’ve tried to do that and we’ve failed.

**Rebecca:** And I thought that was—well, there’s a lot that’s interesting about the Origami site, which is [Origami.FT.com](http://origami.ft.com)—that was *one* of the many things that was interesting about it, was the opinionatedness of it. And I don’t want to sound like I’m using that as a bad word at all. I think it’s a really good word and really important to be effective with something like Origami.

**Andrew:** Sure. I mean, let me be clear, although Origami is open source, I don’t feel like this set of opinions are likely to apply to anyone else, and that’s almost purely because they are so specific. It is a group of people that have come together all with the best interests of the FT to talk about how we, as a company, should agree to build web apps. Whilst there’s nothing inherently FT-specific about that, it’s just such a specific combination of opinions that I would expect another developer to go and pick up that spec and say, “Yes, but why? But why? But why?” [laughs]

**Rebecca:** But I also think it’s interesting because it is a record of the things that you have been able to come to an opinion about, and even though I might, in my organization, have a different opinion and come to a different decision, it’s still kind of a list of things that you might want to think about and at least attempt to standardize on. Maybe you’re successful, maybe you’re not, but I found it valuable just for that: in laying out those categories of questions to ask.

From reading the [FT Labs blog](http://labs.ft.com/category/news/), a lot of the recent posts at least have been about the work that you do to optimize how you ship code to your user’s browsers. I’m curious, it seems like you’ve done a lot of work with that, with the [builds as a service](https://github.com/Financial-Times/origami-build-tools), the [polyfill service](http://cdn.polyfill.io/v1/docs/), and some of the other things you invent there. Do you feel like you’re done? Is there more to do in that area of how you actually turn code from being on a developer’s machine to being out in the world? What are you still working on there?

**Andrew:** The build service that you mentioned there, and the polyfill service, we consider those to be parts of Origami. It goes back to this point about carrots and sticks: We want to make Origami as easy to use as possible because the easier it is, the more likely it is that someone will pick it up and think, “Oh, well this will just make my life easier, make my job easier, so I’m obviously going to do that.” I’m a really strong believer in the principle that it’s always too hard. No matter how easy you make something, it is still too hard, go make it easier.

With that in mind, with that philosophy ingrained in you, you end up doing a lot of things that you would otherwise consider unnecessary, and I think the build service and the polyfill service are both examples of that.

Take the build service first. We realized that all of the build tooling that you needed to adopt Origami components was quite complex—it was Gulp, and Sass, and Bower, and various other kind of standard Node tools. You make a list of those tools and you might think, well, anyone that builds front-ends these days knows how to use those tools, it’s not complicated. You can write them a readme and they’ll get started pretty quickly. And we thought, “Well, no, we can make it easier than that. So, let’s do that.” So, we made a tool called Origami Build Tools, which is a single Node application that kind of wraps all those other tools up. So, all you have to type is “Origami Build Tools Install” and it will run all those other applications for you.

Again, you could stop there and say, “Well, that’s good. Problem solved.” But, you know, you could still make it easier. So, we did. So, we put that tool on a web server and said well, if you don’t want to install it yourself, just use it as an HTTP API. And so now if you want to create an application that has Origami components in it, you literally just write a stylesheet tag into your source code. And so now you can write FT webpages with Origami components on CodePen, or JS pen, or anywhere you can write HTML and view it in a browser. You don’t need to have a build process anymore.

So, the extent to which that empowers developers is quite amazing. We actually now have designers, product managers, product owners—even journalists, stakeholders, editors—are able to just shove components on a page and say, “Could we do this?” because it’s *so* easy to do. So, that was really the great success of the build service.

**Rebecca:** So, they’re using a script tag or a stylesheet tag to load in the JS or the CSS for the components. How do they then add their own JS or CSS to the experience?

**Andrew:** Oh, so they would just add another script to a link tag for that.

**Rebecca:** And so at build time, do you bundle that all up or do you let those exist independently still?

**Andrew:** So, if you were to install Origami build tools locally and have your own build process, then you can combine your own JS and CSS into the component’s JS and CSS, and so you would end up with one single bundle which you would minify and compress all together. So yeah, there is a more optimized approach if you take that step.

But if you don’t want to take that step, let’s say you’re doing a hack day or you don’t have the skills because you’re a designer or a product owner, you’re not an engineer, having the build service gives you that extraordinary empowerment to essentially communicate your ideas in code without having to dive as deeply as understanding the build process, and I think that has been extraordinarily successful.

**Rebecca:** That’s an interesting thing. You’re kind of balancing ease of use and the developer story with performance. Because you might end up with an application that’s a little bit less performant than it would be if you did do that bundle step, but you’re able to ship it, whereas otherwise you might not have been able to ship it at all.

**Andrew:** Yeah, absolutely. And considering all of our legacy applications—you know, as I said, we’ve got hundreds and hundreds of domain names and we’ve been building web applications for 20 years. So, there’s a lot of them out there that have no build process at all or use tools that are totally obsolete and won’t run on any systems that we now use for development. If somebody is told, “We need to make a change to this site that was last changed in 2002” … [laughs] That’s not fun. So, why not just drop an additional link or a script tag into that page to load some components, offload that modern build process to a remote service, and then you don’t have to touch that black box, which you definitely don’t want to touch because… [laughs] All kinds of stuff could go wrong.

**Rebecca:** Every company has, as they get old enough, this issue of legacy code and legacy decisions. But that seems to be an especially acute issue in the news business. Every now and then, you’ll go searching for some story and land on a New York Times page from, like, 1999 or something. It still looks exactly like the New York Times in 1999. [laughs] I imagine that’s an especially acute problem for you as well.

**Andrew:** Yes, absolutely. And the polyfill service is two sides of the same coin, really. The polyfill service does a very similar of job in that we obviously want to write the latest code but we have all of these applications which need to support older browsers, and we have a fairly large contingent of users that are on older browsers. So, rather than having each team independently try and figure out, “Well, do we use polyfill for this? Which polyfill is the best one?” because if you search Google for Promise Polyfill, you’ll find at least four of them. So, which is the best one, which is the one that most faithfully emulates the native feature? Are you really going to have all of your teams independently do that research? It just seems inefficient to me. So, we created the polyfill service because we really just wanted to solve this problem for everyone at once, and the idea is that you just include that as part of your base page layout and it will polyfill everything that you need.

**Rebecca:** Imagine it’s 2015 now, let’s say you’re writing for ES6, or maybe you’re writing for ES5, but some day there will be ES7. Is that polyfill service versioned for the current ideal?

**Andrew:** It’s interesting, isn’t it? Because one of the most challenging aspects of the transition from ES5 to ES6 is the change in syntax. You know, you can write ES6 syntax which is simply a syntax error in ES5 before you even get to compile it. So, we have [Traceur](https://code.google.com/p/traceur-compiler/) and [Babel](https://babeljs.io/) and all of those transpilers to solve that problem.

But in my mind, the real problem comes when you start to see significant native support for ES6 and developers start to feel that support is sufficient, that they no longer need the transpiler. So, they take the transpiler out and that will then give us a very hard break with the browsers of the past because you’ll come to the site with a browser that will simply syntax error on your JS. That is a difficult problem to solve, because you can’t polyfil—

**Rebecca:** [laughs] You can’t polyfill a [fat arrow](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions), right?

**Andrew:** You can’t polyfill the code parser in the JS engine. So, the polyfill service is never going to be a complete solution to that problem. But at the moment, we get around this by not using any ES6 syntax in our production code. So, we use Babel to compile it to ES5, and we ship ES5-compatible syntax to all browsers, and then we use the polyfill service for the features, the web APIs that don’t exist in ES5. So, things like the additional `Math` functions or promises or whatever ES5-compatible API that doesn’t exist in that browser—we can create it using the polyfill service. But when it comes to syntax, that’s an entirely different challenge.

**Rebecca:** Is there a future where you end up actually shipping multiple versions of production code using user agent detection, kind of like the polyfill service ships the polyfills using user agent detection?

**Andrew:** I don’t know. That’s a very difficult question because I’m always loathe to think, well, the solution is just to fork something else. As soon as you start saying, “Oh, well it’s easy, we’ll just do one version for this, and another version for that, and another version for the other thing,” everything starts slowing down. The more complexity you have, the less efficiency you have. So, I’d love to say no. I think that the more you can strictly stick to the principle of shipping the same code to all browsers, the more simple and the more maintainable your application is going to be. But who knows, maybe we will end up having to do that.

**Rebecca:** Well, we’re probably a few years away at least.

---

**Rebecca:** I want to pause here to thank [SauceLabs.com](https://saucelabs.com) again for their sponsorship of this show. They brought front end ops to the forefront with the Front End Ops Conference in 2014, and they continue to make it possible for us to have insight into how our applications work, or, you know, don’t work across way more browsers and operating systems than you ever want to be responsible for maintaining yourself. If you haven’t checked them out, then just press "pause" and go do it. But first, hit up the [ttlpodcast.com](ttlpodcast.com) website for your promo code.

---


**Rebecca:** And we’re back. So Andrew, one other thing that I wanted to talk to you about that isn’t on the topic of any of the things we just talked about, but it is a little bit, is [Edge Conf](https://edgeconf.com/2015-london). It’s a conference that you have been running for a couple years now and it’s coming up again this summer in London. I’ve never been, I want to go. But can you tell me a little bit about it and how it’s different from other conferences?

**Andrew:** Sure. It is different from other conferences. I know *every* web conference says that, but we like to think that we are. We do have something unique. The reason I started Edge was because I felt that I was going to a lot of conferences and I was getting a lot of information which is really useful but I was coming away with a lot of questions that I wasn’t able to get answered in the talk. And Q&A I’ve always found very frustrating. It’s an uncurated experience. The best content doesn’t have a good way of surfacing itself.

So, these talks being largely non-interactive, and then the short periods of interaction which you can’t get as much value out of them as you would like to, lead me to think well, what we would really like is something that’s far more interactive, more collaborative, where everybody is encouraged to contribute more, and we can blur the lines between speakers and delegates. Something that people struggle with Edge Conf a little bit: I call everyone contributors, because we really don’t have any speakers. We have panels where we put some people who are supposed to have opinions and stuff on stage, and we get them to say some stuff about that topic. But we really expect that just to be almost like a backup really just in case the audience doesn’t come up with anything. [laughs]

But the idea is that everyone in the room has opinions on this stuff. So, why don’t they all just get stuck in and talk about their problems, talk about the hacks and the libraries that they’ve written, talk about their use cases, the practical scenarios that they’ve had with their commercial products, and bring that to a much wider audience? Because we hear a lot from people who write specs and people who write browsers, and we don’t hear so much from independent developers, developers in enterprise, people who actually experience these use cases everyday and quite often have come up with quite innovative workarounds. And if we exposed a lot of that information to the people who write the specs and the people who write the browsers, then actually we could achieve a lot more.

**Rebecca:** And so what sort of panels do you have lined up for this year?

**Andrew:** Well, this year we have four panels. Security is our first panel. And then we have a panel on progressive enhancement. Progressive enhancement has actually been something of a challenge because I really wanted to get a nice debate going on about whether progressive enhancement really has a place anymore, and I found it quite difficult to find people who were willing to sit on the panel and say, “Progressive enhancement is a really bad thing.”

**Rebecca:** [laughs] Yeah, that’s a dangerous political opinion these days, isn’t it?

**Andrew:** Which maybe tells you a little bit about my bias. But we have managed it, so I think that should be a really interesting conversation. We also have a panel on components and modules—of course that’s a hot topic right now. And we also have a panel on front-end data, because I’m fascinated with this move from the server to the client of more and more and more complex—not only functionality—but also data storage and data modeling.  You find that in applications now, you quite often have data that is collected, processed, stored, transformed, and expires without ever actually going to the server. So, I think a conversation around the complexities of that new kind of dealing with data is kind of overdue.

So, we have four panels, and then in the afternoon we do breakouts, where we break people up into much smaller groups and we talk about very, very specific issues. Things like ES6 patterns, polyfills, Sass and CSS patterns, installable web apps and app stores, interoperability between browsers and features behind flags and all this kind of stuff. Hopefully it will be a great event.

**Rebecca:** Yeah, I wish I could be there. One of these days I need to make it. I’m always paying attention to it when it’s happening but haven’t been able to make it yet.

I like to ask my guests who have probably been doing this “web thing” for a little while: What do you think is going to be different about our jobs three years from now? What’s going to be hopefully better about this thing that we do three years from now?

**Andrew:** I think the thing that we will see changing more in larger businesses like the FT is a breaking down of barriers between different types of disciplines within technology, and even outside of technology, the way they’re related to people who work in tech. That’s actually going to sound like something that’s already happened to a lot of people, but from the perspective of someone who works in a large organization, I think there are probably a lot of other people who work in large organizations who see the same thing. These sort of things are really slow to change. So, I think I will start to see a lot more at the FT, of starting to see design, and development, and user experience, and product management, and even editorial all kind of blending into one melting pot of disciplines. I really look forward to that, because I think there are enormous opportunities to be had from changing your organization to take best advantage of mixing all of those skills up together.

**Rebecca:** Well Andrew, thank you so much for coming on today. It has been a treat to finally get to chat with you. I’m sure our paths have crossed in the past, but good to have a nice, long conversation with you. Thanks for being on.

**Andrew:** Yeah, you too. Thanks, Rebecca.

---

**Rebecca:** The TTL podcast is edited by Morgan Murphey. Website design by Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a special thanks also to Bazaarvoice. For music and other credits, visit TTLpodcast.com. I’m Rebecca Murphey. See ya next time.
