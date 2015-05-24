**Rebecca Murphey:** Alright, don’t hang up. [laughs] Uh… But we can—we can stop recording now, so…

---

Hello. I’m Rebecca Murphey, and this is the TTL podcast.

The TTL podcast is brought to you by the fantastic folks at [Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform that makes it possible to test your app across browsers as part of your continuous integration or continuous delivery workflow. Plus, they give you manual access to more than 500 browser-platform combinations. Try it for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo code.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and deploy with confidence. Sync your GitHub projects with Travis CI and you’ll be testing your code in minutes. Travis CI is offering a free trial to the first ten listeners of this episode who sign up with the promo code on [ttlpodcast.com](http://ttlpodcast.com).

---

**Rebecca:** Hello and welcome to the TTL podcast. Today on the show we have [Dan Lee](http://danielericlee.flavors.me/). Dan is a member of the front-end team at Yammer, and he and I are going to talk about migrating a legacy front-end codebase to use dependency management.

Hi, Dan.

**Dan Lee:** Hey, Rebecca. How’s it going?

**Rebecca:** It’s going great. Thanks for coming on the show today. I appreciate it.

**Dan:** You’re very welcome. Yeah, no problem.

**Rebecca:** I feel like I have run into you, come across you like several times over the past many years. Like, we used to be in North Carolina at the same time, right?

**Dan:** That’s right, we were. Yeah, so we’ve run into each other at the [Triangle JavaScript](http://www.meetup.com/Triangle-JavaScript/) meetup, places like that.

**Rebecca:** Back in the day. And you were also at [DojoConf](http://lanyrd.com/2011/dojoconf/) in 2011…? I don’t even remember.

**Dan:** Yeah, I think that’s right. Yeah, that’s definitely right.

**Rebecca:** So, I feel like I’ve been aware of you for some time. And then I ran into you again at [Front End Ops Conf](http://www.feopsconf.com/) last year out in San Francisco, and that’s why I wanted to have you on the show today, was to talk some about what you talked about back then and kind of get an update of how all that’s going.

But before we do that, let’s talk a little bit about—you work at [Yammer](https://www.yammer.com/) and you’re a software engineer there. Tell me a little bit about what you do at Yammer, and about your time.

**Dan:** So, I am an engineer on what Yammer calls its front-end team. So, the front-end team is basically the stewards for all of the HTML, CSS, and JavaScript on Yammer.com. So, there’s 11 of us here in the San Francisco office, and then there’s 6 more in the London office. Our duties are everything front-end related for Yammer.com. We also maintain our third-party JS SDK and a thing called Embed, which is an SDK for embedding a feed somewhere else. So, that’s kind of our domain. But mainly we’re focused on Yammer.com and everything front-end related.

**Rebecca:** What sort of technologies are you using on the client-side for Yammer.com?

**Dan:** For better or worse, Yammer’s front-end architecture is mostly JS. So, the majority of our stuff is kind of written in the style where we’re going to get JSON back from the server and then kind of take over and render JS components. So, that’s kind of the general flavor of our stuff.

As far as what we use that people have heard about, I can kind of tell the quick story of—in 2008, when we started writing JS for Yammer, we wrote our own MVC JS framework, as I’m sure a lot of people did.

**Rebecca:** Yes, as one does… [laughs]

**Dan:** As one does, in 2008. You don’t really have tools like that available, and you have a lot of smart JS folks on your team, and it’s a cool thing to do, you know? Let’s get proper MVC in our stuff and let’s build our own thing. So, we still have remnants of that framework in our stuff, but we’ve kind of moved on to more established third-party open source things where appropriate.

So, to give you an example: all of our UI components, our views, are based on [Backbone](http://backbonejs.org/). So, we’ve written a quick little thing on top of Backbone that gives us parent/child relationships for views and some other goodies, and our UI components are based on that. Inside those views, we also mix in [jQuery](http://jquery.com/), and [Underscore](http://underscorejs.org/), and [Mustache](https://github.com/janl/mustache.js/), and a few other things. But yeah, that’s kind of the general complexion of our stuff.

**Rebecca:** How was it to transition to the more 2014/2015 tools from that “roll your own” framework?

**Dan:** Yeah, it’s very difficult. It’s tough. Because sort of the thing is—and this is kind of the backdrop of everything we do here—is that we kind of move fast and we deploy all the time. So, we’re not set up to kind of go away and have these long-running branches that then we can just merge and pray that they work out okay.

We do everything in small pieces and in an iterative-type fashion. So, introducing a new thing like that Backbone view has to be done piecemeal. We have to set it up so that we land that code and then migrate one component, and set up the code so that it’s possible to live with the new stuff and the old stuff at the same time, and have this plan for transitioning the old to the new gradually.

**Rebecca:** And is that transition done now? Have you made it? Have you arrived?

**Dan:** Um, no. [laughs] And I think that’s okay, you know? That’s kind of present in all of our stuff. It’s almost unheard of to move everything over to the new thing, right? So, we always have this current best practice of, if you’re writing a new component, this is how it’s done, and the team is well aware of it, and we’re happy with it, and all of that.

At the same time, you’re going to have some components off in this little-used part of the app that we haven’t touched in a long time. And we don’t tend to make big efforts to just port all of that stuff over just to do it. So, our codebase is always going to have some remnants of older not-so-best-practice-anymore stuff in it, and that’s just kind of how it is.

**Rebecca:** How do you decide, for an existing component, whether it’s worth the effort to port it over to the new system? Is it just when you’re touching it for something else? How do you make that decision?

**Dan:** Yeah, that’s part of it. That’s the typical kind of place/opportunity to do that. So, if we’re doing a project that’s touching this one area of the code and the code is kind of old and gnarly, and it’s going to make it painful to add this new feature to it, we go ahead and move that stuff over. Like, we’ll take the time and talk about it with our product teams, like hey, we’re going to need a couple of weeks to port this thing over because it’s old, and nasty, and it’s got no tests. That definitely happens.

In other cases, we’ll sort of identify that this is a mission critical part of the code, or this code has gotten so stale that we need to have a focused project to move this thing over. And that sort of happens outside of project development, and we’ll kind of negotiate to get time to do that and move that stuff forward. So, those are kind of the two ways things get converted.

**Rebecca:** You mentioned, before we started talking just now, that Yammer’s teams are structured around features and that they coalesce and disband around as features come and go. Can you talk a little bit more about that, and just how you’re organized, and just how front-end fits into that at Yammer?

**Dan:** Sure. So, Yammer goes really big on cross-functional teams. Just about everything we do originates from our product team, so our product team kind of drives direction of the product, and projects kind of get spun out of that organization. And so to build them, we’ll spin up what we call a cross-functional team, and depending on what flavor the project is, we might add one or two front-end folks and one or two back-end folks. We just kind of make an estimate as to what we’ll need for that project. And then those teams work together, focused solely on that project until it ships, and then that team kind of disbands and people go off and work on other things.

**Rebecca:** Is this something that happens over weeks, or months? What’s the timescale for that?

**Dan:** It’s one of those things where we try to get things done as fast as possible, of course. So, the project scopes that we tend to like are two to five weeks.

**Rebecca:** Oh, wow. So, a team might coalesce and disband in a pretty short period of time?

**Dan:** They might, yeah. Usually that kind of timeline gets pushed a bit as things happen. But yeah, we try pretty hard to kind of split projects into chunks that are digestible in that short of time.

**Rebecca:** That’s really cool. So, going back to what we were talking about at the beginning, about the work that you’ve done to use some more modern best practices for your codebase: the thing that you [talked about](https://www.youtube.com/watch?v=y-G7v5wpx2k) at Front End Ops was actually migrating your codebase to be more modular and to have the dependencies actually expressed in the code. I really wanted to have you on the show just because that’s the dream, right? I mean, so many people out there are working, I’m sure, with codebases that were written in the late 2000s when there wasn’t a clear answer on how to do that. And now these codebases have grown and managing this via some manual process has just become untenable.

I was at your talk in San Francisco, but can you just kind of give me a recap of that for people who maybe haven’t seen it or weren’t there? What the problem was, and how you set out to solve it. And then I want to hear how it worked out a year later.

**Dan:** I’ll kind of tell that story in a quick fashion.

**Rebecca:** It was a 40-minute talk, right? So… [laughs] I’ll give you two.

**Dan:** It was a 40-minute talk, yeah. [laughs] So, I’ll try to condense it. Yeah, so basically the story is we started writing JS in 2008. At that time, there weren’t really best practices for modules, and dependency management, and things like that; things were just starting to emerge there.

Basically, how our JS was set up was on a global namespace—ours is called Yam—and everyone had their own top-level global, and that was the thing back then. Then how our scripts were loaded, the order of them was just kind of specified by a JSON file that was called build.json. It just kind of listed these files in order, and the order mattered because of dependencies. So, that’s how our code was set up from 2008 to about 2011. For the early part of those years, that strategy worked fine. If you don’t have a ton of code and you don’t have a ton of dependencies, you don’t gain a whole lot by having first-class dependency management set up.

But as the thing grows, you kind of reach a point where, yeah, we’re running into problems, globals are colliding, and the order is getting thorny, and dependencies aren’t clear. So, I’m just kind of in that JSON file, shuffling things around until it works, and that’s not a good place to be. So, the talk was about how we gradually move from that style to a style of formal dependency management and formal modules using [RequireJS](http://requirejs.org/).

**Rebecca:** So, I knew you from the [Dojo](https://dojotoolkit.org/) world, and Dojo had some pretty clear patterns around expressing dependencies. How was it to show up to Yammer and be confronted with that? And what was the process for convincing people that this needed to be done?

**Dan:** Yeah, that’s a good question. I think at that time—Dojo was way ahead of the game, which it was in so many ways, right? So, Dojo had `dojo.provide` and `dojo.declare`, and just constructs like that in it. As I left IBM and saw other people’s codebases, I just found that this was not there, and it was like well, you know, it’s okay…

But even when I joined in 2011, people were saying, “Oh, we need a script loader. We need dependency management,” it was already kind of apparent. It was just such a daunting thing. It almost became like this running joke, like, “Yeah, we’ll have that someday…” It was in the hearts and minds of our developers that this was never going to happen, and it wasn’t even really cool to talk about it, because… That dynamic is not good, but it’s probably present on a lot of software teams. There’s stuff that you really want to do, but you’re like, “Are we going to get that done? Probably not…” So, you kind of don’t talk about it.

It was something that we talked about for a long time. My co-worker Chris and I just kind of had this opportunity in the December timeframe when things were a little quiet. We started brainstorming and we were like, “We can do this,” and we kind of came up with an idea of how we can get this wedged in in a little iterative way and provide the framework for growing that to our entire codebase. And we got it done.

**Rebecca:** What did you end up using for that?

**Dan:** Yeah, so we went with RequireJS and AMD modules, and the decision for that wasn’t too scientific. Chris had some success in it using that toolset in other projects. We also sort of had, in our code, APIs that were similar, so we already had this Yam.define thing that did a pseudo-module thing, so the AMD constructs lined up really nice with that, so that provided more incentive to go that way. But we didn’t do a week-long bakeoff of different module tech or anything. We were just like, “Oh yeah, we can do this, this will work, let’s go,” and that’s what we did.

**Rebecca:** So, it sounds like there wasn’t really a whole lot of politics to negotiate around this. Like, everyone knew that it was a thing that you needed and that they wanted.

**Dan:** Yeah.

**Rebecca:** What was the process for actually putting this in place? Because, like you were talking about, you can’t just go away for a few months and make a big change like this. So, what was the process for putting this in place, a little bit at a time?

**Dan:** Are you curious more about how we decided as a team that it was okay? Or do you want to know more about the engineering required to kind of get it done?

**Rebecca:** I’m more interested in, literally, how did you do this a little bit at a time from an engineering standpoint? Because I think a lot of people see this and they’re like, “If I don’t change my entire codebase, it’s all or nothing…” and I think the point of your talk was that it’s not all or nothing, that you can do it a little bit at a time. So yeah, can you talk a little bit about that?

**Dan:** Sure. Yeah, so I think the key insight—and JS helped us out here by being fast and loose—is that we had to create this world where our new AMD modules could run in our old environment as well. We designed a system where we actually leveraged our A/B testing system for this as well. So, we designed this world where if this A/B test was on, we would put RequireJS on the page and run the things as AMD modules. But if that thing was off, it would just kind of work as normal using the build.json manifest and all the other stuff I was talking about.

So, that was kind of the key insight, and we did that just by—in the old world—just kind shimming out the Require APIs, which was kind of gross; we would just shim out these globals. But it worked, and it provided this technique where we could convert these modules one at a time, merge them into master and deploy them, everything still works, and then we can turn on that experiment flag and just say, “Okay, let’s let QA run through these and make sure they’re still working.” So, we set up this world where we could kind of gradually move all of these modules over to the new thing without breaking anything, and doing it kind of piecemeal.

**Rebecca:** So, really you were just giving `require` a different definition depending on whether you were A or B.

**Dan:** That’s right. And in the A world, in the old world, it basically was a no-op. We just kind of shimmed these things out to do just about nothing and still use the build.json to just concat all of that JS and it still worked, it just kind of had this wrapper thing around it that did nothing. Basically, the defined shim just said okay, run that function—like, the factory function that gets passed in the define in the control world, in the old world we would just run it, and in the experiment world we would actually have RequireJS do its thing.

**Rebecca:** Looking back on that, is there stuff that you did wrong or wished you had thought of back at the beginning of that process?

**Dan:** That’s a good question. I don’t know, it actually worked out pretty well. It was tough, and we run into this in our code whenever we’re trying to move forward with it, where we have to create this “two-world syndrome” we call it, where it’s got the old stuff in it and the new stuff, and there’s maybe this little shim thing that’s making both work. And it just kind of agitates the engineers as a team; it’s like, “Oh, we don’t want that old stuff in there anymore.” So, it’s always challenging to set up your code.

As an engineer, you want one thing, right? You say, okay, the system is defined as this. If the system is defined as this, and this, with this glue in between, it’s like “ugh, that doesn’t feel right.” But if it enables you to get that stuff out there and move that code forward… We’ve found it’s well worth it. It’s the nature of doing things like that.

**Rebecca:** In the interim, I can imagine that you might’ve taken a file size hit while you’re maintaining these two different systems. Or did the A/B testing approach help you avoid that?

**Dan:** It does happen. We tend to not worry about it too much. Like, we ship a pretty big gob of JS, so this is kind of like—you’re right, there is kind of some file size downloading and parsing things to worry about there, but we tend not to worry too much about that going forward. We’ll kind of sanity test it and make sure it’s not taking a huge perf hit or something like that. But for the most part, we use that technique, and often times we’ll ship little pieces of duplication and not have it be too big of a deal.

**Rebecca:** So, it’s been a year and some change since you gave that talk and since you talked about this. Where are you now? How has this worked out?

**Dan:** It’s worked out *pretty* well. One of the things that we kind of realized after doing this project is that it really wasn’t too important which tech we picked or whatever to get this modularity and dependency management thing done. The benefits are the dependency management, right? And so, we’ve been able to migrate the vast majority of our Yammer.com components over to AMD RequireJS things. I think we still have *a little* bit of code kind of set up init-type code that isn’t dependency managed, but the vast, vast, *vast* majority is, and what that allows us to do is not have this two-world syndrome anymore.

So, we can do things, like recently we’ve kind of mixed in RequireJS helpers to let our JS components specify their own CSS and their own HTML templates, which is like the holy grail for JS components. If you’re building a new app, you’re just kind of like, oh yeah, well, that’s just how things work. No, if your code is five, six, seven, eight years old, it’s a challenge to get your components to that level of specifying their own dependencies. So, we’ve been able to introduce things like that, so now if you write a new component in our stuff, you have all of that. You can specify a template externally and write your CSS just for that component, and have your JS just kind of add dependencies on all those things. So, we’ve been able to introduce constructs like that, that we’ve wanted forever, because of this early work and that’s been really good.

**Rebecca:** You said that just writing new components, there’s a much better story and a much clearer story now there, yeah?

**Dan:** Yeah. It’s *so* much better. It feels really good just to write a component and just specify all of its dependencies. For a while there, we’d still have some globals kicking around. Like, the last thing we did was move our core modules over. So, these are things like string manipulation and internationalization—stuff that every module needs. We’ve moved that stuff over to be first class modules, and now so when you’re writing a new component, there are no globals. It’s just here’s my component, here are its dependencies, and it just feels really good.

**Rebecca:** Do you still have the `Yam` namespace in the global `window`, or have you moved away from that, even?

**Dan:** We still have it, so there’s still a few places—like, during app bootup and stuff, we need a global here or there. I think there’s probably still some components that are needlessly putting themselves on the global namespace that haven’t been cleaned up yet, stuff like that. But all new stuff does not decorate `Yam`.

---

**Rebecca:** I want to pause here to thank [Sauce Labs](https://saucelabs.com) again for their support of the show. They brought front-end ops to the forefront with the Front End Ops Conference in 2014, and they continue to make it possible for us to have insight into how our applications work—or, you know, don’t work—across way more browsers and operating systems than you ever want to be responsible for maintaining yourself. If you haven’t checked them out, head over to the [TTL Podcast website](ttlpodcast.com) for a promo code, and then go visit them at SauceLabs.com.

---

**Rebecca:** And we’re back. So, let’s talk a little bit about what you are up to these days. It sounds like that project kept you busy for a while, but what’s Yammer up to these days in the front-end ops world?

**Dan:** We have sort of a big initiative going on now to move stuff away from our legacy Ruby on Rails application that’s kind of in the front-end domain. So, we still have a bunch of Ruby on Rails ERBs that are rendering HTML and just returning it, and then we take over with the JS. We have a big goal of lessening our dependencies on that Rails application, so we’re doing a lot of work to extract that stuff and make it first class JS components, and put tests on it, and things like that. So, that’s kind of exciting.

We’re also finally making some big progress with our CSS. So, our CSS is kind of the same story as our JS. It’s as old as 2008 and it just kind of has been added on organically over time. And so, of course we didn’t have any preprocessing [Sass](http://sass-lang.com/)-type things in 2008, and we face the same focus of well, how do we introduce this stuff in a piecemeal kind of way that we can deploy all the time? So, we’re working on that a lot.

**Rebecca:** What are you doing in the CSS land? What are you doing to get an eight-year-old codebase under control?

**Dan:** Yeah, it’s actually super exciting because stuff is happening right now. We’re basically taking another piecemeal approach. We’re using this thing called [Rework](https://github.com/reworkcss/rework), which is one of the cool Sass-type tools, and we’re taking the strategy of saying okay, well we don’t want to use all the features that these preprocessors provide. We want to say okay, let’s use variables. Variables in CSS is a no-brainer, we want those.

So, we’ve introduced some glue code in our build process to understand the new CSS variable spec, and one of the things that we’ve done recently is look at all the colors in our codebase—and let me tell you, there was a lot of different colors—so, we’ve been working with our design team to finally standardize color palette. So now, in one fell swoop, all those colors went away and they were replaced with this set of 20 or so color variables, and so now when we’re building new stuff, we can use these variables and it just feels great. So, it’s early days, and we’re finally doing this stuff and we have to think a lot about okay, how do we do this and still be able deploy every day and all of that. But it’s exciting to see that stuff land.

**Rebecca:** When you are doing things like that, are you also putting in place linting tools to make sure that no one ever adds another color ever again…?

**Dan:** Yeah, yeah. So, we run a linter as part of a pre-push hook, and so we have JS linting and CSS linting. I don’t know if we’ve written a lint task to look out for people adding `color:#somenumber`, but we should.

**Rebecca:** [laughs] Add that to your to-do list when we get off this call.

So, you’re making this evermore complex client-side JS application—what are you doing to understand how it’s performing for real users?

**Dan:** Yeah, so we have a handful of things. We have sort of a homegrown performance monitoring thing that measures how long it takes to render a feed. So, we kind of have these core domain-specific performance metrics, and the most important one is just how long does it take to render a feed. So, we have a thing that if you’re in the browsers that support the window performance API set of APIs, then we go ahead and log that stuff and we plug that into our data collection stuff to have pretty charts and monitoring of feed performance.

We also collect JS exceptions through this tool called [Sumo Logic](https://www.sumologic.com/). So, we look at those and file tickets and figure out where we’re getting exceptions—usually in Internet Explorer, right? Those are the two major things we use.

We also have tons of performance and exception monitoring for our back-end stuff. So, for our Rail stuff and our Java services, we have really good data as to how things are looking across all of that. But for front-end, we have some very domain-specific performance metric monitoring and JS exception monitoring.

**Rebecca:** What about the third-party applications that you maintain? You said there’s Yammer.com, but then there’s also embed.js, and you mentioned another one as well. Those are living on other people’s pages. Do you have different pieces in place to understand how those are working and performing?

**Dan:** We sort of do. The thing that’s nice about that third-party component is that it’s kind of comprised of the same code. So, there’s a few little paths that are different, but we get the same performance monitoring and we can decorate it in a way that we know okay, this is Embed rendering here as opposed to something else rendering. We don’t have a ton of stuff built around monitoring in the front-end for Embed, but we have a little bit.

**Rebecca:** On the testing front, I’m really curious about this, especially as you’re adopting good practices around the writing of code, such as having modules and dependency management—what are you doing, on the testing front, to make sure that the code that you’re writing is not just well-engineered but also works?

**Dan:** This is kind of the same ’ol song. Like in 2008-2009, that era, people writing for tests in JS… Maybe some people were; some people were starting to write test frameworks that were Ruby-like. So, there wasn’t a ton of JS tests. We had a few developers that were philosophically more in line with test-driven development and they were writing tests for JS. But they were kind of off on the side, just telling everyone else to do it, and everyone was kind of “Yeah, okay…”

But as time has gone by, we’ve gotten a lot better in that area as well. So, we have a JS unit test suite with over 6,000 unit tests in it; it’s based on [Jasmine](http://jasmine.github.io/). We have a little [Grunt](http://gruntjs.com/) test that you can run to run the test through Phantom just to do a headless check of how the tests are doing. We have a test to run the test in the browser, and we also use a combination of [Jenkins](https://jenkins-ci.org/) and Sauce Labs to run our tests through the various web browsers that we support. So that, in a nutshell, is our front-end testing story.

**Rebecca:** The reason that I wanted to talk to you today is because you’re kind of living the dream, right? You showed up at this place where stuff was not in a good state—for a very good reason, like it was no one’s fault that it was in the bad state—but you showed up at this place where stuff wasn’t in a good state, and you have, I’m sure singlehandedly—

**Dan:** Oh yeah.

**Rebecca:** [laughs] Definitely, right?

**Dan:** Yeah, sure.

**Rebecca:** You’ve been able to change it and have been able to actually stick around to see the benefits of changing that. What advice do you have, for people who are showing up to a similar situation today, about how to be effective in changing these things and introducing these things?

**Dan:** You know, it’s weird that this stuff isn’t really talked about that much out in the community. Like, the focus is mostly on well, here’s the hot new library, here’s the best practices for the hot new thing; if you’re building something new go do it. But people don’t talk a lot about older codebases. And in older codebases, you’re never in love with the code. The best practices change from under you all the time.

So, I think that’s one of the reasons that the talk we did last year kind of resonated with a lot of folks, because they were like, “Yeah, that’s us, too. We have this big codebase and there’s parts of it we like, parts of it we really wish we could change.” I think it’s just sort of an interesting dynamic that the community doesn’t talk a lot about this stuff, and Yammer has kind of found its niche in the community, giving talks and stuff about how we’ve moved our codebase forward, which is kind of interesting.

**Rebecca:** Yeah, and I think it’s kind of like you said, how when you showed up, it was a thing that everyone knew they needed but no one really wanted to talk about it because it seemed so daunting and so difficult, and not just from a technical perspective. It sounds like it turns out that the technical side of it wasn’t so insurmountable. It was doable. But coming up with the political will to do it can be a challenge, I think. I asked before if there was anything that you would do differently, but what kind of overarching strategies can you say have really worked for you when it came to doing this?

**Dan:** I think there’s a couple of things. So, you need to find that strategy where you can do this thing not in this super-long lib branch and then merge and just hope everything works out. So that’s—at least for us, and probably for a lot of shops—that’s just not going to work. I think that’s probably the hardest part in this process, is if you’re trying to move some big thing forward, come up with that plan where you can do this safely and iteratively and all that good stuff, in a way that isn’t disruptive to your other teammates. Take some time and think about how you’re going to get that done, I think is sort of the biggest challenge.

There’s also challenges around well, we still have lots of features to build, we don’t have time for cleaning up this code. I think that’s an organizational problem. This happened in Yammer’s history. As we were kind of this hard-charging startup, we didn’t have the political pull, as engineers, to say, “Okay, we can’t build this new feature.” We couldn’t say no to that. But as the acquisition happened and things started to stabilize a bit, like the pace—we still moved pretty fast here at Yammer, we do daily deploys and we’re building new features all the time, but the pace is not frenetic anymore. Like, we take work/life balance seriously, we’re not trying to burn anyone out. So, as that dynamic has shifted, we’ve been able to get more serious about doing these projects that are cleaning up the codebase. Because the thing is, is that the product teams don’t want projects to stretch on and on because of legacy code. So, we’ve found that we can pretty effectively make a case for moving this thing forward before we build this other thing, and have gotten pretty convincing of that idea.

**Rebecca:** Have you been able to show that it is making your development faster, improving your quality, those sorts of things?

**Dan:** I think so. Just with our UI components, we used to regress them way, way more often. I don’t know if we’ve done any extensive data mining of our bug counts and things like that, but I just know anecdotally that our front-end is way more stable than it used to be, and this is a result of having this modular code and better tests and all of that stuff.

**Rebecca:** Well Dan, thank you *so* much for coming in and talking to me.

**Dan:** Oh, you’re welcome. Yeah, this was cool.

**Rebecca:** It’s a treat to get to catch up with you, even if it’s not in person. But hopefully I’ll bump into you in person sometime soon.

**Dan:** You probably will.

**Rebecca:** [laughs] Yeah, chances are… And in the meantime, I’m going to check in again with you about how this is all going, because like I said, you’re kind of living the dream here to me. So, thanks for sharing that story.

**Dan:** Oh, you’re very welcome.

**Rebecca:** Alright, have a good one. Bye!

---

The TTL podcast is edited by Morgan Murphey. Website design by Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a special thanks also to Bazaarvoice. For music and other credits, visit TTLpodcast.com. I’m Rebecca Murphey. See ya next time.
