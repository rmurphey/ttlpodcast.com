## Transcript

*Transcription by Seth Lavelle.*

**Rebecca**: You're recording now, I'm recording now. Here we are. I want to first find out how to say your name, so that I don't screw that up. [Laughs]

**Burak Yiğit Kaya**: Okay. Uh, it's pronounced "b'rock."

**Rebecca**: "b'rock"?

**Burak**: Yes. But if you're more comfortable, you can just say it like the president's name, Barack. Kind of similar.

**Rebecca**: Hello. I'm Rebecca Murphey and this is the TTL podcast.

**Burak**: Just... Don't even try it, yeah. It's just... First name is good.

**Rebecca**: Okay. But you should say your full name.

**Burak**: I am [Burak Yiğit Kaya](http://byk.im/).

---

**Rebecca**: The TTL podcast is brought to you by the fantastic folks at
[Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform
that makes it possible to test your app across browsers as part of your
continuous integration or continuous delivery workflow. Plus, they give
you manual access to more than 500 browser platform combinations. Try it
for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo
**code**.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and
deploy with confidence. Sync your GitHub projects with Travis CI and
you’ll be testing your code in minutes. Travis CI is offering a free trial
to the first 10 listeners of this episode who sign up with the promo code
on [ttlpodcast.com](http://ttlpodcast.com).

---

**Rebecca**: Hello, this is the TTL podcast! I'm Rebecca Murphey and I am here with Burak from Disqus. We have agreed that I'm not going to try to pronounce the rest of his name, but I'm going to let Burak introduce himself and tell us a little bit about what he does at Disqus. So, hello Burak!

**Burak**: Hi, Rebecca. Thanks for having me. My name is Burak, as you've correctly pronounced. I'm just known as BYK in the "interwebs."

**Rebecca**: [Laughs] Now it all makes sense. Well, thank you for being here and for pronouncing your name and not making me do it. That was very generous of you.

So, you work at [Disqus](https://disqus.com/) and you started there three years ago as a core JavaScript developer. You said you transitioned into a role as a front end infrastructure engineer after seeing [Alex Sexton's post](http://www.smashingmagazine.com/2013/06/11/front-end-ops/) about front end ops. And today you're one of two tech leads at Disqus. Tell me, how did you make that transition from "just" a JavaScript developer to actually focusing on front end infrastructure.

**Burak**: First of all, I think I have to mention that I always had a fascination towards developing frameworks and stuff like that to improve other people's productivity. Then I saw Alex's post, and that was almost natural to me. I was like, "Oh my god, this person..." I have to admit, I did not know Alex before that post. I read things occasionally, I just don't pay attention to names. When I saw that, I was like, "Oh my god, this guy nailed it."

I was working with [Ben Vinegar](http://benv.ca/) at that time, which was really fortunate. I just forwarded that post to him and our CTO and said, "I want this position to be open and I want to be this guy." A couple of months after that, I was literally doing that job. By that time, I was transitioning into working remotely from Turkey again, so that actually was quite well-suited for that because it's mostly offline. You just intro the infrastructure and then other people can keep working on it.

**Rebecca**: Oh, neat. That's an interesting thing I've never thought about, that it is a job that's well-suited to not necessarily being "in the thick of things."

**Burak**: Unless you break something, yeah.

**Rebecca**: Unless you break something. Good point. So, now you're one of two front-end leads at Disqus. How much do you still get to focus on that ops aspect of things?

**Burak**: I get to do quite a lot still, but it's more of the planning phase right now than implementation. Now I envy one of my colleagues, who gets to do the actual implementation stuff, usually. But at the same time, it's actually kind of a good feeling to be able to look ahead and see what other people are doing and show that stuff to the other person who's actually in the code and you can exchange ideas, which is quite refreshing.

**Rebecca**: Well, and it's cool too because it sounds like you're getting to disseminate this idea out through the rest of your team rather than just being the one guy in a totally different time zone who's doing it.

**Burak**: That was really powerful too, because before that I had to talk to Ben and he actually did a great job communicating that. But I always got frustrated--you can ask him--about not being able to communicate that to the upper management or to the rest of the team as effectively as he did, and this gave me that opportunity. I'm now talking to the CTO or VP of engineering and other team members, and making data and then we're presenting a plan. And then I can also implement to some extent, but this other person helps me very much with that.

**Rebecca**: That's something I hadn't necessarily planned on talking about during the show, but that aspect of convincing the people with the money that this is important--it sounds like that has been a big thing for you, yeah?

**Burak**: It is because while you're still a startup--well, you probably officially couldn't call Disqus a startup now, it's been seven years or maybe more--but still, you're in the startup mode. You have to justify those infrastructure investments and not just for code's sake, you have to show that it will actually improve productivity.

While I was working with Ben, he took a shot and he introduced a project along with me, and then we were able to convince the management, "Hey, this will really make us go fast." Then once you prove that, you now have credibility to create other projects. It's still a challenge because you have time and resource restrictions, but it goes well, I have to say. I'm learning a lot from that experience.

**Rebecca**: You should write about that, because I think that's one of the hardest things that people run into, especially in companies that haven't really embraced this idea of front end ops and investing in infrastructure like that. I know I could use advice on how to sell that story to the people with the money.

**Burak**: It sounds really polished here. I'm not going to pretend I have it all figured out. [Laughs]

**Rebecca**: [Laughs] So, you're making yourself sound good. Fair enough. Tell me a brief description of deployment at Disqus. How do you get code from your computer out into the world?

**Burak**: Okay, so we use [Phabricator](http://phabricator.org/). Maybe you've heard about that. That's the thing Facebook wrote and uses. Once you land the code, [Jenkins](https://jenkins-ci.org/) pulls from master, and then pulls all the dependencies--we use `npm shrinkwrap`, by the way, to ensure lower-level printout, like granular dependency intactness, and then we pack everything into a single package.

At this time, we also pull translation packages, too. So, they're pulled at build time, they don't live in the repo. And then we run tests against that package, so we don't have a separate test build, that test runs against the production package. Then once you click on the button that says, "Promote this build," the package is sent to our media servers, and then we change the symlink, and then in five minutes we have 99% saturation.

**Rebecca**: So, do you deploy your front end application separately from the back end application?

**Burak**: Yes. That's actually the first project that we did with that. That helped us a lot.

**Rebecca**: You said you get 99% saturation right away. Do you manage that just through intelligent caching, and scout files, and all of that?

**Burak**: Yes. Let me go into some more detail for this. Since Disqus is an embedded product--well, we now have a front-facing page with all of that fancy stuff...

**Rebecca**: I noticed. I didn't know that existed until I logged in the other day.

**Burak**: You should use it more. It's getting really great. For the old times, we were only an embed, and there's this embed.js file, which was only cached for five minutes in the browser, and the rest of the files are actually cached per URL hashing. So, they're cached for at least one month plus any time you want to put on to them. Once you're in your build, only the changed file signatures change and the bootloader version changes. Then it just changes that, so once the browser caching for the uncached file changes, you get the new file, then you get folders and stuff.

**Rebecca**: How many files constitute the front end application? Is it just that scout file and then the one version file? Is it a bunch of version files? How have you decided to break that all up.

**Burak**: It's kind of weird. So, we have this top-level embed.js file which lives on the host page, and its sole purpose is to create an iframe with the correct version, and then communicate with the host page and the iframe. It's not large--it's like 40k minified, and then when you gzip it, it's like 10k or probably less than that. Then it loads the iframe with a certain bootloader version, and that bootloader file actually includes the [RequireJS](http://requirejs.org/) loader, and then it loads a few more files, including the main CSS and application files. We do lazy loading for some of this stuff, but the total critical files we load for production is about five or six.

**Rebecca**: Have you had to adjust that at all as you see performance information? How did you decide how to break that up?

**Burak**: It was a long time ago. We had to have this first small embed file; it should not be cached, so it has to be small, tiny, and it has to live on a host page, so it has different characteristics than anything you can put into your own iframe. Then the bootloader file was there because you can't just put script tags into an iframe, because that blocks the loading of the parent page. So, we had this small bootloader file that defers the loading of the actual application files, and then we had the common-bundle, which has models, and some JQuery, or backbone, vendor files. Then we have the application file and the CSS file.

**Rebecca**: Got it. So it’s kind of like a cascade, where one thing loads another thing, loads another thing, loads another thing.

So, this is straying off the topic of front end ops a little bit, but it’s a topic close to my heart in the third-party JavaScript land, and it’s relevant to performance for sure: to iframe or not to iframe? The application I work on has chosen not to iframe, which makes for all sorts of fun and exciting challenges. You guys use iframes. Could you talk about that decision?

**Burak**: I can’t talk about the exact decision point, because when I joined the decision was recently made, again by Ben. But I have to say, after talking to him and seeing all of this stuff, I’m way more convinced that we should use iframes--at least for our case. We have transitioned into a more customer-oriented or customer-focused product, and once people see Disqus… It used to be that they didn’t realize it was Disqus. Now we can actually protect the brand because you have strict limits around customization and the script cannot arbitrarily break because of some other third-party code on the host page. That was critical, actually. It’s critical both in terms of security, but it’s also critical for ensuring the product’s smoothness. Because if it doesn’t work, people blame Disqus, but it’s usually not our fault. So, that was a critical part.

It definitely comes with its own performance problems, especially around sizing the iframe. But I think we’re at a good point. We didn’t have a dedicated performance improvement phase, which will probably come later this year. Then we’ll see if we can get iframe performance really, really high.

**Rebecca**: You mentioned that one of the reasons you choose an iframe is because your host page’s code can’t interfere with your code, or at least they have to really try hard to interfere with your code. But still, I’m sure things do go wrong with your code because we’re not perfect. How do you have visibility into how your code is actually behaving in production, whether it’s throwing errors or that kind of thing?

**Burak**: We have multiple measures. I start with the simplest one: we have [Sentry](https://www.getsentry.com/welcome/) or Raven-JS built into the iframe. So, if there’s an exception that we did not catch, it immediately gets reported to Sentry and we just track it constantly. Thankfully we have a really low number of exceptions happening.

There are also some other measures, like on the host page we only usually need to detect the errors at the loading stage, because once you’re loaded there’s not much you do. At that phase, we ping our stats endpoint, saying, “Hey, there’s an error,” and coded in a number of different types of errors. Like, if the number is 1, it’s a server-side error, if the number is 2, it’s a JS exception, etc. There are three or four exceptions that we just keep track of in [Grafana](http://grafana.org/). We also track the number of requests made to the back end serves, including API servers, the initial iframe page with the version of it--that’s how we actually know how much saturation we got.

**Rebecca**: I’m jealous that you’re in an iframe. I think if we had it to do over again, I don’t know if we would make the same decision. It’s kind of the thing where the ship has sailed and to change it would be really hard. At my job, we have to deal with errors where we don’t know whether they’re ours or the customer’s errors. Ultimately, they’re ours and we have to go investigate them. But often they’re errors that were created by the host page, not by us.

The other thing that you mentioned there was customization and that you had Disqus customers who were changing how Disqus looked and that that was challenging, you wanted to have a seamless experience. How do you balance that desire for customization with the challenge of supporting customization? It’s very difficult to support arbitrary customization--how do you balance that?

**Burak**: To be honest, most of that is a designer question. From a technical standpoint, I can definitely see ways--even some crazy ways--that we can support customization in a relatively safe manner. Google did this with [Caja](https://developers.google.com/caja/). That was for JavaScript; you were able to run it in a safe manner because they were doing some really crazy engineering there.

For CSS, we can probably limit the selectors and stuff, which we don’t right now. Again, it was mostly a design decision, because our designers and product managers and all the people responsible for it said, “We want some level of customization, such as colors or font, serif, or sans-serif types, etc. But we want to ensure a streamlined, solid, smooth product/brand presence. We want to know people recognize Disqus when they see it.” That was the main driving point.

Otherwise, again, we can allow many customizations, and yes, it’s technically challenging, but I think design is more challenging than that.

---

**Rebecca**: I want to pause here to thank Sauce Labs again for their support of the
show. They brought front end ops to the forefront with the [Front End Ops
Conference](http://www.feopsconf.com/) in 2014 and they continue to make it
possible for us to have insight into how our applications work—or, you know,
don’t work—across way more browsers and operating systems than you ever want
to be responsible for maintaining yourself. If you haven’t checked them out,
head over to [ttlpodcast.com](http://ttlpodcast.com) for a promo code and then
go visit them at [SauceLabs.com](https://saucelabs.com).

---

Alright, and we’re back.

So, we talked a little bit about customization, and about iframing and not iframing. One thing that comes to mind to me with iframing versus not iframing is the SEO benefit of the content. This is sort of not a front end ops-y thing, but I actually know that at my job we’ve been talking a lot about doing some very front end ops-y things to try to improve the SEO story for our product. I’m curious whether that’s a concern for Disqus and how you’re handling it.

**Burak**: Well, it has been a concern for the comments part, but it was not really strong. But once we had our own dedicated homepage for things, it definitely became a major concern.

We have explored ways of server-side rendering combined with "isomorphic" JavaScript code. Well, that was too expensive for us to switch immediately. I’m still looking into ways of doing that. But we’ve moved forward with a somewhat easier solution right now. There are a few services out there that will pre-render your page, run your JavaScript, and then serving that page to certain bots, like Googlebot or Facebook’s page crawler. So, that’s certainly something we have used.

But we were not able to extend it to Google’s scale because the number of requests Google makes, which is a lot. But fortunately Google’s own bot actually executes JavaScript, so entering good markup usually helps you that way. And for the iframe part, fascinating enough, Google again executes our own embed script, and then loads the iframe, and then scrapes the contents of that iframe, and we also serve a simplified HTML version of the comments part for the first 50 comments to Google and our search bots. We should definitely do better, but I think this is good enough for now.

**Rebecca**: Something that we’re finding is that we have been seeing that Google is actually executing our JavaScript, which is hard to convince SEO agencies that it’s true. But it’s true, we’re seeing it, that they’re actually executing our JavaScript and seeing things that they wouldn’t see unless they were executing our JavaScript.

But the other thing that we’re finding is that now that Google is executing our JavaScript, you could say, “Oh, we don’t need to worry about server render because Google’s got it covered.” But we’re actually still talking about server render because we think we might be able to use it to improve the time to first pixel, basically. So, are you looking at it at all from a performance perspective?

**Burak**: Yeah, that was definitely a really strong point. Server-side rendering presented lots of challenges, but it was really rewarding. Again, in terms of performance, as you mentioned. People would definitely see something they can at least read in a comfortable manner. You can even do some old Yahoo! tricks, like sending a really small JavaScript, capturing all the events, and then playing them back once the actual application is ready. There’s other things that we really looked into, it’s just, again, a matter of time and resource management.

**Rebecca**: Time and work, time and work. Yeah, that’s where we are as well. You, just like us, your scale is enormous. You’re not solving this for a few hundred or a few thousand pages.

**Burak**: Yeah, unfortunately. Or fortunately--I don’t know.

**Rebecca**: Or fortunately. That’s what makes our jobs fun, right? On that scale topic, what other things make the scale interesting from a front-end development perspective?

**Burak**: There is this really interesting thing. Even if you add just one single request that is extra, that is new, if you did not talk to ops about that, you just bring down the system. Really, you cause trouble.

There was one time I did this. Actually… I did this multiple times, not just by adding files. [Laughs] But this one time, I added a hard dependency, a configuration JavaScript file generated on the server side, and I think I failed to communicate the timing about this. Because they knew this would be loaded every time, I think they just didn’t know when it was going to go out. Then as soon as the patch was out, after five minutes they started screaming and were like, “Where’s this file coming from?!” etc. Then one of the ops people realized, “Oh, Burak mentioned this to me…” We just rolled back and fixed it and made it better, and then moved forward. Something similar happened with the real-time endpoint, but we’re all good now.

It’s also satisfactory though, because once you fix it, you’ve actually fixed this simple thing that affected lots of larger things, which is scary and satisfying at the same time.

**Rebecca**: It’s super satisfying, and it’s cool to get to see the thing that you work on on sites that you go visit, it’s actually out there in the world. I run into Disqus randomly and I run into my product randomly, and it’s just out there in the world.

Let’s talk a little bit about performance. We just touched on that briefly on the server render topic, but what are you doing to understand the performance of your application out in the real world, and to maybe make improvements to that?

**Burak**: Performance was an on-and-off task for us. It was definitely not a product feature that we really kept an eye on constantly in the past. Right now we have basic measures, such as reading latencies, like we record all load latencies, load times, server response latencies from the front end. We just ping them and send it back. We categorize them into desktop browsers, iOS, and Android. We keep track of those times, and if your patch or your deploy increases some of those times considerably, then you’re forced to revert and explore that.

**Rebecca**: Are you able to actually correlate a given commit to a change in performance?

**Burak**: I wouldn’t say commit, but I would say deploy. And since we do deploys quite frequently, it’s easier to correlate them. Because on the graphs, we can definitely see the point of deploy and then about five minutes you see the effect of the deploy wide scale, and then once you see that line and increase in that graphic, you’re like, “Oh my god, I broke something! I have to roll back and then fix the build.”

**Rebecca**: How do you make it easy to roll back?

**Burak**: Well, that’s something that I did not do--that’s thanks to our ops people. It’s just like promoting a build. I can promote an older build and it immediately switches that symlink to something else, and in less than five minutes you’re now serving the old version, the latest stable version.

**Rebecca**: When you discover that you’ve made a mistake of whatever nature, is the course usually to roll back or is it to roll forward with a fix?

**Burak**: Usually it’s to roll back. It took some time to establish this. We’re still actually exploring options, looking into different workflows. I’ve been in this pit before, and usually rolling forward is more risky; it’s riskier than you think it is. Rolling back to the last known version, reverting the patch that is identified as causing a problem, and then working on a fix is better 90% of the time than rolling forward with a fix.

**Rebecca**: It’s funny, we’ve made the opposite decision and I don’t know how I feel about it. But it is what it is. [Laughs]

**Burak**: You certainly should experiment with it. It definitely depends on the team. It depends on lots of factors. This is what works for us--it doesn’t have to work for everyone. So, I definitely want to hear your story about that.

**Rebecca**: I think you nailed it, that when you roll forward, there’s always more risk than it seems like there is. Even though we have this “always roll forward” mentality, we also have had to really drill into developers this concept of doing a thorough risk evaluation before you do it, and doing the least possible thing that will solve the immediate problem--a rolling forward versus rolling back is not the time to refactor something, or like, “Oh, I found this other bug.” It’s not the time.

**Burak**: [Laughs]

**Rebecca**: You’re laughing because you know.

**Burak**: [Laughs] Again, I’ve been in that trap. Our first priority is always getting it back to working. I read this book, and the first thing on their checklist when a problem happens is to “keep flying the plane.” So, that’s the thing. You keep the product working and then fix whatever is broken.

**Rebecca**: Going back to performance, you said that you haven’t treated performance as a feature, and I think that’s a pretty powerful way to think about performance, is it’s a feature. Is that something that is becoming more important as the product evolves? Or are you in a place where you’re like, “It’s good enough,” and not the thing that you need to really focus on right now?

**Burak**: I keep saying this, but it again comes back to resource management. I personally think speed or performance is definitely a feature. If some product is out there and is faster than you, if they can claim and prove that, then you’re in trouble. You definitely have to match them at some point. If it’s not with speed, then you should outmatch them with features, or price, or whatever. So, I personally think, yes, performance should be a feature.

Disqus though, right now we had our runs to improve performance because there were all of these things that we could make. But once we reach a certain maturation point, then we’re like, “Okay, I think we’re satisfied with this, it doesn’t have to be perfect, and we need to move on to this other more important thing that will have a larger impact,” and then we shelve some other things that we want to do with performance and then we come back to them. We definitely come back to them.

**Rebecca**: I’m glad that you’re saying that, because I think that that’s a really “mature” thing to say, for lack of a better term, that it’s easy to get really attached to one of the tenets of front end ops and be like, “We have to get our performance as fast as humanly possible!” But a lot of this is balancing what are all of the different things that you could be doing, and figuring out which one has the biggest bang for your buck.

That brings us nicely to the next thing I wanted to talk about, which is another thing that you can focus your energy on, which is improving the development experience of a product or an application. So, not improving the experience for the people who use it, but improving the experience for the people who make it, so that they can make it faster and better for the people who use it. This was something that you specifically said you wanted to talk about. Can you tell me about the development experience at Disqus?

**Burak**: This started as my infatuation, or obsession with, “How do I see the stuff I have changed as soon as possible on my screen and then on user screens, and then get feedback from them?” The first step was to make builds happen fast. We’re not great that right now because we have accumulated some cruft that we’re looking into removing.

But after that, you have to have this immediate instant reload or code injection-kind of thing. Unfortunately, we can’t do code injection right now but that’s something that I’m looking into doing too--once you change a module, only that module changes and you refresh the app instead of building everything.

Then we have started having a tunnel. We actually have a tunnel that tunnels your computer, like your local server, to any device on the internet. So, you can check out how it looks on mobile or any other device, or you can share it with peers.

Another thing we’re looking into in terms of this is making builds available as soon as you submit a patch. So, Jenkins will respond to you with a link to your patch, so the reviewer can actually test it out. That’s an idea that we’re playing with. There’s certain challenges around that, but it’s certainly not impossible.

So yeah, we’re trying to get the feedback loop tightened so that developers can see it and they don’t wait staring at their screen for builds or anything else.

**Rebecca**: You mentioned trying to have fast builds and hot swapping of modules. My current fascination is with [Webpack](http://webpack.github.io/), which makes that all really easy. I think you said you are using Require. What’s making that hard for you? And what would make it easier for you to be able to get hot swapping and faster builds?

**Burak**: The first thing is really it’s RequireJS. The other thing is how our application is built. You have to have this embed file, which is a tiny bootloader, and then it uses another bootloader to load the application like a single page app. Nothing out there has support for this kind of flow, because you have to engrave that version of the internal bootloader into that outer file, and then you have to be able to build them at the same time. And you cannot use RequireJS on a host page, or if you have to use it, then you have to use it so unobtrusively that it should not affect any JavaScript on the host page, if possible.

Again, nothing out there helps us with this. So, we had to invent our own smart versioning system called SmartRev, for instance. Although Webpack does this, or some other things, we cannot use it because they expect to have a single point of entry that we cannot provide.

**Rebecca**: Right. Yeah, I hadn’t thought about that. That damn iframe! It’s going to get ya every time.

**Burak**: Yeah, that iframe, that’s one downside. Another challenge is making tests run really fast, or discovering which tests to run. That’s something we’re looking into for quite some time now. We have prototypes, but nothing ready for production, which is… What is the name for it? Selective test-running, I guess.

**Rebecca**: Like only running tests for the code that has changed somehow.

**Burak**: Yeah. It’s stupidly hard to do this in JavaScript reliably because of its super dynamic nature. The tools that you use for Webpack, or even [SystemJS](https://github.com/systemjs/systemjs), or RequireJS, they don’t actually expose the inner workings of these things, like ASTs, they don’t let you touch them.

There’s this person who mentioned this idea at a conference, who said Gulp was the next step after Grunt, which is “I’ll read the file once, and write it once, and then work with the stream.” The natural next step is read the file once, parse it only once, and then transform the ASTs, and then write the AST back once with source maps so you have the ties back to the original file, which I think is amazing. I’ve been thinking about this but he nailed it. His name is [Ingvar Stepanyan](http://rreverser.com/), or [@rreverser](https://twitter.com/RReverser) on Twitter.

I have to name one more person too, which is [Pamela Fox](http://www.pamelafox.org/), who nailed the “developer experience” term. I’m thankful to her for that because that really inspired me to be better for my colleagues, and to make their lives better.

**Rebecca**: I think it’s so important to have someone who is thinking about that, and who feels empowered to actually make changes to it, and doesn’t feel like, “This is just the way it is and we’re stuck with it,” but feels empowered to see the problems and fix them, and has the support of the company to actually do that. So, that’s really cool that you get to do that.

If you figure out how to do hot swapping of modules in real time inside of an iframe with a whole cascade of loading things, let me know. [Laughs] I want in on that.

You mentioned making tests fast. What testing technology do you use? How do you test how your app will work in the browser? What’s your testing strategy at Disqus?

**Burak**: The basics are we have a staging server, which gets updated as soon as a build on master completes. So again, deploying is just changing the symlink, so you get the latest version on staging using the live back end and stuff. So, there’s a QA part.

For the actual unit tests, I’m going probably disappoint you by not using Selenium, or WebDriver, or anything like that, because I think that’s too costly and the benefits are kind of diminishing, because browsers are kind of… You don’t really bump into inconsistency bugs that often as in the old days.

So, we use [PhantomJS](http://phantomjs.org/) and [Mocha](http://mochajs.org/), and try to test everything, including user interaction, by simulating clicks and stuff in our code. We’re also using [Sinon](http://sinonjs.org/), which is helping us a lot with its sandboxing feature, to just use a sandbox and then stub everything out and then do your stuff, and verify them. I think it’s working really well.

I’d stick to that and just try to make things faster using those tools, if possible. If not, then I’m going to look into other ways.

**Rebecca**: I should say that I’m not disappointed. I think that a lot of people are finding the cost prohibitive to use some tools that use WebDriver and such. I think that even though they’re a sponsor, I’m interested--and I think they’re interested--in hearing the challenges that people are running into with that. We have apps that we just test with Phantom, and we have apps that we test with WebDriver.

We’ve been focusing a lot on unit tests more than on comprehensive functional tests. Where do you guys put your efforts?

**Burak**: I’d say we also focus on unit tests more, because once you have a solid unit test stack that tests almost every possible data flow, the rest is more wiring. You can even achieve that by [smoke testing](http://en.wikipedia.org/wiki/Smoke_testing_%28software%29). Even loading the app--if it doesn’t throw an error or something…

**Rebecca**: “Did it show up?”

**Burak**: Yes, exactly. If it shows up… I did not know what “smoke testing” meant for a long time. I’m like, “What is this? Oh, you turn it on and if there’s no smoke, it’s good.”

**Rebecca**: “There’s no fire.”

**Burak**: Yeah. So, once you see it working, once there’s no errors--we try to catch all the errors during the testing stage--and we’re usually confident enough about interaction because--well, also there’s code reviews, which ensure that part is okay.

**Rebecca**: I was a big Require fan, a big [AMD](http://requirejs.org/docs/whyamd.html#amd) fan, and I’ve been definitely reconsidering that lately just because it seems like a lot of the tooling is kind of gravitating towards the [CommonJS](http://en.wikipedia.org/wiki/CommonJS) side of things. I’ll be interested to see how that shakes out, because I think that--and Alex said this when he and I talked--that being able to do fast builds is going to be a thing that we just take for granted eventually, but we aren’t there yet. But it has to be part of that developer story, that developer experience.

So, that was one of Alex’s predictions for what we’ll take for granted three years from now. I want to wrap up with you by asking what you think we’ll take for granted in three years that we don’t have right now in the front-end development, front-end ops world?

**Burak**: You put the stakes quite high with comparing me with Alex. So, I’m not going to shoot myself in the foot.

**Rebecca**: [Laughs]

**Burak**: I think he made a good prediction about having really fast builds. The only thing I can predict is modular JavaScript and dependency management will be granted for browser apps. It is good for Node-land right now, but call me old-fashioned, I’m coming from IE6 times, and I don’t think we’ve still figured out the browser module loading and the dependency management thing quite well. These tools work, but not everyone is using those tools. Once you’re building a simple web page, you still slot the script tag onto the page, and do it that way. I think in three years, I just want to see that disappear. But I think we’ll get there. ES6 is really promising; all these transpilers and unification of things, it’s pointing in that direction.

**Rebecca**: Burak, it has been so good to talk to you today. I’m glad that you were recommended to me for this podcast. So, thank you so much. Any last words?

**Burak**: Thank you for doing this. I think us FEOPS people needed something like this, even exploring other things about JavaScript. Thank you very much for taking this time and doing all this hard work.

**Rebecca**: [Laughs] I haven’t done any of the hard work yet, but by the time people hear this, I will. So, you are welcome. Thanks again for coming on. I appreciate it.

**Burak**: I hope to bump into you in a conference soon. [Laughs]

**Rebecca**: Some day, some day.

---

The TTL Podcast is edited by Morgan Murphey. Website design by Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a special thanks also to Bazaarvoice. For music and other credits, visit TTLPodcast.com. I’m Rebecca Murphey. See you next time.





