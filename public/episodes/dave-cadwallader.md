## Transcript

*Transcription by Seth Lavelle.*

**Rebecca Murphey:** Imagine that you’re at a bar after work, and just, like, talking about this cool stuff that you work on. If you don’t drink, uh… I don’t know what the analog of that would be, but…

---

**Rebecca:** Hello. I’m Rebecca Murphey and this is the TTL podcast. The TTL podcast is sponsored by the fantastic folks at [Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform that makes it possible to test your app across browsers as part of your continuous integration or continuous delivery workflow. Plus, they give you manual access to more than 500 browser-platform combinations. Try it for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo code.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and deploy with confidence. Sync your GitHub projects with Travis CI and you’ll be testing your code in minutes. Travis CI is offering a free trial to the first ten listeners of this episode who sign up with the promo code on [ttlpodcast.com](http://ttlpodcast.com).

---

**Rebecca:** Hello and welcome to the TTL podcast. Today on the show we have [Dave Cadwallader](http://geekdave.com/), a software engineering manager for the core web team at [Walmart Labs](http://www.walmartlabs.com/).

Dave, thanks for being here.

**Dave Cadwallader:** Thanks Rebecca. Thanks for having me.

**Rebecca:** You’re welcome. I’m glad you could join us. It’s exciting; I know that Walmart Labs is doing lots of big things, so it’s exciting to get someone on the show.

So, we were talking a little bit before the show, and you were telling me a bit about how you kind of ended up in this place where you are working on front-end ops at a fairly large organization with fairly critical front-end needs. Can you tell me a little bit about that?

**Dave:** Yeah, it’s interesting, I feel like front-end developers have the most widely diverse backgrounds of any profession. I’ve met front-end developers that have started off just doing graphic design, or people like me, who started off doing more server-side back-end work.

**Rebecca:** Yeah, so you were actually a Java developer. Like, when people say, “Do you know Java?” you can say, “Yes!” Whereas I have to laugh at them.

**Dave:** [laughs] Yeah, I stopped short of getting all of those ridiculous certifications. But yeah, I can say that I had X number of years of J2EE experience.

**Rebecca:** [laughs] You were enterprise, I’m sure. So, how did you kind of make the transition to working on the front-end?

**Dave:** The CEO at my previous company was one for empowering employees to just sort of go and fix their own problems, and it was through noticing that we had a particular screen in our application that had just really terrible user experience, I asked if I could go do a roadshow with our customers and gather information about how our UI was serving their needs and how it was hindering, and I was actually given the green light to go do this, and I ended up redesigning a significant portion of our user interface. Shortly after that, I was given the invitation to actually lead our front-end development team. So, it was kind of unexpectedly dropped in my lap.

**Rebecca:** [laughs] Yeah, I guess so. And had you done much front-end work before then?

**Dave:** I had not done any front-end work before then.

**Rebecca:** You were just kind of annoyed by the interface and decided “I’m going to do this”?

**Dave:** Yeah. So, that was kind of my first experience with sort of this philosophy that evolved into front-end ops, where you see a problem, you see this friction, and you just go fix it because it’s annoying you every day.

**Rebecca:** And so you’re doing this full time now at Walmart Labs; you got invited to go do front-end development full time. What are some of the things that you’re focusing on at Walmart?

**Dave:** The biggest umbrella term is just automation. So, whether it’s testing or just developer processes, we’re trying to just remove as many friction points as possible to create the best developer ergonomics experience. We want our developers to be comfortable, and we want them to feel like their time is being used effectively and not wasted doing tedious things.

**Rebecca:** How many people do you have working on it there?

**Dave:** So, it’s interesting, our core web team has a lot of responsibilities. The front-end ops aspect of that is something that is still kind of a skunkworks project; it’s just a facet of what we do. We don’t have a certain number of people that are explicitly tied to doing front-end ops work, but we have a team of—right now—about eight people who all kind of share in this common mission.

**Rebecca:** So, you have these eight people working on this. How has the focus on front-end ops kind of evolved out of that? Is that self-led? Is that something the organization is pushing for? How is that happening?

**Dave:** It all started off with basically trying to get continuous integration working really well so that we could keep people from, for lack of a better term, “peeing in the pool.” We used to have a giant repository where we shared all of our code across all of the different “tracks,” as we call them—like, homepage, item page, checkout, all of these different areas of the website used to share one common repository. So, if somebody just forgot a semicolon, it would break [JSHint](http://jshint.com/), so this would cause everybody’s builds to fail.

So, we really needed to get something in place to verify every pull request, and that was kind of the first front-end ops-type work, was just getting a good internal continuous integration system set up.

**Rebecca:** That was the start of that effort. How has that evolved since then into more of a front-end ops focus?

**Dave:** It was kind of a trojan horse, actually. As I mentioned, when I was hired at Walmart Labs, I was not hired to do front-end ops work. I was actually hired as a track developer, working on the checkout page specifically. I was just doing this continuous integration work kind of on the side because I saw that it needed to be done.

So, the next piece of “sneaking” my own agenda into the picture was that we really had a big need for end-to-end testing in checkout. It’s probably arguably the most complicated piece of the puzzle on the front-end side at Walmart, especially with our new front-end redesign that we’re doing. It’s a single-page application that just encompasses a lot of different paths that a user can take. You can imagine, with all of the inventory that you can buy with something like Walmart, some items are eligible to pick up in the store, some items are actually illegal to ship to certain states. So, we really had a huge number of end-to-end scenarios that needed to be tested.

The problem with just relying on unit tests for a lot of these things is that a lot of the test cases are very data-dependent. What we really needed to do was be able to test all of these end-to-end experiences purely from the user’s point of view so that we could be sure that we were covering all of these cases adequately.

Among the things that we needed to test, in addition to different restrictions and different shipping options, was actually error cases. A lot of things happen unexpectedly that our UX team actually gave us very specific instructions for how we need to handle them. If an item is out of stock, if there’s some kind of unexpected server-side error and a customer can’t load their saved credit cards, we still need to be able to give them the option of manually entering a credit card. Some of these things were just very hard to do with unit tests. But with end-to-end tests, we could actually program our server in the background to simulate certain error cases and handle these solutions well.

**Rebecca:** With these end-to-end tests, are you running an instance of the application just configured to fail in a certain way or respond in a certain way?

**Dave:** When we talk about end-to-end tests, there’s kind of a continuum. I guess a “true” end-to-end test, from a purist’s point of view, might be a fully-deployed version of every single back-end service talking to your front-end, just as it is in production. At Walmart, just the scale of how many different systems we have makes that unfeasible for doing—especially in a development environment or a continuous integration environment that requires rapid turnaround.

So, in certain cases where the back-end is just too heavy to support that kind of quick turnaround, we actually make use of some mock servers that we maintain on the front-end ourselves, and they’re just some lightweight Node servers that we can spin up that talk to the front-end as if it were the full back-end stack. That allows us much greater control, especially for things like simulating error conditions so the tests can know exactly what to expect.

**Rebecca:** In that case, this is not necessarily like a full stack blackbox kind of test, but it’s really being able to test all the different scenarios that a user might encounter and how the front-end handles them. It’s not really testing how the back-end handles them, it’s really just testing them how the front-end handles them, but through an entire workflow.

**Dave:** Actually, the distinction I’d make there is that what we call our “factory floor tests,” where developers are rapidly issuing pull requests throughout the day and we really need quick turnarounds to give a build a green or a red status, that’s where we rely on these mocks. So, we do this to very quickly validate developer’s changes and very quickly identify code that’s causing a regression.

Once we’ve moved on to deploying a particular release candidate of our software into our QA staging environment, or when we’ve deployed into production, that’s where we run end-to-end tests, actually more in the pure sense of end-to-end, because we are testing the full stack. Those tests, of course, have different requirements for what servers they’re run on. But we’ve found that using mocks in a development environment really gives developers that quick turnaround that they need.

**Rebecca:** So you mentioned, before we recorded this, [an article that came out recently from the Google Testing blog](http://googletesting.blogspot.com/2015/04/just-say-no-to-more-end-to-end-tests.html), kind of saying, “Who needs end-to-end tests? Let’s stop spending time on these. It’s not a good use of our time,” and one of the things that they mention is those dependencies and how, when there is a failure, you spend so much time trying to just track down what actually failed because you’re testing this whole system. Do you find that by putting those mocks in place, you work around that?

**Dave:** Yes, absolutely. And this is one of the biggest complaints of end-to-end testing, is okay, you get a test failure and now what? So, if you have a unit test, you have a stack trace, you can see exactly where your code failed. But with an end-to-end test case, often times you’ll just get some kind of failed assertion and you have no idea which code was actually responsible.

So, our strategy, which I’ll talk about in more detail later, actually addresses some of these things specifically. One of the ways that it addresses this, as you mentioned, is the mocking solution. This allows us to insulate ourselves from a server-side environment that is also in rapid development, where we might not always be able to stay in sync about whether a server-side environment is going down for maintenance or if an API is changing.

By relying on mocks, we are able to have tests that execute much faster because all of the network operations can stay local on one machine. It also allows the developers to own their own expectations of how the server is going to respond, so they can sort of be aware of all of those contracts, especially in error cases, which is often one of the things that’s overlooked, is how is the user experience handled in an error condition? Is it just going to be a big blank page or a big stack trace on the screen? Or are we going to give the user some indication of what they should do to get out of this case? By owning all of these server responses as mocks that we actually have checked into our codebase, that really makes the front-end developers think about okay, am I handling really, truly every response that I can get from the server?

**Rebecca:** A couple of questions that come out of that. One is: if I’m a developer working on a product page and I’m developing this mock, what pieces are in place to make sure that the real API that backs that page is going to behave the way that my mock does?

**Dave:** Yeah, that’s one of the biggest questions that we get a lot, and we’ve spent a lot of time trying to figure out if there’s some good automated ways to keep those things in sync. It’s a hard problem we haven’t solved yet. Currently, our strategy for this, as I mentioned, is to have basically two different suites of tests: one of them that runs against mock servers, and then one that runs against our real production server or staging server, which should have basically the same data available to it. If we have parity between those two kinds of test suites, we’ll be able to see—if one test failed on the mock server but passed on the production server, or vice versa—we’ll be able to see that we’ve lost parity there and that the mocks need to be updated.

**Rebecca:** Will you be able to trace that to the mock? Will you be able to trace it to a bad mock? Or is there still some uncertainty there?

**Dave:** The way that we trace these things is every test case has an associated QA test ID with it. So, that’s the way that we could tie a production test case to a development test case, and we’d be able to tell if one passed in one place or failed on the other. Each test that runs very clearly identifies which mock it is talking to at the beginning of the test, and so that would give developers an idea of which file they need to go and investigate if one of their mock tests is failing.

**Rebecca:** Speaking of developers, you’re developing this system for them, right? How receptive have developers been to (a) the idea of writing tests period and (b) specifically the idea of writing end-to-end tests?

**Dave:** Yeah, it’s interesting. We started off with a fairly small pilot program, basically just the cart and checkout team were our initial candidates as we began to develop what we call “Magellan,” which is our whole ecosystem of end-to-end tests at Walmart. Actually, initially the response was extremely positive. This was something that developers recognized as a very complex system, and often times, despite having one of the most comprehensive unit test suites that I’ve ever seen, there were still regressions that would slip in at the last minute right before a deployment and cause a lot of people to lose a lot of sleep, especially when it came to multi-browser things. Often times, a scenario would work perfectly well in Firefox or Chrome, but it would fail in an older version of IE that unfortunately we still have to support.

**Rebecca:** And so, these end-to-end tests you are actually running in more browsers and probably in a way that even if you ran your unit tests in more browsers, you might not catch some interaction issues.

**Dave:** Right, exactly. We’re using Sauce Labs to outsource the notion of browsers as a service, so we don’t have to maintain our own server farm, and it’s been working fantastically well. We can just update a configuration file whenever we need to change what browsers we want to test on, and we have a whole business team that’s continuously looking at our analytics data to see what browsers we need to support or which ones we can drop every quarter. But, it’s looking like we’re going to be stuck with IE8 for the foreseeable future, because that is still a part of our market share that we can’t ignore.

**Rebecca:** Yep, us too. We’re waiting. We’re waiting, and waiting, and waiting… It’s just still not quite going away. So, I’m interested to talk a little bit more about the developer experience of working with these tests and what developers think about this. Are they embracing it, or are they still kind of trying to get the hang of it? And again, going back to the Google article, are they saying “This is pointless. Let me just write my unit tests.”

**Dave:** At first, we tried to start off with just kind of an out of the box end-to-end testing solution, and the feedback that we got from developers was, “This is flaky, this is frustrating. I want these tests to work but I’m getting so many false positives that this is just wasting my time.” That feedback that we got from the developers initially was what really led us to start creating our own framework built on top of some of these existing tools to smooth over a lot of those friction points that cause developers to push back. Because we want developers to be able to focus on pushing code, identifying regressions that are legitimate, fixing the regressions, updating the tests, and moving on to something else.

What we found, which very much mirrors this Google Testing blog article, was that often times there were so many false positives or that tests were running so slowly that it was more of a hinderance, and it was a net loss instead of a net savings.

**Rebecca:** You mentioned Magellan is the system that you’re working on to kind of address this in a holistic way. Can you tell me a little bit about what the different pieces of that are?

**Dave:** Yeah, absolutely. So, I’m really glad that Mike Wacker actually created this blog about Just Say No to More End-to-End Tests, because his three main points are actually the three biggest driving features of what Magellan does and why it’s different than other solutions.

So, his first criticism was the fast feedback loop, that no developer wants to wait hours or days to find out if their change works. For this, we wrote a parallel test runner, which basically is only constrained by resources available on your local machine or on your remote machine, if you’re using a service like Sauce Labs.

But let’s say that you have a test suite of 100 tests, which we do for our checkout module, and it would take 45 minutes to run all of these tests serially for one browser on remote servers on SauceLabs.com. So, by subscribing to a lot more concurrent virtual machines on the Sauce Labs side, and by using Magellan to run these tests in a massively parallel way, we can actually compress that down to more like 10 minutes, which becomes much more palatable for a developer to wait that long to verify their changes.

**Rebecca:** And so they’re running these on pull requests, or on their machine, or where is a developer running these?

**Dave:** Yeah, so this is something that we’re rapidly scaling up. Currently, developers run these Magellan tests locally on their machine just using a simple Grunt command, and these are also run as part of every pull request using PhantomJS as the browser. So, currently on pull requests, we are not running the full browser suite, just because those resources are something that we have to pay for and we have to protect a little bit, and running them on every push to a pull request could quickly cause the queue to get really backed up.

But [PhantomJS](http://phantomjs.org/) is fantastic for running the suite very, very quickly on a continuous integration environment. We can actually run those same 100 tests in about two minutes just because we don’t have any network latency to worry about. That gives us a very nice first line of defense to spot any egregious errors that would have failed anyway on a real browser. And then once the change has actually landed on the master branch, that’s when we’ll go and run the full suite against all of our browsers. If there’s a change, we’ve got a very nice blame system so that a developer can see, “Oh, that was my bad. This regression was actually because of my change.”

---

**Rebecca:** I want to pause here to thank [SauceLabs.com](https://saucelabs.com) again for their sponsorship of this show. They brought front end ops to the forefront with the Front End Ops Conference in 2014, and they continue to make it possible for us to have insight into how our applications work, or, you know, don’t work across way more browsers and operating systems than you ever want to be responsible for maintaining yourself. If you haven’t checked them out, then just press "pause" and go do it. But first, hit up the [ttlpodcast.com](ttlpodcast.com) website for your promo code.

---

**Rebecca:** And we’re back. So, we were talking about Magellan before the break, and you were talking about how it helps you parallelize the test execution so that a 45-minute test run can actually be executed in a whole lot less time because you’re parallelizing the execution of those tests. What are the other pieces of Magellan that helps solve the end-to-end testing problem?

**Dave:** Yeah, so there’s two more big pieces I’d like to talk about that relate directly to Mike’s blog on the Google Testing side. One is reliability of end-to-end tests and the other is isolation of failures.

So, as I mentioned, the isolation of failures is something that is often a pain point because we don’t get a stack trace showing you exactly where the regression happened. But when we have a solution like Magellan that allows us to run the tests in a fast feedback loop, fast enough that we can run them on every pull request or ever merge to master, that kind of isolation, while it might not tell us the stack trace of where the error happened, it’ll still give us a small enough slice of information that we can say it was due to this particular merge to master, this particular pull request, and that gives developers a much more narrow window to look into. Instead of having tests that, for instance, only run once a night, and then you have to look at all of the changes that happened over the last 24 hours. Having that level of fidelity usually gives developers enough information to quickly figure out what went wrong.

**Rebecca:** In order to keep these tests fast, it seems like you probably can’t run them against all of Walmart.com. It does seem like you would need to isolate them to a track. Is that true? Or are you seeing a future where you can actually run all of the tests for all of Walmart.com on every pull request, or every land to master or whatever?

**Dave:** That’s a good question. Certainly with PhantomJS, we have a lot more flexibility because we can just keep adding more virtual machines with more cores, and we can scale up as much as we want to run as many tests in parallel as we want to. Certainly for the real browsers, having a set subscription to a certain number of virtual machines does limit us somewhat, so that we can’t run all of these tests for the complete site end-to-end on every single pull request.

But that’s the machine that we’re working towards, is we’ve got all these different levers we can pull for how we tune the number of tests that we run, how often we run them, and when we run them, and we’re just trying to tune these as much as possible to catch regressions as early as we can, with as much help to developers as we can.

**Rebecca:** Have you given any thought to picking and choosing the test that you run for a given merge? So, trying to identify the tests that are relevant to the change?

**Dave:** Yeah, and that’s actually something that we recently were given the luxury of doing very easily. I mentioned before that we used to have this big monolithic codebase that all the track shared. We recently implemented a project that we call “The Great Divide,” where we split off separate repos for separate tracks. And that made it easy to, for instance, only run the checkout suite when we have a change to the checkout repo. So, if somebody on a totally different page, like homepage, makes a change, there’s no need to consume a bunch of resources to validate some tests that aren’t going to be affected.

**Rebecca:** So, you’re doing it kind of at an app level and not at a more granular level, of I’ve only changed the checkout error case when the product isn’t available for shipping.

**Dave:** Right. Yeah, that level of granularity we haven’t gotten to, yet. That’s something that would be nice to have, but we’re not there yet.

**Rebecca:** I think that’s a kind of hard problem, and when [I talked to Burak from Disqus](http://ttlpodcast.com/episodes/burak-yigit-kaya.html), he was also lamenting that that’s kind of a hard problem in JavaScript, especially. Maybe in Java; I bet in Java it’s really easy, right? [laughs]

**Dave:** Oh, I’m sure, yeah. [laughs]

**Rebecca:** So, you said there were three parts to Magellan. What’s the third part that you wanted to talk about that will refute the Google Testing blog post?

**Dave:** This is actually one of the most controversial pieces, and I’m going to ask everybody to just walk with me on this for a while and reserve judgement until the end. That’s about reliability of end-to-end tests. Mike’s point in his Google Testing blog was that no developer wants to spend hours debugging a test only to find out it was a flaky test. This is something that, early on in our days of end-to-end testing at Walmart, that we were hitting all the time. It was causing people to really lose confidence in the mission of what we were trying to do. And so, it was very quickly one of the first fires that we realized that we needed to put out, because if people don’t trust the system that you’re building, they’re not going to pay attention when things break, they’re not going to take it seriously.

So, I spent a lot of time researching this. Unfortunately, there is not just a finite list of what causes tests to be flaky. Sometimes it could certainly be flake that’s actually in the application code itself. Most of the time, it’s flake due to just the vast amount of moving parts that are involved in an end-to-end test. From doing a lot of research about certain kinds of errors that we were seeing, it became kind of depressingly obvious to us that Selenium itself has bugs, the browser-specific drivers for Selenium have a lot of well-known bugs, as well. So, sometimes a test would fail for just some completely random reason and it would pass the next time, but it would cause a build to fail and it would cause a developer to waste time looking at something.

What do we do about that kind of flakiness, right? What do we do about solving flakiness for cases that we might not even know about yet, or cases that exist in some binary for some Internet Explorer WebDriver that we have absolutely no control over, and we have no way to understand?

We did a lot of research into this, we talked to a lot of people. We talked to people from Sauce Labs, we talked to people from QA consulting organizations. The industry standard for how to handle flaky tests that may be due to things that are out of your control is probably one of the most controversial philosophies I’ve ever heard, and that’s to retry the tests.

**Rebecca:** [laughs]

**Dave:** This is where I lose a lot of confidence in developers that are accustomed to a very pure and very clean approach to things. And this is where I like to get into kind of a little bit of a funny metaphor that I think of. You have this question that you want to ask, which is “Does my code work? Do I have a regression?” and you want to get an answer for this, yes or no.

So with a unit test, developers are accustomed to just a very small surface area of infrastructure to work with that is just all on their local machine, they can run a unit test and get a result back in a couple nanoseconds. I like to think of this as “I’m hungry, I’m going to reach into this cupboard that’s right next to me and grab a can of soup. Done. I’ve got everything I need. The can of soup is right there.” I like to think of the end-to-end tests as “I’m hungry. I want a can of soup, but I don’t have it right here. I have to get in my car and drive to the supermarket and get it.” So, I like to think of Magellan as a heavily-fortified motorcade of military vehicles that are going to escort you to the grocery store, deal with roads that are full of potholes, deal with zombies that are in the way, deal with whatever else is going to try to prevent you from getting to where you’re going so that you can just focus on that can of soup.

Developers that are used to a very lightweight infrastructure, where everything runs very fast using local tools and a very predictable workflow—this is where I lose a lot of them because all of this is very, very heavy. All of this infrastructure seems like overkill.

**Rebecca:** So, is it heavy for the user or is it just heavy if they want to go in and work with it, or modify it?

**Dave:** It’s heavy in the sense of what’s going on behind the scenes. So, I mentioned the retrying as a way to smooth over reliability issues. I like to think of this as like okay, you’re going to send a convoy, and that convoy might get overwhelmed by zombies on the way to the grocery store. If that one gets lost, send another convoy, and probably the next one will make it.

What we do is we have—Magellan is programmable so that you can have a configurable number of retries before a test actually gives up as a failure. We’ve found that setting that to three has smoothed over 99.9% of all of our infrastructure flake due to things that are out of our control. The first criticism we’ll often hear is, “Well, isn’t this going to sweep a bunch of stuff under the rug that could be legitimate failures?” And the answer is yes. But Magellan collects data—for tests that actually pass, how many retries did it take to get them to pass? And when we go back and run some queries over this data periodically, we can start to see outliers.

So, if we see one particular test that, on average, took more retries than another one, we know that, okay, possibly there’s something about the test itself or the code under test itself for this particular case that is more prone to flaky behavior, and maybe we need to look at application code as a culprit. Whereas if we see the number of retries is fairly uniform over an entire test suite, we can be fairly confident that it’s probably just these annoying bugs in the infrastructure that we have no culture over, and it’s not something that’s worth our time to look at.

**Rebecca:** So, you mention querying that data. Is that data that can actually surface itself? Like, somehow alert to you proactively that “in the last ten runs, this test has been an outlier”?

**Dave:** Yeah. So, that’s something that’s on our to-do list. Currently, we’re actually using a forked version of [TestSwarm](http://swarm.jquery.org/), which was actually created for tracking cross-browser unit test results for jQuery and related projects. We picked that because it has a very, very beautiful UI for showing you a matrix of multiple browsers under test, and then on another axis, the test suites—you can drill down and actually see individual tests, and it shows you very clearly which ones are passing and which are failing. So, we actually forked that to work with Magellan for end-to-end tests, as well. So, all of our data is available just in these TestSwarm tables, about which tests are passing, which are failing, how many retries they took.

We don’t have a great solution other than running queries and doing manual sorts right now for identifying those outliers, as I mentioned. But this is something that, as we move Magellan into the open source world and out of just the boundaries of our organization, that we’re really hoping to get some community involvement to bring this information to user’s fingertips more easily.

**Rebecca:** That would be exciting, if you could actually—because I think that’s the key part of a retry strategy, is you have to know when it is hiding things. And, of course, that was the question I was going to ask that you already anticipated, so you beat me to it. Good work.

**Dave:** [laughs]

**Rebecca:** You mentioned open sourcing Magellan. Is that in the cards? Is that on the road map?

**Dave:** It is. And this is something that has been part of our mission from the beginning, is we’ve realized from the beginning that the things we’re solving in Magellan are probably things that a lot of organizations wish they could solve if only they had time to do it. We’ve been very fortunate with our core web team and the small front-end ops facet that’s developing, that we’ve been given a lot of time, resources, and confidence from our management to really tackle this problem in a solution that’s going to stand the test of time.

But we realize that what we’re building is much bigger than even we can anticipate for our own organization, and there’s a lot of things, as you mentioned already, that we’re not thinking about or that we haven’t had time to implement, that we would really love to get the community involved in. So, it’s our goal to open source Magellan as quickly as possible. It’s something that we’re working very quickly with our management team to figure out the best way to do it. We have a lot of open source software that’s come out of Walmart, and we have a process we have to follow for how to release it. But it’s something we’re very excited about doing.

**Rebecca:** One last question about this whole approach is: What about the cost of this? Because the promise of automated end-to-end testing is that you can get your QA team doing higher value things, that you aren’t spending money on something that is just following a script, basically. But the tradeoff there is that you are paying money for the infrastructure to support it, the services to support it. What are you finding as far as the cost tradeoffs?

**Dave:** So, for a large organization like Walmart, it’s very easy to justify the costs, just because paying a bunch of humans to actually tediously go through ten different versions of various browsers and repeatedly run the same tests manually is just ridiculously expensive. So, we’ve used this as part of our justification for expensing the cost of Sauce Labs subscriptions. We can basically do the same amount of tedious work that you would have to pay this many people this many hours of work to do, and we can compress that into this much time and pay a much, much smaller fraction of that cost to a vendor like Sauce Labs. Of course, not every organization has the same needs and has the same budget and has the same luxury of spending money on a third-party vendor, but that’s one of the tradeoffs that you can make in terms of what browsers you’re targeting with Magellan.

As I mentioned, we’re running the bulk of our tests as close to the factory floor of development as we can using PhantomJS, which is very, very cheap to run because you can just run it locally. We’ve found that most end-to-end failures, when they happen, they’re going to happen for all browsers. There’s probably maybe only one out of every ten regressions that we see that’s actually browser-specific. So, relying on PhantomJS as a first line of defense to actually run as close to a change happens as possible is probably going to work for most organizations. And then organizations, or teams, or individuals that don’t have the resources to license a whole lot of remote browsers can probably rely on running their tests less frequently across the whole browser matrix, maybe nightly or at a few times throughout the day, and maybe only using a handful of parallel browsers instead of dozens, and still get pretty good results.

**Rebecca:** Yeah, I think then you’d run into the thing that we were talking about earlier—if you’re only running them in a certain set of browsers once a day, then when something does fail on one of those browsers, you have a day’s worth of changes to go back and look at.

**Dave:** Yeah, that’s an unfortunate reality too, is that’s always going to be a case that happens and it’s going to be frustrating. But one thing that’s really nice—I *love* seeing blogs that say, “End-to-end sucks. This is a waste of time.” I love to see people coming to this conversation, even if it’s to bring negativity and frustration and to suggest that we give up, because I think the more people that are participating in this conversation, the more it lends credibility to the fact that this is something that people want to work.

The more people we have involved in that conversation, the more incentives it gives teams like ours to keep working on Magellan, the more we hope eventually it’s going to give open source contributors the desire to spend time working making Magellan better, *and* the more need it’s going to give for vendors like Sauce Labs, or [BrowserStack](https://www.browserstack.com/), or possibly new ones in the future to enter this space and make it more competitive, make it more affordable, because there’s going to be more people that have this need and want to subscribe to services like that. So, hopefully that will bring costs down and make it so that even smaller teams can afford to run massively-parallel cross-browser tests.

**Rebecca:** Someday, someday… [laughs] This sounds cool. How was this actually built? What are the pieces—what’s the underlying technology of the system?

**Dave:** We realized that we didn’t need to completely start from scratch when we built Magellan, because there’s a lot of existing open source tools for doing end-to-end testing. At the end of the day, everything runs on [Selenium](http://www.seleniumhq.org/). That’s really the only low-level technology that has cross-browser support with [WebDrivers](http://www.seleniumhq.org/projects/webdriver/) that are made to work with all of the browsers that are out there in the wild these days.

So, at it’s core, we’re talking to Selenium. Selenium itself is not very friendly to use, so there’s a lot of frameworks that are built on top of Selenium to give it a cleaner API to make it more easy to use. And there’s a lot of them that run with Node. We wanted our front-end team to be able to just dive right in and write tests. So, a Node-based solution as opposed to something that runs on Java or Python or Ruby was an obvious choice.

But one of the other goals that we had with Magellan was that we didn’t want it to be something that you needed to be a developer with an engineering degree to be able to use. We wanted non-technical people, including junior QA people who don’t have a development background, to be able to understand tests and to write them without getting lost in a whole lot of confusing APIs, and nested callbacks, and promises, and things like that.

So, we made some choices that were actually controversial initially in our inner development circle. We chose to go with [Nightwatch.js](http://nightwatchjs.org/), which, as I mentioned, is a Node-based API on top of Selenium. we chose that for a few reasons: one is that it’s very, very well-documented. The whole API has beautiful docs that are very complete, easy to understand, easy for non-technical people to get in and use.

It’s extensible, so as you realize that you have chunks of your test that are repetitive copy-pasted blocks, it’s actually easy to extract those into commands that become kind of your own domain-specific language, so that if you have, let’s say, ten different steps to log into your application, which involves waiting for this input to be visible, typing some text into it, and then hitting a submit button, you can extract that out into a command and then in your test you can just write “browser.login as” and then a username and password.

The tests—when you actually open up a test file, especially if you make use of those commands, it starts to just read like prose, like a script. It’s very flat, it’s very step-by-step, there’s no nested branching complicated stuff with inner callbacks to worry about. So, if you’re a developer and you want to check in a change, and you see that one of these tests is broken by your change—maybe it’s a test you’ve never even looked at before—it becomes *a lot* easier to dive in and understand what’s going on when you have this very simple way of expressing a test.

**Rebecca:** So, that’s all Nightwatch, the stuff that you were talking about that actually provides that facility, not stuff that you’ve added on. So, that just exists out of the box.

**Dave:** Yes. So, we started off with just a pure Nightwatch solution, and we naively thought that maybe this would be enough, and that’s where we started making these discoveries, as I mentioned, that tests are running very slowly, tests are flaking out… And so, the Magellan pieces that we built on top of Nightwatch are the elements of a massively parallel test runner, a good reporting system based on TestSwarm so that you can see these results over time, and some of the other things, like the retry logic to smooth over infrastructure-related failures.

So, we’ve had quite a nice evolution with Magellan. Initially, Magellan was very tightly coupled to Nightwatch. But what we’ve actually done is we’ve extracted the Magellan infrastructure pieces that handle those additional use cases as a completely separate library, and we’ve encapsulated the Nightwatch compatibility layer as its own plugin.

So, we’ve basically got Magellan the infrastructure in one repo, we’ve got Magellan Nightwatch as a plugin in another repo, and what we’re hoping is that, as we open source this, that the community will bring Magellan-WD or Magellan-whatever to make all of these infrastructure pieces compatible with whatever WebDriver anybody wants to use, whatever they might already be comfortable with, whatever they might already have an existing test suite that they have, which they’re just frustrated with because it’s flaky—we’re hoping they can add Magellan on top of that to smooth over the bumps.

**Rebecca:** And kind of wrap their existing test suite. Well, that all sounds really cool. I’m looking forward to seeing it in the world. So, is Magellan something that, once it’s open source, is it just something I can `npm install`? Like, what’s the effort going to be for me to use this?

**Dave:** So, Magellan will be published on [NPM](https://www.npmjs.com/). And, as I mentioned, with the plugin architecture, our goal is to have Magellan as loosely coupled to your existing test suite as possible. Or if you don’t have an existing end-to-end test suite, we also have a Magellan boilerplate package, which will be easy to also just `npm install` inside your repo, and it’ll give you some nice, easy example tests that you can run right out of the box to see how it works, play around with it, and then you can just start hacking away at those tests to make them work on your website instead.

**Rebecca:** Alright, well Dave, it has been fantastic to talk to you. I didn’t know if we would fill a whole episode with talking about testing, but it turns out we did! And I really appreciate you coming on the show, and I look forward to seeing Magellan out in the wild.

**Dave:** Thanks Rebecca. Thanks for having me.

--

**Rebecca:** The TTL podcast is edited by Morgan Murphey. Website design by Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a special thanks also to Bazaarvoice. For music and other credits, visit TTLPodcast.com. I’m Rebecca Murphey. See you next time.
