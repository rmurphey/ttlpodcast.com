## Transcript

*Transcription by Seth Lavelle.*

**Rebecca Murphey**: Okay, let’s do this! Was I too loud?

**Alex Sexton**: No.

**Rebecca**: No? Can’t be too loud. Alright. Uh… Cool. Hey, Alex.

**Alex**: You should intro the podcast.

**Rebecca**: I should intro the podcast?

**Alex**: Yeah, unless you do it in post.

**Rebecca**: I thought I might do that in post. You want me to do that right now?

**Alex**: I’ve listened to [a few podcasts](http://yayquery.com), and some just start
out and other ones kind of start with the ad, and then they say "We have a
really great show for you today with Alex Sexton. I got to go over to his
house, I met his dog, we had some tacos, and… Here it is."

**Rebecca**: Uh huh. How do you know they don’t do all of that later?

**Alex**: They do do that later, because they’re talking about what they talked about.
Like, "It was a great conversation…"

**Rebecca**: But I don’t know that yet.

**Alex**: Right, so you could do that later, but…

**Rebecca**: Hello, I’m Rebecca Murphey and this is the TTL podcast. Today on the
podcast, we have Alex Sexton. Alex is a product engineer at
[Stripe](https://stripe.com/) and the curator of the [TXJSConference](https://2015.texasjavascript.com/) in **Austin**: The TTL podcast is brought to you by the fantastic folks at
[Sauce Labs](https://saucelabs.com/), the cloud-based automated testing platform
that makes it possible to test your app across browsers as part of your
continuous integration or continuous delivery workflow. Plus, they give
you manual access to more than 500 browser platform combinations. Try it
for free today. Visit [ttlpodcast.com](http://ttlpodcast.com) for a promo
**code**: And by [Travis CI](https://travis-ci.org/). With Travis CI, you can test and
deploy with confidence. Sync your GitHub projects with Travis CI and
you’ll be testing your code in minutes. Travis CI is offering a free trial
to the first 10 listeners of this episode who sign up with the promo code
**on [ttlpodcast.com](http://ttlpodcast.com)**: Hey Alex.

**Alex**: How’s it going?

**Rebecca**: It’s going great. It’s like we haven’t been talking for the last twenty
minutes.

**Alex**: We haven’t. There were no tacos involved.

**Rebecca**: No tacos, no chasing the dog, no nothing. So you… You left me. You were at
[Bazaarvoice](http://www.bazaarvoice.com/); you brought me to Bazaarvoice, and
then you left me. Now you’re at Stripe and you’ve been there for a while. What
do you do?

**Alex**: I am officially a product engineer at Stripe, which means that I am on a
team that used to be called the product team, which doesn’t exist anymore, but
we haven’t changed our names. More or less, I do everything that’s kind of our
user-facing. So, I could work on the API, or I could work on our dashboard, or
anything like that. There’s a special team that does more end user stuff and
there are people that do money transferring and operations and systems, so
kind of like user end of things.

**Rebecca**: If I remember right, when you showed up there, you kind of changed
everything about that, yes? No?

**Alex**: That would probably be not true. I think I changed the build process on one
of their applications, maybe two eventually.

**Rebecca**: Oh, just one? You made it sound a lot more impressive at the time.

**Alex**: I was probably just trying to get everyone to like me or something.

**Rebecca**: What did you change?

**Alex**: When Stripe started, like the way a lot of businesses start, it’s not really
appropriate for you to necessarily care about right away some things that I
care about, which is why don’t ever start a startup with me. But things like
build tools, dependency management, performance, and security are things that
are immediately important to me even though they aren’t actually very
important to a business right off the bat.

**Rebecca**: You’re the only person I know who has a [super-secure blog](https://alexsexton.com/).

**Alex**: Well, I was giving a talk on content security policy and I didn’t want
people to go to my website after seeing me talk on content security and then
see that I didn’t even use it myself. It’s like Politics 101, right?

**Rebecca**: What did you change up about that process?

**Alex**: Most of our build stuff was baked into some—it wasn’t Asset Pipeline—it was
Sprockets. It was all very Ruby based because initially it didn’t have a ton
of specific front end people. Eventually they kind of got there and it was
right when CoffeeScript was coming out, and so all the modules were kind of
just like "Wrap everything in an IIFE and give it a global name, and
concatenate it all together." It was kind of just "Put everything in this set
of folders into the page as a blocking script."

**Rebecca**: Seems good.

**Alex**: Honestly, it was probably perfectly fast for a really long time, and then we
became a 100-person company and ten people were adding stuff to that file
every day, and it just grew, and grew, and grew and became something that
users started to notice. What we wanted to do was move over to some real
module system, some real dependency management so that we could get rid of any
cruft that was there, and then also have a real dependency tree and be able to
load things asynchronously. And then even stuff like content security policy
is somewhat important in the payment space.

**Rebecca**: You don’t say. So, what’s the technology now?

**Alex**: It’s nothing too interesting because I needed to do it quickly and it just
needed to be fast. The builds were getting very slow because I had to compile
CoffeeScript for everything on every rebuild, there was no partial rebuilding.
You add one debugger statement and then you wait a minute and a half—that was
a pretty sad world there for a little bit. But I think up until that point, it
didn’t necessarily make sense for the business to invest in that. That was
part of the reason why they hired me. I’m not saying anyone did anything
**wrong. I think they did it more right than I ever would have.

But I moved it over to just a [Grunt](http://gruntjs.com/) build system with
some of the normal stuff, but what I did was I added—I think there’s
several GitHub issues where people go through it and there may be a blog
post or something, but there’s no official support for rebuilds in Grunt.
So, what you do is you add a watcher and then you catch events on what
files changed and then you have a custom array that is just the most
recently changed array that is empty initially in your Grunt file for the
CoffeeScript builds, and then at the event time, you add that stuff to
that array and then you run that thing again. You’re essentially on the
fly changing your Grunt file in order to just catch the files that have
**changed and only rebuild those.

Then you have to do all of the temporary file stuff yourself, you have to
have a temp directory and do all of that stuff. Something like
[Broccoli](https://github.com/broccolijs/broccoli) now,
you’ll see they actually have a temp directory with all sorts of generated
stuff. I, more or less, built a worse, terrible version of that by hand. But
other than that, it’s mostly just a normal Grunt setup. It wraps everything
in; it was all common JS but I used Require because I could do things
asynchronously still. So, the build process just adds a quick AMD wrapper for
synchronous requires.

**Rebecca**: I have like ten questions from everything you just said. You talk about how
it doesn’t make sense for a startup to care about this kind of stuff, and
that’s the thing—I always feel weird talking about this stuff because you
shouldn’t care about it up to a certain point, and I don’t want to go have
someone pay me money to do this when they don’t actually need it. How do you
know where the line is?

**Alex**: I feel like it’s an amortized cost. If you have someone who can make
performance-enabled builds and websites right off the bat and it doesn’t take
them any longer to do that, then don’t intentionally sabotage them. If I’m at
a startup, it makes sense for me to use Broccoli in a way that I already know
how in order to do partial rebuilds that are good right off the bat, and just
build everything in a way. But it doesn’t necessarily make sense, if you don’t
have that expertise, to sit down, stop building your product, and learn
**performance over the top of that stuff**: Part of it is hiring and part of is what are your core goals? If you’re
someone in some space where speed really matters… If you’re looking for
advertising dollars, for instance, speed is maybe something you want right
upfront. But if you provide value in a different way… Speed will always help
your product be better and people will like it more. But people will like your
product more if it works than if it’s fast and doesn’t work. It’s really hard
to talk about because it’s like "No, you should always care about this stuff!"
And you should, but you should have a prioritization list and ship things fast
and do all that kind of stuff.

**Rebecca**: You also said that "No one did anything wrong," and I know that feeling too,
of how you show up to a project and it’s not what you would do right now, but
you understand how it got there. For example, the project that you left me
with. [Laughs]

**Alex**: Yeah, I left you with one of those.

**Rebecca**: You left me with one of those. And I totally get how a project ends up in a
place that’s not ideal when you know what you know now, but of course you
didn’t know that when you were working on it, or there was a deadline or there
were other pressures.

**Alex**: Usually a deadline. I think it was November 1st, 2012.

**Rebecca**: November 1st. I wasn’t even there and I still know that. With that caveat,
how would you build what you have if you were building it today, from the
build and deployment?

**Alex**: It definitely depends on the project. On some side project stuff, I actually
intentionally try to use tools I’ve never used before. I don’t really want to
go down that path right now, but we can go down that path later. But I think
there are new good tools that aren’t there yet that will be there and will be
the chosen things. What I’ve come across—and I think you wrote
[an article about Dojo](http://rmurphey.com/blog/2010/08/09/on-jquery-large-applications/) a long time ago that’s along these lines, and I wrote
[the competing article](https://alexsexton.com/blog/2010/08/on-rolling-your-own-large-jquery-apps/) about putting pieces together. I mean, mine did way better but I kind
of agree with you.

**Rebecca**: [Laughs]

**Alex**: But I really have found some joy in finding tools that the community uses.
Like, even if I know [The Intern](https://theintern.github.io/) is better than
[Karma](http://karma-runner.github.io/0.12/index.html), or such and such build
tool is easier for me to use, I just bite the bullet and say "It’s actually
easier for my team to use this one that’s 99% as good," and then I can make it
better if I really have a problem with it.

**Rebecca**: You’re all grown up. [Laughs]

**Alex**: Yeah. My goal right now is to not stray from best practices for a specific
community. So on an [Ember](http://emberjs.com/) app, use the tools that
[Ember CLI](http://www.ember-cli.com/) provides and that
the community uses, and then you get documentation for free, you get upgrades,
and you get integration for free. You just end up writing so much code that
you can actually focus on those differences in the two different tools. The
time that you would have spent integrating the tool that you like better, you
could just add those features to the one that’s better for the team anyway.

**Rebecca**: Yeah, and then if there is an active and vibrant community, then you can
also contribute back to it and see your work have value to other people rather
than embracing a tool that doesn’t have popularity.

**Alex**: Exactly. It would also help a lot for a situation, like when I had you come
into Bazaarvoice and left a few months later, to where you wouldn’t actually
need me to state dump for a month on the reason why everything happened. It
would just be "Oh, everyone does the things that they did. They just never
finished." Or that they used to do that and the community has upgraded their
best practices and we just need to follow what the community did.

**Rebecca**: I think that’s the thing that’s changed a lot though in the last couple of
years. There are still popularity contests, but those popularity contests are
based a lot more in "Does this work?" and "Does this solve our problem?" and
we have a bigger view of what those problems are than what we had a couple of
years ago.

**Alex**: For application architecture, especially for single-page applications and
stuff like that. Even if Dojo had more of a head start than something like
jQuery plus Backbone plus whatever I was saying at the time, it still wasn’t
like what we have today with full build systems and every part of the equation
starting to be figured out for us.

**Rebecca**: I set up a toy project last weekend and was just floored. At first I was
sitting in my chair and thinking "Oh God, I have to set up this and this, and
I have to write a Grunt file and ehhh…" And then I realized that I could just
have [Yeoman](http://yeoman.io/) do it for me and suddenly I had this whole working
environment just *there*. And that’s another thing that I feel like has changed in the
last couple of years, that the starting is a lot easier than it used to be.

**Alex**: I wonder how easy it is for someone who’s never set up their own Grunt file,
to just have Yeoman dump a Grunt file and then they have to change one thing.
They’re like "I mean, it works but I can’t change anything…"

**Rebecca**: "But I don’t know what to do…"

**Alex**: But I think that’s still a better spot than "Alright, learn how to use Git,
then learn how to use NPM, then learn how to use this, then learn how to write
in files, then learn how to exit out of Vim, and then…"

**Rebecca**: What I learn a lot from seeing something done and then going in and tweaking
it—I used [React](https://facebook.github.io/react/) and I used
[Webpack](http://webpack.github.io/) for that little toy project, and having a
working application that I could just type `grunt serve` and it was working, and
then I went and played with it and did what I needed to do was so much easier.
Even going through the React tutorial, which is actually pretty good, it was
just easier to have something that just worked on the machine right now and
**then I could make what I needed to make**: So, do you work at all on Stripe JS, the thing that I put onto my page if I
wanted to use Stripe?

**Alex**: Yeah, so Stripe JS is kind of like where you want to build your own form and
you don’t really want people to necessarily know that Stripe is the one doing
credit cards, but you can’t have credit card data ever hit your servers
because then you’ll be a higher level in PCI scope.

**Rebecca**: What’s PCI?

**Alex**: PCI (Payment Card Industry) is the payments, accounts, I don’t know,
whatever. It’s the people who make the rules of how you need to handle
technology around credit cards. Specifically, it’s like the card issuers, like
Visa and MasterCard. It’s not actually a legal thing. There’s no law that says
you can’t take credit cards. You could get sued for fraud if you’re committing
fraud, but just being unsafe on your website with credit cards is not against
the law, it’s against PCI. Then they could just shut down your ability to
accept cards because they are the card issuers.

**Rebecca**: [Laughs] Which is worse than jail.

**Alex**: Sure. Maybe. Probably not, actually.

**Rebecca**: Do you work on Stripe JS?

**Alex**: I didn’t write the initial Stripe JS. I think Alex MacCaw, it’s his history.
A very smart gentleman named James Reggio works on it now mostly. But I
upgraded it recently to use all sorts of new workarounds for new PCI rules, so
there’s a lot of cross-domain communication involved and all of that stuff.
Because, more or less, the way it works is we send the credit card numbers
directly to Stripe from your web page and then send you back a token, and then
you post your form with the tokens instead of with the credit card number and
the CDC.

**Rebecca**: But because it’s JavaScript, that’s not easy.

**Alex**: Yeah, dealing with cross-domain communication is always an interesting
challenge.

**Rebecca**: How far back do you have to support?

**Alex**: At the beginning of my update, we supported back to IE6, but luckily POODLE
came out and more or less killed IE6 across the entire internet. So, then it
was IE7 and up.

**Rebecca**: Can you do that again? Can you find one of those for IE7 and maybe IE8?

**Alex**: Actually, I honestly think there should just be like a bounty among large
companies. Everyone just throws into this pot—maybe I can make it work with
Stripe.

**Rebecca**: Kickstarter. I would give money.

**Alex**: I mean, Kickstarter uses Stripe too, so that’s fine.

**Rebecca**: [Laughs]

**Alex**: But yeah, and then you just pay out the person who finds a thing that just
makes everyone shut off IE7 and IE8 support across the internet because it
just literally makes it too unsafe to use.

**Rebecca**: I would pay money for that.

**Alex**: Yeah, for sure. A lot.

**Rebecca**: So cross-domain messaging is a thing that you’re pretty into. Can you tell
us about different techniques that you use—well, to the extent that you’re
allowed to tell us about the different techniques. It’s just JavaScript. I can
go read it, right?

**Alex**: Yeah, it is. It’s technically not open source but it is readable. So, I did
a bunch of cross-domain JavaScript stuff at Bazaarvoice because Bazaarvoice is
kind of like [Disqus](https://disqus.com/) but for reviews. You just drop a
script tag on the page and then all the reviews need to come from
Bazaarvoice’s API and then be injected into the page, and rendered, and all of
that stuff. So, I got my schooling in cross-domain JavaScript then. I reviewed
the *[Third-Party JavaScript](http://thirdpartyjs.com/)* book with Ben Vinegar
and Anton Kovalyov, and so I thought I knew all the things about cross-domain
communication.

**Rebecca**: And then you had to do it with credit cards.

**Alex**: Yeah…

**Rebecca**: With something like Stripe JS, you’re in the checkout path. So, you’re in
the critical path for purchase. What are the performance concerns with that?

**Alex**: They’re high. We can’t ever slow down anyone’s page. But luckily you don’t
really need Stripe to be executable until the person presses "buy," and so
rarely are we in the actual critical rendering path. So you’re going to say
"load us" and by the time they fill out all their credit card information,
we’re almost definitely loaded.

**Rebecca**: So you just become part of the cost of post-buy click at worst.

**Alex**: Yeah. And even then, the thing that people are most willing to wait for on
the entire internet is their credit card to go through, which is nice. We
rarely have any complaints about that, unless we actually are timing out or
something like that. But it’s something that we watch and try to make as fast
as possible because it’s such a good experience. Next time you’re at Target
and you swipe your card—well, don’t do that because they’ll leak all your
credit card information again—

**Rebecca**: [Laughs] You’re going to get me sued.

**Alex**: What is that, libel? I don’t think it’s libel if it’s true. But watch how
fast your credit card gets approved compared to 7-11 or Walgreens. You swipe
and it’s instant. It’s like they’re doing local approvals of credit cards and
then taking on the risk of denying it. I don’t understand how it’s that fast.

**Rebecca**: Or it’s just approving everything and taking on the risk. So try that with a
credit card that doesn’t have any money on it and see what happens.

**Alex**: Yeah, and it doesn’t get slower. It’s milliseconds, and that’s at the POS
(point-of-sale system). It’s just interesting. You don’t realize how much you
like it. So I wonder if once everyone is that fast, then it will start
mattering more.

**Rebecca**: How big is that file? You say it doesn’t matter a whole lot, but how big is
that?

**Alex**: It used to be very small.

**Rebecca**: But you’re doing XDM. That gets big.

**Alex**: Yeah. So, it used to be very small. I don’t how much I can say here, but it
used to be 4K or something like that, which is very small to me. And now,
well, I hacked [easyXDM](http://easyxdm.net/wp/) to help to where it’s very
small as well, but I needed a JSON implementation for old IE and that kind of
stuff, and so it’s just over 10, maybe 12, something like that. Still within
the [single first frame](http://chimera.labs.oreilly.com/books/1230000000545/ch02.html#TCP_FLOW_CONTROL). But still, three times as large, which is crazy and
bad and I hate it. But our priority was making sure nothing broke for anyone,
and then we can put out v3 of the file, which is actually good and can support
modern versus legacy but in a different way. But sometimes when you need that
hotfix to be compliant on January 1st, you eat up an extra 8K or something.

**Rebecca**: This is a Batman break.

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

**Rebecca**: This is probably more applicable for the dashboard, but maybe also for
Stripe JS, but what do you do at Stripe for knowing how your application is
doing, especially the client-side app?

**Alex**: We have different monitoring and metrics for different things and all of
them are in various stages of goodness. But I think they’re still pretty
helpful where they’re at, and you can always get better at that kind of stuff.
We don’t have something necessarily like [SpeedCurve](https://speedcurve.com/)
or [WebPageTest](http://www.webpagetest.org/) that we run automatedly, which I
would love to get to. But we also don’t have a ton of user-facing things. It’s
more dashboard-y type stuff, so it’s harder to measure single page apps like
that. It’s not like a page load with an article and time difference tweet. So,
those are a little less valuable for us, even though I think there’s still
some stuff I think we could do there.

**Rebecca**: What do you think about doing real world measurement of that, like sending
metrics live from people using the app?

**Alex**: We have an opt-in method for different client. If someone complains or
someone has an SLA or something like that, we’ll have them turn on our
RUM—enable RUM=true on Stripe JS—and that will measure all the requests and
all of that kind of stuff. Not necessarily initial load of the actual file,
that’s pretty easy to measure, best and worst case scenarios, etc. But more
along the lines of "The tokenization process took X number of seconds for a
user," and in our testing it took half of that. So, "Is Australia worse," or
whatever, etc.

**Rebecca**: Do you do any of that for the dashboard or just for Stripe JS?

**Alex**: We have some things in the dashboard that we really care about that are more
manually instrumented, so some stuff with initial load. Part of the reason why
the dashboard UI hasn’t gotten a ton of performance love outside of just what
is big and easy is because there’s so much data and a lot of the time the data
is our bottleneck. The subsequent loads of the dashboard are actually what you
care about more than the initial load. Whenever you load up the filtered
charges by "this with disputes that have invoices," that index is just really
hard to nail to the point where most of our performance work is outside of the
realm of the normal line of where 80% of your time is client-side.

**Rebecca**: Because your dashboard app, once it’s loaded, it’s loaded and then the data
is the expensive thing.

**Alex**: Yeah. Not that that other stuff doesn’t matter. And even stuff like painting
and re-rendering is a problem in our current dashboard, and that’s stuff we’re
addressing in some of the new work we’re doing. But it has never been the
bottleneck, and it’s all about "Tools, not rules." Our tooling seems to
indicate that for most pages, the request to get the chart data is taking
longer than it is to render the chart and load in the chart library.

**Rebecca**: When I gave a talk at Front End Ops Conf about measuring performance data in
the real world, someone either right before or right after me kind of
completely burst my bubble and talked about the importance of *not* measuring
performance in the real world, and measuring it in controlled conditions. I
don’t remember who it was, but I talked to him afterwards.

**Alex**: I think he was promoting a very reasonable approach of both being extremely
important and relying on one is really silly. The controlled stuff is great
for the "why," and the real world stuff is great for the "what." So, you can
see that in the real world people are having some huge issues loading your
stuff, but the level of granularity and the ability to reproduce that stuff is
essentially zero, right? And so the more you can see what people are actually
running into in the real world, the more you can go look at those parts of
your controlled tests and see if you can exacerbate those issues and get them
down in your controlled test where you can actually repeat it.

**Rebecca**: What do you do first? If you’ve got one person who’s going to be able to
work on this, where do you start?

**Alex**: Controlled test, probably. If you had one person working on something,
you’re not international and you’re not seeing a lot of clients. It’s more
like fundamentals.

**Rebecca**: I mean one person working on performance. God help you if you have one
person working on everything. [Laughs] You’d have other problems, right?

**Alex**: Even so, I think it’s hard to act on real user metrics without controlled
metrics. You can always act on controlled metrics and they will help. It’s
never going to hurt you to make your automated metrics get smaller, faster.
But it’s really hard to know what to do necessarily with real user data only.

**Rebecca**: We’ve talked about performance, we’ve talked about monitoring, we’ve talked
about builds and deployment a little bit. We haven’t talked about testing. We
talked about choosing tools around that, but we haven’t really talked about
what you’re doing and what’s hard about that. I know you have opinions about
what is hard and annoying about testing.

**Alex**: Everything, right? Having to do it.

**Rebecca**: Are you a TDD? That’s a joke—I know you’re not.

**Alex**: I am. BDD, TDD, I don’t care.

**Rebecca**: But you write your tests first?

**Alex**: Don’t get me wrong, I don’t do it. But I feel like that’s the right way.
Does that make sense?

**Rebecca**: [Laughs] Yes.

**Alex**: Like, if I was telling someone the right way to do it, I’d be like "Do
that." But hell if I’m going to do that.

**Rebecca**: Have you ever done it?

**Alex**: For very small things.

**Rebecca**: It’s kind of fun though.

**Alex**: It’s great. I took an AI class, and I did a genetic algorithm in order to
solve algebra equations. It’s the slowest way to do algebra because computers
can just do math out of the box, and so you shouldn’t just guess a bunch of
times until you get it right. But that’s what I did, and it was very slow and
fun. I was like "I could make a genetic algorithm for everything." Then I
realized that the hard part about that is there’s a definitive answer to an
algebra problem, there’s 100% you can get correct, and you can get closer to
the correct answer over time. You have to solve it with math first and then
**solve with it to know that it worked**: But I feel like testing is the same way. If you have something like a
specification where you can say "I need the following inputs to cause the
following outputs 100% of the time. Here’s how you handle this, and this, and
this," and that’s like you scoring 100. Like, "I implemented this
specification." That’s so great for TDD. So for something like [messageformat](https://github.com/SlexAxton/messageformat.js/),
which I built to do internationalization stuff, it’s like "These brackets do
this, when this is here it does this, you have these following options. These
things have to output this." So it was very easy to write my test suite before
I ever wrote anything. But for an application that is more touchy/feely, that
does more random things…

**Rebecca**: I get it but I don’t know if I buy it. Because maybe if you say that your
application is touchy/feely, that does a bunch of random things, if you write
your code like that then that’s going to be a mess, right? Can you write user
interface application code like you write message format?

**Alex**: No. Not with any speed or efficiency. I don’t know, I’m sure you can. I’ve
just been doing it for a long time and there are some fundamental differences.
You can unit test code and you can do all of that stuff, but just knowing up
front that you want some class name to be the cause of the close where a
button—you have to have the full visual design in your head. For
infrastructure, sure. Like, "Here’s how view creation works and here’s how
hierarchy works, and here’s how…" I think Ember’s test suite is a very good
example of unit tests for weirder things like that.

**Rebecca**: I just wrote [a blog post](http://rmurphey.com/blog/2015/03/23/a-baseline-for-front-end-developers-2015/) recently about an update on a post that I wrote
three years ago, and it was kind of amazing how much had changed in three
years. I think that three years is an interesting timescale to think on because
that lets some of the stuff shake out. We can talk about this stuff showing
up, but the fact is I’m still dealing with IE8, at least for a couple more
months. So in three years, here’s hoping I won’t be. What are we going to take
for granted in three years?

**Alex**: I think there’s always going to be an IE8. It was IE6, it was Netscape, it
was always something. It was old Android, which is still a problem. I think in
three years, you’ll have old Safari—post-Blink Safari, especially on mobile.
It will still have the best gradients still but not have any of the APIs that anyone
wants to build cool, native, competing apps. I would love for it to get
internationalization tooling, and service workers, and streams. But you have
no visibility into there. My gut is that in three years we’ll take for granted
that Safari was ever a browser that kept up.

**Rebecca**: I meant take for granted in a good way. [Laughs] I don’t mean what will be
terrible in three years. But what problem do we have now that just won’t be a
problem in three years?

**Alex**: I think stuff around build tools, like in a lot of different ways. So,
partial rebuilds are something that we’re finally catching up to `make` with
Broccoli, and people can implement it in [Gulp](http://gulpjs.com/) and Grunt
on their own. I think as applications get bigger, people will be like "Oh my
god, I do not want to wait this long for my app to rebuild each time." So I
**think that will be a required feature of any build tool in three years**: Also in that world, the whole CommonJS/AMD thing should be more or less dead
by then. I’m sure Node will still be holding out on
[ES6 modules](http://www.2ality.com/2014/09/es6-modules-final.html). But for the
most part, the tooling will be there where anyone can author an ES6 and it
**will be fine, even if someone needs to convert to Common**: Most importantly though, [HTTP/2—SPDY](https://http2.github.io/) is already
out—but HTTP/2 with HTTP push and things like that, you can kind of throw
away a ton of our best practices, even to the point where some of our best
practices become bad practices.

**Rebecca**: And you’re talking around the strategic loading of assets for client side
apps, right? Everything you’ve taught me goes out the window pretty much?

**Alex**: Yeah, pretty much. Because with push, you can kind of say "Along with the
initial application render, as you’re pulling down HTML, also start pulling
down the following files that I promised you that I’m going to try and load
later." Then you can [service worker](http://www.html5rocks.com/en/tutorials/service-worker/introduction/) the hell out of them.

**Rebecca**: And this is all happening on one connection, it just kind of stays open.

**Alex**: Yeah, across one pipe, and so multiple requests don’t matter, asynchronous
loading doesn’t matter.

**Rebecca**: There’s no renegotiation of any of it, it’s all just one pipe that’s open
the whole time.

**Alex**: Yeah, assuming you’re sending from a single server. I think there will be
still some tricks around. Like, "I have a CDN with this versus an application
server that does different things."

**Rebecca**: Last thing: there’s a conference that you and I know a little bit about. Do
you want to tell us about that?

**Alex**: Rebecca started TXJS in 2010.

**Rebecca**: We were going to have it in a church. Do you remember that? [Laughs]

**Alex**: Yeah, well it was a free location. Anyone would run their conference in a
free location. But yeah, you had just run North Carolina and you were like
"Let’s do it where you live." Then after one year, you were like "Maybe it’s
easier if the person who runs it lives in the state," and so I kind of took it
over for the next three years. I skipped last year because I had run Front End
**Ops Conf with Sauce Labs and then also I was in San Francisco for the summer

This year it’s back and we’re doubling up on the goodness of everything.
July 24th. We have two people from the UK, so you already know it’s going to
be good. The accents, that’s big. Jake Archibald and Alice Bartlett. We have
Rushaine McBean. We have all three core people from the major frameworks.
So, we have Pete Hunt from React, we have Tom Dale from Ember, and we have
Brian Ford from Angular. I kind of hate shootouts at conferences, like "This
is why our framework is good! This is why *our* framework is good!" So I asked
them to do a reverse shootout, and what they’re going to all talk about is
what they stole from the other libraries, which I’m really looking forward to.
I feel like we have another speaker. There was eight on the page. Oh, Jenn
Schiffer! I just skipped over Jenn Schiffer real fast. She won’t listen to
**this**: But it’s in Austin, it’s at the Paramount Theatre, which is downtown. They
do a lot of Comedy Central Presents there, so it’s a legit theatre, and
there’s a marque and everything.

**Rebecca**: Will there be police tape down the street this year?

**Alex**: There was only one murder scene outside of a TXJS and that was in 2011, so
I’d really appreciate it if you didn’t bring it up every year. We are also
avoiding the motorcycle rally.

**Rebecca**: So there will be no crime at TXJS. And no one at TXJS was harmed, so that’s
a key thing to point out. Well Alex, thank you. This has been a treat. It was
some front end ops and some web stuff.

**Alex**: You should really edit it down. [Laughs]

**Rebecca**: Yeah, I absolutely will.

**Alex**: I know how to talk.

**Rebecca**: Yeah, you do. You’re good at that. Alright, thank you.

**Alex**: Yeah, thanks. Good job running a podcast.

**Rebecca**: We’ll see how it goes. Bye.

---

The TTL Podcast is edited by Morgan Murphey. Website design by Una Kravets.
Thanks again to Sauce Labs and Travis CI for sponsoring the show, and a
special thanks also to Bazaarvoice. For music and other credits, visit
TTLPodcast.com. I’m Rebecca Murphey. See you next time.

