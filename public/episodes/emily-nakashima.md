## Transcript

*Transcription by Seth Lavelle.*

**Rebecca Murphey:** I like it. This is a good topic. It’s, uh… It is not a topic that has been discussed at all, so yeah, we can definitely talk about that …

---

Hello, I’m Rebecca Murphey and this is the TTL podcast.

The TTL podcast is brought to you by the fantastic folks at [Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform that makes it possible to test your app across browsers as part of your continuous integration or continuous delivery workflow. Plus, they give you manual access to more than 500 browser-platform combinations. Try it for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo code.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and deploy with confidence. Sync your GitHub projects with Travis CI and you’ll be testing your code in minutes. Travis CI is offering a free trial to the first ten listeners of this episode who sign up with the promo code on [ttlpodcast.com](http://ttlpodcast.com).

---

Hello, I’m Rebecca Murphey and this is the TTL podcast. I am here today with Emily Nakashima. She’s [a JavaScript developer at GitHub](https://github.com/eanakashima), working on application development, browser monitoring, and web performance. She also volunteers with [RailsBridge](http://www.railsbridge.org/). How ya doing, Emily?

Emily Nakashima:

Hi, doing great.

**Rebecca:** Excellent. Thanks for being on today.

**Emily:** Yeah, psyched to be here.

**Rebecca:** I’m sorry that I didn’t get to meet you when we were last in the same town, but this is almost as good, so. Perhaps we’ll have a better conversation now than we would in the whirlwind of a conference.

**Emily:** I had a dream that wasn’t the only Front End Ops Conf, too. So, hopefully it’ll happen again someday and everyone will get to re-meet everyone that they forgot that they met, or meet the people they didn’t meet.

**Rebecca:** Yeah, I think that’s why I just keep going to conferences, is someday I will get through that list of all the people that I actually want to talk to. So, thanks for coming on today.

I wanted to start off just by asking you a little bit about how did you get here—we’ve all heard of GitHub, right? And how did you end up in the world you’re in now?

**Emily:** GitHub is really cool because they don’t have a requirement that people come from a computer science background, and they often hire people who don’t even have college degrees, so I’m definitely in the not-CS background. I started doing front-end development in the early 2000s, like I was sort of a combination web designer/web developer in a way that people don’t really have that anymore. You kind of always have to learn that “one more thing” to get that website out the door, so if someone’s like, “Oh, I want to be able to hover these menu buttons,” and so you had to learn JS. This is before you could do hovering things and changing the background with CSS.

So, I found that I was just always learning that one more thing. I started doing full stack Rails, started working on web perf, and I gave a talk about doing client-side real user performance monitoring for perf, and one of the GitHub founders saw that talk and said, “We could use a little more of that at GitHub,” so that’s how I ended up here.

**Rebecca:** Oh, wow. So, very much serendipitous. Good on you for doing the conference talk, I guess. [laughs]

**Emily:** It was actually a five-minute lightning talk through [Women Who Code](https://www.womenwhocode.com/). It was, like, the first talk I ever gave and I look back now and I’m so embarrassed, but it turned out to be a good thing.

**Rebecca:** [laughs] Pretty good for your career, as it turned out. I also identify with what you’re talking about because I also came from that no CS degree, no formal training in any of this thing that we do, and here we are, right? It worked out okay.

**Emily:** Did you start in the early 2000s also, in the HTML table era? Because I feel like there was this sort of original webmaster person who sort of like forked and then became all of these different identities, and I’m always really interested to talk to people who lived through that era.

**Rebecca:** Yeah, it’s funny—so, I actually came from print. My career started doing print, I wouldn’t even call it design—print layout. So, very much the production aspect of doing print; I worked at a newspaper for a few years and then I got interested in this whole web thing in the late ’90s, early 2000s. But it was during the tables for layout period, like those dark, dark days, and in print we had this actually really powerful system of doing layout, and doing designs, and doing styles, and cascading styles that could inherit from each other. And so I came to this web thing and I was like, “What is this?” Like, I didn’t understand how to make a layout with tables and font tags, and so I was really put off by it for a while. It wasn’t until CSS came around that I actually was like, “Oh, well this makes sense. I get this.” Yeah, so I was around for those bad days but I really didn’t get it.

**Emily:** It’s so exciting to hear that at least one person found CSS intuitive.

**Rebecca:** [laughs] I don’t know if I would go quite so far as to say intuitive, but it was certainly more intuitive to me than tables, let’s put it that way. So yeah, I definitely know that career path and I think it’s really cool that GitHub is open to people who don’t necessarily have that traditional background. I would actually say that’s a traditional background for front-end people though, is to not have a CSS background and to not have a formal education in this thing.

**Emily:** I would say of the great front-end developers I know, probably more than half of them have an arts background, or literature, english, something like that.

**Rebecca:** Yeah, there’s lots of journalism and… I think it was people who didn’t know what else to do, they didn’t know what it was they wanted to do but it definitely wasn’t computer science, but they were interested in conveying information to people, and at the end of the day that’s kind of still what we do, is deliver information to people, just now we do it on screens instead of paper or whatever back in the old days.

So, you moved on from learning all the things that you had to do—or maybe you haven’t moved on from just learning whatever it was that you needed to learn in order to do your job, like maybe that’s kind of a constant state of things for front-end development. What sorts of things have you worked on in the front-end at GitHub?

**Emily:** I joined to kind of focus on performance, and it turns out that a big part of that is getting the right monitoring in place. So, I’ve actually even worked on monitoring more than performance. And then in some cases that’s perf monitoring, but GitHub is very into… we’ve rolled our own tools for a lot of things, so we are lucky to have an infrastructure team who’s put together this very flexible metrics pipeline, and so we’ve started monitoring a lot of things that are other front-end things that we’re interested in. So, we do errors, we’ve done a little bit of accessibility monitoring, which has been pretty interesting, and then just always trying to drill more into our performance metrics beyond just the time to `window.load` stuff.

**Rebecca:** So, tell me more about accessibility monitoring. That’s not a thing I’ve heard of before and I don’t even quite know what that means.

**Emily:** It’s an interesting one. As far as I know, we’re the only people I’ve talked to that do it. This is something that two of my co-workers, [Josh](https://github.com/josh) and [Mu-An](https://github.com/muan) came up with, and it was actually something that was just sort of another layer on top of our JS error monitoring. So, whenever you went into a JS error on GitHub, we’ll send a little report back to the application, and then someone realized that we could just send different types of custom errors, like we could just trigger an error whenever something strange happens. So, if you run the website in staff mode, we have you download a couple of extra scripts, and we’ll just use those scripts to run some checks about… like, we’ll check the DOM. for different situations that we think of as accessibility problems. So, like form inputs that don’t have labels attached to them, or images that don’t have alt text. And then we just send a little report back to our JS error monitoring system and we can kind of just go through there and fix a bunch of accessibility issues at once.

**Rebecca:** So, you’re actually doing that sort of monitoring in real time in production. Can you tell me a little bit about how you decided to do that versus doing it as part of a build or release process?

**Emily:** Yeah, that’s a great question, and there’s actually a number of pretty good tools now for doing  accessibility testing. Like, there’s [capybara-accessible](https://github.com/casecommons/capybara-accessible), which is an extension that you can run as part of your [Capybara](https://github.com/jnicklas/capybara) suite. But I think the tricky thing is always getting the real variety that you have in your production data represented in your tests. So for a lot of this, like images without alt text might be—we render a lot of user content on-site, so users can drop images into issues or comments or things like that. So, the test suite runs against code that you know is there and that you know how it works, and so we kind of wanted the monitoring side of it to look at all the code that we forget about, that we haven’t maintained in a long time, or that might behave in different ways when users add content that we weren’t expecting.

I think ideally you’d want both together. Like, you’d want some tests to catch things before they go out, but then the monitoring helps you pick up all the little things that you haven’t looked at in a while that are on some part of the site that you forgot about.

**Rebecca:** Yeah, and I think we deal with this too with the work that we do at Bazaarvoice, that you can test and test and test but user-generated content will always find ways to do unexpected things, and GitHub is just another flavor of user-generated content, and so being able to understand how it works in the real world is something that you can’t really simulate for before you go to press, as it were.

Tell me a little bit about the error monitoring. I am interested to hear about that, especially after [I talked to the folks at Etsy recently](http://ttlpodcast.com/episodes/daniel-espeset-seth-walker-etsy.html) about that and the different strategies they’re using and some of the challenges they’ve run into. What’s the mechanism for monitoring JS errors? Are you looking at window.onerror or what are you doing?

**Emily:** We are. The client-side script is actually really simple. Like, we have one `window.onerror` listener and then we just collect context from the error object itself and we look at a couple of other things from the page. So, we grab the URL, we try to get the target for the event if the error was triggered by an event. So, we want to know if the user was clicking on a button or something like that. And then the only kind of things we have to calculate a little bit are time since the page loaded, because we want to know if it’s something that happens during the initial load process or maybe the user has been sitting on the page for three hours and we’ve deployed new JS since then or something. But that part is fairly simple.

I think the thing that has made it work really well for us is that we do the filtering in the Rails application, like the Github.com Rails application, so as we find errors that we know are not actionable, we just manually add a filter for them to the application.

**Rebecca:** Yeah, that was the next question I was going to ask because that was the thing that the folks at Etsy were mentioning, that there are so many errors that aren’t actionable that may come from a browser extension or just some other real outlier kind of condition, and being able to figure out which ones are real, which ones are ours, and so it sounds like that’s how you’re dealing with that.

**Emily:** The browser helps you a little bit because you can look for… we actually discard any error that has a local file or an extension file in the stack trace, because we just assume there’s enough people looking at the site, if it’s a real error that happens without a browser extension, we’ll also see it without the extension in this factory, so we just throw all those out and that helps clean it up a little bit. And then there’s always a couple of really common errors from extensions that we just have to dig into and figure out what they are and manually add a filter for.

**Rebecca:** And so what are you doing around monitoring for performance of the front-end application at GitHub? Is that something that you’re doing just looking at load times or are you looking at other things as well?

**Emily:** Load timing is a big one. We collect all the navigation timing metrics, because we use fairly strict content security policy settings. At first, it seemed like a little bit of a downside to me because it meant that we couldn’t use a lot of the really common third party tools—you know, some of them work by injecting stuff into the page—but it made the most sense to work with the native browser APIs for it. So, we do just collect all the navigation timing metrics and that’s a big part of the performance graphs that we look at day to day.

**Rebecca:** What about things like the behavior performance of the interface after that page load? So, if scrolling is smooth, for example.

**Emily:** That’s something that I’ve wanted better metrics on for a long time. That’s totally my white whale that I’ve been chasing. It’s my hope that with some of the frame timing API changes that are coming soon we’ll be able to actually instrument the rendering process itself and instrument animations to see whether they’re smooth or bumpy. Luckily GitHub doesn’t do a lot of really fancy animations or transitions or things like that, so for us it’s not quite as urgent to get that sort of tracking in. We’re mostly interested in tracking shorter term event performance and then [PJAX](https://github.com/defunkt/jquery-pjax) performance, which is like our not-quite-single-page app replacement.

**Rebecca:** So, tell me a little bit about that, the application, the actual client-side application at GitHub. It’s not a single page app. What is it? How is JS part of the GitHub experience?

**Emily:** You know, we’re really minimalist about JS in a way that I think so many other sites right now are not. I think the tagline that I hear around the office sometimes is, “Build websites like it’s 2004,” like everything is very kind of old-school HTML page request-response standard browser navigation, so we don’t do Angular, Ember, Backbone, anything like that. The one small thing that we do to speed up navigation within the site is we use a jQuery plugin actually, called PJAX, which will just replace an area of the page that’s changed as opposed to do a full page refresh. But that’s really it.

**Rebecca:** And then even that is still pulling in HTML, not pulling in data that then gets rendered client-side?

**Emily:** Yeah, absolutely. It’s all still standard server-rendered HTML. Under the hood, it’s a very normal Rails app, it’s just a very large one.

**Rebecca:** Do you see benefits to taking that approach?

**Emily:** There’s two big benefits. One is that we have so many people all over the company who commit code to GitHub that are maybe not front-end experts, or in some cases they’re not even developers day to day. We have probably about 100 people on the engineering team, and probably more than half of those will commit code to GitHub.com, the kind of core application, at some point. But then within the rest of the company, probably like 200 people in the company have made a change to GitHub.com. So, not having the overhead of having to learn a new JS framework to change something on the front-end has been pretty helpful, that’s pretty great.

So, the other major benefit I see is that we’ve sort of… we’re conservative about adopting new technologies but we tend to be eager to follow new web standards. So, I think we’ve potentially done less pulling in new things and then taking them out than other companies have done. We sort of just follow behind the standard and then hopefully what we’ve built lasts a little bit longer.

**Rebecca:** That’s an interesting thing and I think it’s an interesting approach because I had a team come to me at work the other day and say, “We’re about to build this new tool and we want to know what client-side application framework we should use. Should we use Ember, should we use Angular…” and I was like, “How about none of the above? Why do you actually need a client-side JS app? Ya’ll are actually really great server-side developers and it would be okay to make this as a server-side app that doesn’t really have a lot of fancy JS added to it.” I think they were looking at me like, “Who are you…?” But I think that it’s still a really valid approach and I’m actually glad to hear that.

**Emily:** We definitely get a lot of looks at conferences and things like that when people ask us which framework we use, but it seems to be working so far.

**Rebecca:** Yeah, I mean it might not be the most fashionable thing to say, but I think it’s actually a good engineering decision to be able to say, “We don’t actually need anything fancy here.”

---

**Rebecca:** I want to pause here to thank [Sauce Labs](https://saucelabs.com) again for their support of the show. They brought front-end ops to the forefront with the Front End Ops Conference in 2014, and they continue to make it possible for us to have insight into how our applications work—or, you know, don’t work—across way more browsers and operating systems than you ever want to be responsible for maintaining yourself. If you haven’t checked them out, head over to the [TTL Podcast website](ttlpodcast.com) for a promo code, and then go visit them at SauceLabs.com.

---

So, I first ran into you—although we didn’t actually meet—I first ran into you at the Front-End Ops Conference out in San Francisco last year and you gave a talk about [everything is a polyfill](https://www.youtube.com/watch?v=3mXH95lA-FQ). There were some interesting things in that and people should go watch it. I actually wrote down some notes when I was looking at it today for things that we should go back and do. But one of the most interesting things that you said in that was that you think it could actually be detrimental for there to be a separate team focused on a thing like performance, and I wanted to just dig into that a little bit more because right now I’m in the process of creating a team that’s focused on performance and front-end ops, and at the same time I kind of saw your point, that you think that can make kind of an adversarial thing. So, I was wondering, can you talk a little bit about that?

**Emily:** I go back forth on this one honestly, because I think the danger with having a separate team is that you can end up with people who are performance janitors, like everyone makes all these decisions in the application and then there’s this team of people that comes by quietly the next week and cleans up the code and makes it work. And I think it’s so hard to actually get good performance in many organizations if you work that way, because so many fundamental decisions have been made before you get there and you get to think about it, and so it can be very hard to have a performance goal that you meet and a totally separate team working on it.

**Rebecca:** If you’re going to keep performance within a team, what are some of the strategies that a team can take to actually prioritize for performance?

**Emily:** One of the nicest things I’ve seen is teams that focus on evangelizing as part of their work—Etsy honestly does the best job of this. There’s a bunch of great conference talks, [Lara Hogan](http://larahogan.me/) in particular has some great talks on how to evangelize performance to the rest of your organization so that the performance team is kind of partnering with these other teams in the company that are producing the code, so that rather the performance team being these separate people who clean up after you, they’re there to consult with you and help you make decisions up front and are there to celebrate your wins when you improve performance rather than being a team on top of you who looks at graphs you don’t look at.

**Rebecca:** What is the story at GitHub around performance? What’s the culture around performance and around ensuring good performance?

**Emily:** GitHub is actually the most performance-minded organization I’ve ever worked in, to the point that it surprises me every day. Almost every engineer here is always really excited to think about performance, people will go back in and just clean up little performance problems they see in their spare time. I’m coming from—I worked at an e-commerce company, I worked at a bank, so this is very new and exciting for me.

**Rebecca:** Do you have tools in place around your release process or your commit process, or just your workflow in general to make sure that you aren’t damaging performance?

**Emily:** You know, we don’t do as much performance budgeting or performance testing as part as our test suite as some companies. I would like to do more of that but we just haven’t set that up yet. One thing we do well is we do a lot of monitoring of the build process, the pre-release process—like part of front-end CI is we’ll do a check to see how many DOM nodes are on common pages and we’ll do checks around finding unused HTML and CSS. So, we do find certain things with some pre-release checks like that, but most of it for us is monitoring after deployment, so there’s alerts that will go off if certain performance metrics start to climb above certain thresholds.

**Rebecca:** And ya’ll deploy really often, if I’m recalling correctly. I remember speaking with someone, I can’t remember who, about your deployment process.

**Emily:** We do. You can go from writing a commit in your editor to having it deployed on the site in about five minutes on a good day, which is also terrifying to me as someone who’s coming from a weekly release process. [laughs]

**Rebecca:** What sort of… and maybe this is a moot point because you aren’t doing much JS in the client, but what sort of testing are you doing of the front-end experience as part of that process?

**Emily:** You know, I think we are able to get off a little bit light on the front-end testing because we have so little JS. Our browser support strategy for older browsers is to not serve them JS at all, so we try to make sure that most of the site works with JS disabled, and so JS is sort of used to add the icing on the cake. So, sometimes if you have a JS problem, it won’t get in the way of you using the rest of the site, which is nice. So, we’re able to not do quite as much browser testing as some companies—we do a little bit of that, but we mostly rely on the monitoring in cases where some companies might rely on having a full test suite or a QA team.

**Rebecca:** So, before we started recording we were talking a little bit about front-end ops and just the emergence of that term, and I wanted to talk some more on the air about that, just about what you’re seeing and what your experience has been around front-end ops as a career path, basically.

**Emily:** I think I had the same moment that a lot of people had, where I read Alex Sexton’s blog post and I got so excited and I was like, “Oh, that’s me! That’s what I work on! That’s all this important stuff that I work on that I can’t get my organization to recognize that is important, or there’s no meetup group to go to to talk about this stuff…” Like a handful of other people who had been doing front-end development for a long time, I read that post and I got really excited. And so on the one hand it’s so great to see recognition coming for this kind of work, but on the other hand I worry a lot about forking another group off of front-end development, which has been such a diverse group of people who have come from so many different backgrounds—like, it’s adjacent to marketing, it’s adjacent to back-end development—and I worry that with this new label, will we take some of those people with us, will we keep some of that diversity?

**Rebecca:** Yeah, it’s an interesting thing and I think we’re seeing that not just with front-end ops vs. front-end development, but even with JS development vs. CSS development there’s been fracturing there in the last couple of years I think, where people are going in different directions. And yeah, I think that’s a good point, because on the one hand I think that this work—or this term—is really legitimizing the work that we do, like, “No, really, this is actual engineering that we’re doing,” and so it’s lent a lot of credibility to the work that we do and the work that we’ve always been doing.

But on the other hand, yeah, I think that some people find this really intimidating, and if you read the comments on Alex’s post even, you’ll see people saying, “Oh god, I don’t want that to be my job! That’s not the direction that I want to go.” So, I think it’s going to be an interesting thing.

**Emily:** Can I ask if you feel like the name, like what we call it in the end, is going to be very important to where people land?

**Rebecca:** Oh, I think so. I think it will, and I think this term, “ops,” has a connotation to it, that on the one hand it has this connotation of legitimacy, and on the other hand it has this connotation of, for lack of a better term, “the IT guy” connotation. [laughs] So yeah, I’m glad that it has a name. I will be interested to see what impact that name has on how people gravitate toward or away from this role. Part of the reason that I wanted to even start this little podcast project was to create a place to talk about “What is this? What is this really? Is it scary? Is it geeky? Is it fun? Is it interesting? Is it hard?”

**Emily:** [laughs] Definitely that.

**Rebecca:** Because I don’t think that there’s a lot of good content out there yet around what this actually is. There’s this name, but other than Alex’s blog post, there’s not a whole lot more to kind of characterize what this actually is and what the problems are.

**Emily:** Etsy’s team uses the term “front-end infrastructure,” and for some reason that feels a little more neutral to me. I kind of hope that’ll be the term that wins in the end just because infrastructure just sounds so… like, it could be anything.

**Rebecca:** Yeah. I think it remains to be seen. It’s a term of art that the people who are already doing it… they understand what it means. But I don’t know that it’s a term of art that people who haven’t been doing it really get a lot of meaning out of it yet. On the other hand, Alex has quite a track record of naming things, and some things are just waiting to be named, and then when they are that name sticks and we’ll see what the consequences of that are. To be determined…

When I was listening to your front-end ops talk, I also heard you mention that you were using [Sprockets](https://github.com/sstephenson/sprockets) to actually do the building of the front-end resources. I’m curious, are you still doing that? And how’s that working out?

**Emily:** We are still using Sprockets. I am very lucky to be able to work with Josh Peek, who is a frequent contributor to Sprockets. And so, we use Sprockets… it made sense for us, like we’ve been able to kind of work with Sprockets and make it work with GitHub over the long term. I don’t know too much about it personally. Like, for me, it works in a way that’s fairly simple compared to other dependency management tools I’ve worked with, and it gets the job done and there are people on my team who know a lot about it, so that’s all very nice.

**Rebecca:** Well, and I wonder too: it seems like a thing that could be really, really great for the kind of JS that you’re writing, where it’s not—you’re not writing huge single-page apps, I think then Sprockets might be kind of disastrous. But you’re writing very targeted JS; JS that’s small and targeted at a single component, and then Sprockets rolls all that up for you.

**Emily:** I do think it fits our development process—especially, we tend to not have incredibly complicated dependency graphs for our JS. We write [CoffeeScript](http://coffeescript.org/), it’s mostly fairly small files. I think Sprockets is the right amount of tool for the job to kind of put those together in the right order.

**Rebecca:** I forgot that you use CoffeeScript. Right… How’s that? Is that a thing that you think is going to stick around at GitHub? Are you pretty committed to that at this point, or is there interest in going the ES6 route?

**Emily:** You know, I think there’s an interest in both, honestly. People like Coffeescript a lot here, there’s very wide CoffeeScript adoption in the company, sometimes for the bad reason that it looks like Ruby and so people find it natural to kind of jump back and forth, and then you see all this JS that’s written like it’s Ruby and you’re like, “Ahh…” and a little concerned. But I also think some of the things that people really like about CoffeeScript have made it into the most recent versions of ECMAScript. So, I think people here are always kind of developing with an eye toward what the next standard will be, but CoffeeScript does seem to be a pretty good fit for us in the meantime. And it goes well with Sprockets because it wraps each of your files in a anonymous function, so you can’t do that thing that Daniel Espeset was talking about on one of the last podcasts, where you have half of a file one place and then you include the other half someplace else.

**Rebecca:** [laughs] Right, I hadn’t even… when he said that, I just… I can’t even imagine being in a world where that’s possible. So, good that that’s not happening to you. I guess CoffeeScript does give you that security, at least. I wrote a project in CoffeeScript a couple years ago now, before I started at Bazaarvoice, and I found it really pleasant once I got the hang of it. So, I’m not a CoffeeScript hater, but I do think that the rationale for it is probably going to go away. But I guess that remains to be seen.

**Emily:** Yeah, I wouldn’t be surprised. I think the bump that people often run into is that they want it to be an abstraction layer for JS and it’s not an abstraction layer for JS at all. You can just shoot yourself in the foot in more ways. It just lets you kind of type fewer characters. It seems like with the later versions of ECMAScript that’s getting a lot better, so maybe it will start to fade off into the sunset.

**Rebecca:** I still haven’t gotten to work on a project using ES6. We have a team who’s working on one and that is pretty exciting, but I personally haven’t gotten to. But I’m hoping soon I can dip my toes into that a little bit more.

**Emily:** Nice.

**Rebecca:** So, speaking of things that are new and things that are changing, you’ve been doing this web thing for more than a few years it sounds like: what do you think is going to be better in three years that kind of sucks right now?

**Emily:** My hope is that tracking all these performance metrics that are not time to `window.load` is going to be better. I’m a little bit cautiously optimistic about that, because we’ve been saying that for a while now. Like two years ago Steve Souders put out [a blog post about how time to `window.load` was not the most important metric anymore](http://www.stevesouders.com/blog/2013/05/13/moving-beyond-window-onload/) and then we still just all track time to `window.load`. But with things like frame timing, and with more people, more tools supporting user timing, I’m hoping that people will start collecting more performance metrics that are specific to their site and also they’ll have better visibility into how the page is performing after load.

**Rebecca:** Yeah, the after load piece is really interesting, and right now you’re kind of on your own to instrument that. Like we were talking about earlier with stuff like scrolling, being able to understand how that’s working—the pieces are there but there isn’t really a cohesive story yet for being able to understand that.

**Emily:** It’s really hard to find examples or find other people’s numbers to compare to. You really just have to kind of record it and look at it, and then look at it again in a month.

**Rebecca:** [laughs] “Have you gotten better, or have you gotten worse?”

Well Emily, thank you so much for coming onto the show today. I’ve had a lot of fun finally getting to talk to you and I hope to bump into you in real life some time soon.

**Emily:** Yeah, thanks so much for chatting. This was great.

---

The TTL podcast is edited by Morgan Murphey. Website design by Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a special thanks also to Bazaarvoice. For music and other credits, visit TTLpodcast.com. I’m Rebecca Murphey. See ya next time.
