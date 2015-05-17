## Transcript

*Transcription by Seth Lavelle.*

**Rebecca Murphey:** I remember meeting Daniel at Front End Ops. And Seth,
apparently I also met you, and I’m just a terrible person who’s not good at
remembering things.

**Seth Walker:** Well, we shared a cab together, but it was a busy day, so.

**Rebecca:** Oh! Was that… Oh gosh, that was a rough morning.

**Seth:** Raining. Yeah, it was a rough morning.

**Rebecca:** Yeah, it was a rough morning for lots of reasons. I remember this
now. Thank you. So, yeah… Daniel, you talked at Front End Ops, and Seth, did
you talk as well, or you just attended?

**Seth:** I spoke and Daniel did not.

**Daniel Espeset:** No, vice versa. Yeah.

**Rebecca:** Vice versa! Oh, shoot! I have to start that over. Well, how did
that happen…

---

Hello, I’m Rebecca Murphey and this is the TTL podcast.

The TTL podcast is sponsored by the fantastic folks at
[Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform that
makes it possible to test your app across browsers as part of your continuous
integration or continuous delivery workflow. Plus, they give you manual access
to more than 500 browser-platform combinations. Try it for free today. Visit
[ttlpodcast.com](http://ttlpodcast.com) for a promo code.

And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and
deploy with confidence. Sync your GitHub projects with Travis CI and you’ll be
testing your code in minutes. Travis CI is offering a free trial to the first
10 listeners of this episode who sign up with the promo code on
[ttlpodcast.com](http://ttlpodcast.com).

---

Hello! This is Rebecca Murphey and this is the TTL podcast. Today, I am here
with [Seth Walker](http://sethwalker.me/) and [DanielEspeset](http://danielespeset.com/)
from [Etsy](https://www.etsy.com/), and
we’re going to talk about their performance and front end ops work there at
Etsy. So Daniel, Seth — welcome!

**Seth:** Hi.

**Daniel:** Hey. Happy to be here.

**Rebecca:** [Laughs] That’s very good. Can you say everything at the same
time exactly, this whole time?

**Daniel:** Yes.

**Seth:** Yep, probably.

**Daniel:** Aw, you screwed it up.

**Rebecca:** [Laughs] Perfect setup and you missed it.

So, Seth, Daniel, I met
you guys at the [Front End Ops Conference](http://www.feopsconf.com/) in San
Francisco last year, and Seth, [you spoke](https://www.youtube.com/watch?v=a9iXsC6RpyE).
I had this wrong in my memory, but thank you for reminding me that you’re the
one who spoke. Tell me a little bit about what you talked about at Front End
Ops Conf.

**Seth:** It was mostly about how we have confidence in making changes to
front end code using combinations of monitoring, and metrics gathering, and
small ramp-ups to users so that we don’t break everything all at once, and
that we can validate the change we’re making is actually having the impact
that we think it is — or a surprising impact.

**Rebecca:** Or not.

**Seth:** Or no impact, yeah, totally.

**Rebecca:** Could be worse. And Daniel, I remember you and I talked after
Seth’s talk, or maybe before — you know, it is all a blur. I remember talking to
you and you had some cool acronym for your last name. Just remind me of what
that is.

**Daniel:** Uh yeah, it’s Even Sad People Enjoy Shedding Empty Tears.

**Rebecca:** Thank you. This is the thing that I took away from Front End Ops
Conf, clearly. [Laughs]

**Daniel:** [Laughs]

**Rebecca:** But no, my talk then was about monitoring for errors and such,
and we also talked about the work that y’all are doing there and how you kind
of take a different approach. So, I’m hoping we can talk about all of that in
the next 30 or 40 minutes. But first, I wanted to know a little bit about — from
hearing you talk, Seth, and from talking to you, Daniel, it sounds like front
end ops really has a pretty solid place at Etsy, and I’m curious, if you could
just talk about how that happened, because a lot of folks are struggling to
create that culture at their company.

**Seth:** Sure. Yeah, we call it "front end infrastructure" as a team, but
when I read [Alex’s post](http://www.smashingmagazine.com/2013/06/11/front-end-ops/)
describing front end ops, it very clearly described a lot of what I
had been up to. The front end infrastructure team grew directly out of the
performance team, and we’ve had a performance team at Etsy for a few years.
There’s been a pretty strong support for performance work at Etsy for a few
years.

So, the kind of history is: I started digging into performance. As one does, I
started looking into back end performance because it’s so much easier to look
at, but then quickly started moving towards front end… Once we got a little
bit of a handle on the back end performance, started looking at front end
because Steve Souders, etc., the
[80/20 rule of all the performance gains being found on the front end](http://www.stevesouders.com/blog/2012/02/10/the-performance-golden-rule/). So, started
investing a lot of time on front end performance optimization and found that a
few of the things that we were trying to accomplish required broad changes
across the entire front end architecture, including changes to the asset
compilation pipeline, like adding cache-busting strings to compiled assets,
things like that.

So, we started to make a lot of changes to those infrastructural pieces, and
by touching it, we started owning it. And that was totally fine for us. But at some
point, we started to realize that we wanted to make some changes to improve
the infrastructure, and the architecture, and some of the other shared pieces
of the front end codebase that wouldn’t necessarily have a performance
benefit, or if it did, it was maybe not worth it for the performance gain but
it was worth it for other maintenance benefits, or otherwise, and…

**Daniel:** Sanity. [Laughs]

**Seth:** Sanity. And even, like, we could hypothesize that we might want to
make some changes that might even have an adverse affect on performance but
that was worth the tradeoff. So, we decided that it was worth splitting off a
separate team that is still very much in partnership with the performance
team. We all sit together. We feel very close to the performance team, but we
wanted to recognize that there was some work that was happening that was not
directly tied to performance work.

**Rebecca:** Yeah, a different set of concerns. First, how hard was it to get
the business on board with performance, and then how hard was it to get the
business on board with these kind of like, "We want happy developers…"
[Laughs]

**Seth:** Shockingly easy. I have to recognize that we’re in a lucky place
there. When I started at Etsy almost five years ago, there was already broad
support for performance work from the CTO on down, so I kind of inherited a
really easy mission there. I mean, there’s still work involved in selling
performance across the organization, but I at least had support from the top,
and that was really easy.

For the front end infrastructure work, I think it was just a matter of while
doing the performance work and identifying projects that had high value, and
just kind of adding them up and accruing them over time, just kind of
recognizing that if we didn’t have people dedicated to this work, it wouldn’t
get done, and that it was work that everyone was… I guess to your point about
"happy developers," that is something that we have across the culture of the
engineering organization, is both a tool-building culture — so wanting to
improve things for the future through tool-building…

**Daniel:** I think that, in a way, we definitely got a bunch of things for
free, from the way that engineering at Etsy was already set up, in terms of
making the case for a front end operations role because operations and the way
that the operations team operates at Etsy is so embedded in the way that we
approach solving a lot of different problems, that it was just a natural fit.
Basically, when we pitched it there were so many concepts that were already
fully accepted that our pitch to start this team was basically, "Welcome."

It’s hard, because we’ve actually been talking to a handful of colleagues
across lots of companies over the last few weeks about this. It feels like a
lot of people are in the process of trying to get a team that’s responsible
for this stuff created at their work, and that the case really needs to be
made, even at other large, mature tech companies that are operating at scale.
So, it’s not something that we got for free out of our size or our scale — it’s
very much culture.

Something that we have encountered as a kind of cultural shift is inserting
ourselves into ownership over certain shared commons. Like, there’s all this
stuff that once upon a time nobody owned, which sort of means that everybody
owns it, and there’s definitely a navigation that has to take place in order
to be the people who everyone kind of trusts to care for those commons.

**Rebecca:** I’m realizing as I’m talking to lots of people about this that
part of the skill of someone in this role is a little bit of politics — at least
a little bit.

**Seth:** I’d say a lot of politics. And I say that to candidates, look, "This
role is like a third technical, a third political, and then a third education,
basically." So, it’s like we’re trying to get everyone on board with the way
that we’re doing things, and that definitely requires some technical skill
because you can’t thought lead without the "goods" to back it up. But also,
even with the best tech, if you can’t sell it, it’s just not going to happen.

**Rebecca:** You said that you initially approached performance from a back
end perspective, where it’s kind of a known problem. And on the front end it’s
not a known problem, there are not really super well-established practices and
tools. How difficult was it to get front end on equal footing politically and
say, "This *is* where we can have the biggest bang for the buck," and have an
impact there?

**Seth:** Well, I’d say it’s maybe still not on equal footing, and some of
that is a gap in tooling that we just haven’t built yet. For example, we
recently started getting some really amazing alerts happening on performance
regressions. So, if a page’s back end performance goes above a certain
threshold, we’ll get an email with some amazing context; there’s a graph in
that shows the trend of the performance over time. But all of that is hooked
up to the back end graphs because those are the most reliable. With front end
performance, you get much broader variation. So, it feels really good to have
that alerting foundation there that we can add front end to eventually, but we
still haven’t done it because it’s just a harder problem.

But I do think that we’ve made pretty good strides in getting people to
understand that front end is where to look. We’ve had a lot of teams outside
of the performance team initiate performance-based experiments that are solely
on the front end. For example, removing some font weights off of pages or
doing some image optimization experiments, and all of that is driven by folks
outside of our teams, which is really exciting.

**Daniel:** Part of the challenge with diagnosing performance issues on the
front end is that the actual diagnosis is much more complex than back end
performance diagnosis tends to be. So, maybe that depends on your background.
But one of the things that we do at Etsy is basically every engineer has
access to everything, so we assume that lots of people will be writing code
for the front end that are not specialists in writing code for the front end.
All of our teams are cross-functional, and each product team is responsible
for building the product front to back, monitoring it, deploying it; if it’s
something that might break in production, then being on call for it.

So, individual teams have a really broad scope, and so in that context, one of
our big challenges is people will come to us and say, "Hey, I know that this
is slow and I have no idea what to do about it," and providing tooling to help
in those cases, and education for those cases is ongoing work that we’re kind
of still doing.

**Rebecca:** So, you talk about how the back end is easier to diagnose
performance issues than on the front end. Let’s dismiss the cases where that’s
not true, let’s set those aside. I’m sure that there are developers that would
be like, "Oh, let me tell you just how hard it is…" But let’s just accept that
as a generally true statement for the sake of this conversation. It makes me
wonder… I think that’s true too, and I think about how we organize our back
end systems at Bazaarvoice, and how it’s very service-oriented, and there are
pretty clear isolated responsibilities for pieces of the system.

But then you come to the front end and that’s not… The whole system is running
on this one process and this one computer that was sold back in 2008…

**Daniel:** That you don’t actually have access to.

**Rebecca:** Right, that you can’t actually get to. But I wonder, is there
stuff that we can do — and this is just a thought I’m having as I’m talking — is
there stuff that we can do to actually write our code to be easier to diagnose
performance issues? Kind of like we write our back end to have more isolated
areas of concern. We don’t optimize for that. Even in cool, modern tooling, I
don’t know that we optimize for diagnostics at all. Is that a thing? Should we
do that?

**Daniel:** Yeah, that is a super-hard problem. I think there’s been some
movement in this area on the part of browser vendors. Like, the [navigation
timing](https://developer.mozilla.org/en-US/docs/Navigation_timing)
and the [resource timing](http://www.stevesouders.com/blog/2014/08/21/resource-timing-practical-tips/)
APIs are, especially for performance,
incredibly valuable metrics for diagnosing problems in a broad way. I wish
that those APIs were a little bit more attuned to user experience than to
browser life cycles. Like, we’d love to know when Start Render actually
happens on browsers, but you can’t do that — like, those timings don’t really
expose that information, you kind of have to hack it together. I’d love to
have more insight into how the JavaScript Runtime is working. And like
anything in the browser at this point, we want access to lower levels.

So, lately I’ve kind of thought about the browser as being a sophisticated VM
that runs our code, and since the beginning of the web, we’ve gotten more and
more access to the underlying system. So, at first we didn’t even have
execution on the CPU, but then JavaScript came along and we could run
instructions on the CPU, and so on. There are certain things, as the web
develops, that we’ve gotten a lot of access to. We’re talking right now on
this video chat and this website has access to video input, right? But if I
want to make a drawing app, I can’t access the raw input data from the
trackpad. I have to go through the browser’s abstraction over that data, and
it’s low resolution and things.

So, I think getting more access to those lower levels is mostly beset by
security concerns. But the more of the JavaScript, like runtime memory usage,
CPU usage, if there was even basically a built-in way to pull a call graph out
of the code on the browser and send it back to origin to inspect it… Things
like that would go a long way in being able to diagnose bugs and different
issues. We’ve made some attempts to hack those abilities into some of our
systems, but having native access would be ideal.

**Rebecca:** So, if you could just export the state of the DevTools to your
analytics. Hey Chrome, please build that!

**Seth:** Yeah, DevTools is pretty amazing at this point.

**Daniel:** Oh, so good.

**Seth:** And the pace at which they’re adding new features is so awesome. And
it would be great if we could just ship that home, yeah.

**Rebecca:** Yeah, in your own browser, the level of understanding that you
can get of how something is running on your own computer is just mind-boggling
compared to even just a couple of years ago, and certainly to several years
ago. It’s wild. But yeah, when you’re want to know how it’s running on
someone else’s, not so much…

And then you also have all the noise of the internet, right? On the one hand,
that’s what you want to look at, and on the other hand, it’s so much noise and
so much variability that it’s hard to know where to…

**Seth:** Yeah, page loads that take, like, seven days or something like that.
That’s not believable.

**Rebecca:** Right. It’s not believable and you probably can’t fix it either,
even if it is.

So, we’ve talked about performance and we’ve talked about measuring it in the
real world, but do you do anything to measure it in a more controlled
circumstance, and understand "this pull request this commit ruined
everything"?

**Seth:** We don’t do a pull request — we don’t have granular performance
testing pre-deploy. But because we deploy so often, it’s often 30 or so
production deploys a day, and so each of those deploys contains a small
changeset. And then we have a lot of monitoring and alerting around
performance continuously, and then we’re able to correlate when performance
spikes, we can usually track it down to a deploy, which contains some small
number of commits, which makes diagnosing a lot easier.

**Rebecca:** Then are you still doing it against the real world and not
against some sort of control?

**Seth:** Right. We have some synthetic monitoring in place — again, it’s on the
real world and not in a lab environment. But it’s restricted to a few pages.
That’s one of the problems that we have in trying to get accurate assessments
of how the site is performing. It’s a *big* site. It’s broad. There’s a lot of
pages, and then there’s a lot of people who are in different configurations
themselves, like maybe they’re bucketed into certain experiments or maybe they
have a ton of items in their cart, or something like that. There are so many
ways to be experiencing Etsy that it would be hard for us to set up
sufficiently good synthetic conditions to test them ahead of time, which is
what Daniel’s talk is about.

**Rebecca:** [Laughs]

**Daniel:** [Laughs]

**Rebecca:** We’ve talked a bunch about performance, and we could probably
fill up the rest of the show talking about performance, but there’s more
to — the whole point of your team is that there’s more to this than performance,
and so I want to talk about some of those other things.

The biggest one that I think is interesting and not always thought about as
thoroughly as it should be is that developer experience, or as Daniel called
it, just "sanity." And that’s developer experience as far as maintainability,
but also developer experience as far as "How quickly can I experience a thing
about my application that I want to experience? How easy is that? How many
hoops do I have to jump through?" So, can you talk about that a little bit?

**Seth:** Yeah, or "How quickly can I get feedback about a change that I’m
making?"

**Daniel:** Yeah, so we have a handful of irons in the fire in that regard.
So, developers at Etsy, everyone has a VM, and it’s super-easy and fast to
provision new VMs if you need to use a new one for some different task. All
the VMs have a full copy of the latest master cut of the web repo, and then they
also have tons of other shared services, infrastructures, and repos checked
out on them automatically, and those VMs are maintained by [Chef](https://www.chef.io/chef/),
so the fleet is kept up to date.

The VMs run two different services, and they’re both called Bilbo, so this
is a little bit of a funny naming problem. Basically, we have this node service
that runs in the background on all VMs, and is maintained by both Chef and
then its upstart monitors it, and it watches the web repo for changes to
the JavaScript source code and then it does hot rebuilds of those modules,
and anything that depends on them, into the compiled file tree, and in
that way mimics the way that assets are compiled when we deploy.

**Rebecca:** How are you doing those hot builds, just out of curiosity, hot
swapping the modules?

**Daniel:** So, we’re not hot swapping modules inside of the builds because
our JavaScript source tree is very broad and, only in one particular place,
super-deep. So, basically because most of Etsy are traditional LAMP stack
user-facing web pages that have a JavaScript component, we have many small
bundles spread across the site for different kinds of user interactivity and
things, and those go back how ever many years Etsy’s been around.

Then there are a couple of quite large single-page apps that do have pretty
sizeable bundles, and that is a challenge for us right now because those have
gotten large enough that the current compilation strategy, where we just
rebuild the whole file if one of its dependencies changes, is slowing down
people who work on that file.

**Rebecca:** This is a theme I keep hearing as well as I’m talking to people.
So, what are you using to build your JavaScript right now?

**Daniel:** So, this service that we run, which is called Bilbo, is a wrapper
around [RequireJS](http://requirejs.org/), and it basically… We actually still
have some [Sprockets](https://github.com/rails/sprockets) code. So, those who
aren’t familiar with Sprockets and haven’t had the joy of working with
Sprockets, Sprockets was like an early JavaScript module strategy where you
would have a comment pragma and that would just inline the entire contents of
the file that you referenced in the comment into the bundle. And of course you
could share scope and you could have an expression that started in one file
and finished in the other one, or anything you want. So, we’ve been very
slowly remediating those out of the codebase, which is a whole other story.

But mostly things are AMD, and we use RequireJS. So, Bilbo wraps RequireJS
and it does a couple of things. One is that it tracks the dependency graph
so it can intelligently rebuild different things, and the other thing is
that it parallelizes the compilation across worker processes.

**Seth:** And also handles the old Sprockets stuff.

**Daniel:** And handles the Sprockets stuff, yeah.

**Rebecca:** Sprockets, like, predated the asset pipeline, right? Like, that’s
*old* old school, yeah?

**Daniel:** Yeah, it’s no joke.

**Seth:** Well, yeah. In honesty, it’s not Sprockets like you would find on
GitHub. It is that one comment pragma that we then implemented ourselves.

**Rebecca:** I see. Super-special Etsy Sprockets.

**Seth:** Yeah, I call it "Sprockets Style." "In the style of Sprockets… A nod
to Sprockets."

**Rebecca:** [Laughs]

**Daniel:** [Laughs] A nod to Sprockets…

**Rebecca:** So, how do you get code out into the world? You talked about
deploying dozens of times a day. How does that actually work? How does a
developer know that their code is good to ship and then how do they get it out
into the world?

**Daniel:** When I have code that I’m ready to ship, and different teams have
different pathways to getting to the point of being ready to ship, but there’s
nothing formalized that prevents you from basically being, like, "I’ve got
some code. I’m going to ship it now." You join an IRC channel where we
coordinate deploys, and there’s an IRC bot that you talk to, and you join a
push train and it changes the topic of the channel all the time to reflect the
current state of who’s pushing, who’s in the queue to push, who has what role.
One person drives the push; up to eight people can push at a time, and there’s
no technical reason for that limit, it’s just what we’ve come up with as a
good number.

When it’s your turn to drive the push, you open this web app called
[Deployinator](https://github.com/etsy/deployinator), which is actually open
source and it’s on the Etsy GitHub. Deployinator is basically two buttons. We
like to say they’re "push button deploys," but it’s a lie that there’s one
button — there’s actually two buttons. Before you push, everyone coordinates
together and pushes all of their code to master, and once everyone has
reported in the IRC channel that their changes are in master, then the person
driving the push hits a button that does a full build, and the build does
translations, it compiles a bunch of things like templates, it compiles all of
the static assets for the front end, and a bunch of other things like that.

Once that build process is done, it ships all of that code to a web server
that is a production box for all intents and purposes, but is only accessible
internally. Then everyone in the push goes to that box and they manually
verify their changes, and people watch the logs. And then when everyone’s
ready, you push the next button and that actually ships those changes to the
world.

**Seth:** There are also some test steps in that, so…

**Rebecca:** [Laughs]

**Seth:** Well, you can’t avoid it, because when you push to the staging
server, it kicks off a set of unit and functional tests, and then when you
push again to production, it kicks off a set of functional tests.

**Rebecca:** Tell me more about functional tests at Etsy. How much do you rely
on those and what’s your approach there?

**Seth:** Minimally. We have some of the really critical pathways that have
functional tests, and then otherwise we don’t really rely very much on
functional tests.

**Rebecca:** Everyone says that like they’re embarrassed. But everyone says
it, so.

**Seth:** I’m not embarrassed.

**Rebecca:** You’re not? Okay, good. You sounded a little sheepish about it,
or something.

**Seth:** Yeah, I mean, functional tests are slow and brittle… They just are.
[Laughs]

**Rebecca:** [Laughs]

**Seth:** Also awesome! I mean, they have value. They definitely have value.
But they’re…

**Rebecca:** If only they could be fast and work.

**Seth:** Yeah. If only they didn’t require so much work to maintain!

---

**Rebecca:** I want to pause here to thank [SauceLabs.com](https://saucelabs.com)
again for their sponsorship of this show. They brought front end ops to the
forefront with the Front End Ops Conference in 2014, and they continue to make
it possible for us to have insight into how our applications work, or, you
know, don’t work across way more browsers and operating systems than you ever
want to be responsible for maintaining yourself. If you haven’t checked them
out, then just press "pause" and go do it. But first, hit up the
[ttlpodcast.com](ttlpodcast.com) website for your promo code.

---

**Rebecca:** We talked about how you watch for performance changes and you
talked about how hard that is to understand because different users can be in
different configurations or different states. Tell me a little bit about your
A/B testing, what your strategy is for that, and the kinds of things that you
use it for.

**Seth:** So, we rely on A/B testing very heavily for validating new product
ideas. We also use — it’s the same framework — but using a percent ramp-up
strategy for infrastructure changes. We actually have a separate push system
for pushing config changes for ramping up and ramping down experiments or
infrastructure ramp-ups. So, if we do 30 deploys a day of production code,
we’ll do maybe 50 deploys a day of config code.

**Rebecca:** And is that something that the whole stack can participate in,
top to bottom, front to back?

**Seth:** Yeah. The house for the config changes is in the PHP stack, but it’s
very easy to expose that to JavaScript land if you want to fork in your
JavaScript modules, and it’s all available in templates as well. It’s very
seriously embedded in our engineering’s deployment and development strategy
that you use feature flags for your development, whether or not it’s going to
be an experiment. But it will always be an experiment.

So if you’re developing a new feature, the first thing you do is check in an
empty file that only has config flags around it, and a config stanza that says
that it’s disabled, and then go from there. And you develop entirely behind
those config flags until you’re ready to roll it out to a larger audience.

**Rebecca:** Is that something that was built in from the very start, or is
that something that you had to bolt on? How did that go?

**Seth:** It wasn’t from the very start. There was a kind of a re-architecting
that happened starting five or six years ago, and that was when the first
feature flags started to appear, and it was a kind of gradual process from
there. But for three or four years now, I strongly assert that no development
happens that’s not behind a config flag now.

**Daniel:** Yeah, that’s true. I mean, that’s also why functional testing is
such an onerous prospect for us, because there’s all these millions of
branches, and what you get bucketed into totally changes what code paths run
all through the stack, so. We don’t have enough time in the universe,
especially not between deploys, to have a system test all of those
combinations.

**Seth:** Especially if you have an experiment running in the header and one
in the footer, and then two on a page or something. And we’ve started to be
smarter about knowing that maybe two experiments might have interaction
effects, and staggering when we roll them out. So, it’s less common that we’ll
have many, many experiments running on a page at a time, but still, they can
happen any time. They’ll come out of nowhere.

**Daniel:** I think one of the interesting things about that infrastructure is
that the feature flags and configs that we use to do A/B testing, and the ones
that we use to do infrastructure ramp-ups, and the ones that we use to do just
operating behind a closed door while we’re building out a new feature — it’s all
the same infrastructure.

There’s an analytics tool that we have in-house called Catapult that gives you
this incredibly rich set of data across all these different metrics for your
flag versus control. So, even when you’re doing an infrastructure ramp-up, or
if we make a change that we anticipate not having any impact on users on the
front end, we can actually run it as an experiment with this flag and
determine that it hasn’t had any effect. And so we take advantage of that
tooling to do all kinds of work across the infrastructure.

**Rebecca:** So, you guys do a lot to understand the state of your application
in the world. What are you doing to understand errors, especially front end
errors, which in my world, front end errors can — I work on a third-party
JavaScript app — in my world, errors can be my fault or totally the fault of
something else. Maybe you’re in a more clearcut world, but probably not. So,
what do you do to understand them, and get visibility, and react to them?

**Seth:** We’ve had a framework in place for a couple of years where we hook
into `onerror` handlers and try to capture these errors in the browser, and
beacon them back home and do some kind of intelligent analysis on them.
Unfortunately, it has not been intelligent enough.

One of the things you, as a developer, use to gain confidence that you haven’t
broken anything when you deploy is a tool called Supergrep, which is
basically just a logtailer of all of the aggregated error logs, and it
includes these errors coming in from the browser. But almost universally
everyone turns off that feature.

**Rebecca:** [Laughs] Why?

**Seth:** Because they don’t trust that it’s telling them anything actionable
or necessarily real; actionable because maybe it’s some Chrome extension or
whatever throwing some crazy errors, or actionable because there’s no path to
diagnosing how this is happening, or whether it’s your fault, or whether it’s
new. You know, maybe this is an error that’s been happening for years and then
all of a sudden some scraper comes along and starts scraping the forums or
something crazy, and starts throwing a huge volume of errors at you all of a
sudden.

**Rebecca:** Is the nature of that difficulty just the fact that you’re using
an `onerror` handler? And do you do anything more within your code to say, "At
this moment, I’m in a bad state, and so I’m going to phone home"?

**Daniel:** When I started at Etsy almost two years ago, we were in a
particularly bad place with regard to what Seth is saying. Like the logs we
were getting from `window.onerror` were so incredibly noisy because of all of
these other bad actors in the execution environment. Not necessarily bad
actors, although *some* bad actors. But just, like, poorly-behaved extensions
or bookmarklets or whatever throwing… And, to a lesser extent even, it’s like
if there’s a problem loading a Facebook widget and there’s an error, those
things can end up in your logs.

So, we started trying to clean that up, and we looked at a lot of different
options. One of the big reasons that it wasn’t actionable was
originally you would get stack tracers in window.onerror, and then that got
removed as a security concern if you were serving your assets from a different
domain. And we serve our assets from a static asset host on a different
domain, and all of a sudden we weren’t getting any stack traces…

And there was this gap in time between when that happened and when browsers
actually started to support CORS headers for those errors. During that time,
we looked at a lot of different options for getting better visibility into
what was going on with those failures, and one thing we talked about was
trying to actually add try/catch blocks in strategic places into our
compilation step and use those to extract better information.

Before that happened — and we basically made incremental steps — we never tried
that. Thankfully we didn’t have to. The browsers have implemented cross-origin
request headers for stack traces, and we turned those on a few weeks ago and
have been getting tons more actionable items, and that’s totally transformed
things.

But even before that, we approached the analysis side first. So, we were
getting this huge volume of logs, and someone who actually did a bootcamp with
us, who’s a specialist who works on the Hadoop team,
[Andrew Johnson](http://andrewjamesjohnson.com/), he did a
bunch of work in cleaning up the kind of server-side angle of how we were
collecting those failures. Basically, what we’ve implemented is kind of a
manual set, which is that we have a set of filters that we can add to through
a config push that control what is and isn’t going to actually show up in the
logs that we care about. And we use that to blacklist domains and also regex
for particular strings in the error message that we then can throw away.

**Rebecca:** And so is the system at a point where you can use it for, like,
"it’s red, it’s green," or does it still require a lot of human analysis?

**Daniel:** It’s all human right now. But we have a lot of confidence that
things aren’t super-broken on the client-facing site based on secondary
metrics. And so the secondary metrics are, like, we can see that user activity
hasn’t shifted in one or another bucket that we really look at. We monitor so
many things that we have a lot of confidence that the system is operating in a
healthy way based on general signals. But we want red/green for specific
files, and that is just a thing we haven’t done yet.

**Rebecca:** Someday. Well still, by and large it sounds like you guys are
quite a bit ahead of the game relative to where a lot of other people are, so
be grateful.

So, my last question that I’ll put out to both of you is we talked earlier
about just how much DevTools have changed, for example, and I feel like, even
looking back three years, it’s a really different world than it was three
years ago. What do you think we’re going to take for granted three years from
now that is hard today?

**Seth:** Well, I feel like one of the things that we are struggling with,
that I think a lot of companies are struggling with, is fragmentation of user
agent. So, we have a mobile web experience, we have a desktop web experience,
we have an iOS app, we have an Android app, we have tablets and iPhones, and
now Apple watches, and cars with screens in them or whatever. And especially
the kind of web versus iOS versus Android fragmentation — that is a difficult
problem right now.

Projects like [React Native](https://facebook.github.io/react-native/)
are really promising in that regard. I don’t know that they have solved it —
we haven’t had a chance to play with it, so we don’t know if they’ve solved
it. I would be surprised if the first ones out of the gate have solved it for
real. But I feel like that is a thing that we’re struggling with now that I
have hopes that in three years will feel like it’s a much different story. I
imagine that it’ll still be something that we’re bemoaning to some degree. But
I would really love that in three years we feel like it’s a much different
story.

My hope would be similar to how responsive web is pretty much the thing that
people now. There are still people who say that it’s not the best
solution. Let me rephrase that: it’s maybe not universally accepted, but
there’s less of a debate about it these days versus three years ago, and I
hope that we can get into some similar… So, something that is like
whatever the responsive web of device fragmentation is, I hope that we
have one of those in three years.

**Rebecca:** [Laughs]

**Daniel:** Yeah, agreed. Well put. Yeah, that definitely is a huge one in
terms of what seems to be very — that’s a zeitgeist problem right now, so I
think it will be a different world in three years, whatever that actually
looks like.

Other than that, I think a big one is [HTTP/2](https://http2.github.io/).
I think there’s kind of a combination, which is like HTTP/2, which we won’t
all really be able to use until like the last clinging grasp of the legacy
browser goes away and we’re really building for Evergreen browsers, in large
part, that have HTTP/2.

There’s a lot of things that we take for granted now
that I think that’s going to kind of throw away. I’m sort of excited to see
what the things are that we haven’t thought of yet that HTTP/2 is actually
going to sort of necessitate or make possible.

**Rebecca:** Yeah, [when I talked to Alex](http://ttlpodcast.com/episodes/alex-sexton.html),
I think he said, "Everything you know about performance just kind of goes out
the window with HTTP/2," and that’s exciting and scary…

**Daniel:** Mhm, totally.

**Seth:** Yeah. So, I was talking about some changes that we made for
performance reasons that then got us looking at the front end infrastructure
as a whole, and one of those first changes was moving all of our JavaScript
script tags to the bottom of the page for performance. And it turned out that
that was a real big pain to do across the site with confidence, and as I was
doing it, [SPDY](http://en.wikipedia.org/wiki/SPDY) was coming out and there
was all of this HTTP/2 thing, and I was like, "How do I *not ever* do this
again?" But it’s impossible, right? "How do I anticipate the ways that the web
platform are going to change so that I don’t ever have to make these local
changes?"

I feel like that is not going to be a thing that I fix, like I will still have
to worry about it. But I hope that the implementation that we have means that
the other engineers here don’t have to worry about it. I hope that we have, at
this point, gotten to a place where we’ve sufficiently abstracted how
JavaScript is loaded that other people don’t worry about and it’s just
Javascript.

**Rebecca:** Well, cool. On that note, thank you both so much for being here.
This was a fantastic show. It’s good to catch up with you again, and I hope I
bump into you sometime somewhere. Maybe we can take another cab ride together.
We’ll see.

**Daniel:** Yeah, come visit us in New York.

**Seth:** Yeah, there’s lots of cabs here.

**Rebecca:** [Laughs] No trouble getting one. Alright, I’ll keep that in my
mind. I’m hoping sometime soon to make it up there, so I’ll say hi. Alright,
thanks guys!

**Daniel:** Thank you.

---

**Rebecca:** The TTL podcast is edited by Morgan Murphey. Website design by
Una Kravets. Thanks again to Sauce Labs and Travis CI for sponsoring the show,
and a special thanks also to Bazaarvoice. For music and other credits, visit
ttlpodcast.com. I’m Rebecca Murphey. See you next time.
