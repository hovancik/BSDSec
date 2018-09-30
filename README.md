## BSDSec
[![Code Climate](https://codeclimate.com/github/hovancik/BSDSec/badges/gpa.svg)](https://codeclimate.com/github/hovancik/BSDSec)
[![Become a patron](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/bePatron?u=2449338)

### Motivation

This app is hobby project to learn more about <i>[RubyOnRails](http://rubyonrails.org/)</i> and do something possibly useful for <i>BSD community</i>.

Any [criticism](https://github.com/hovancik/BSDSec/issues) very welcome. Please check my blog about BSD at https://DiscoverBSD.com

### Current Status

App does receive emails (with [Griddler](https://github.com/thoughtbot/griddler) and [Mailgun](https://mailgun.com), then save it as Article and Tweet about it (with [Twitter](https://github.com/sferik/twitter) gem):
* FreeBSD
* OpenBSD
* NetBSD
* MidnightBSD (since Oct'14)
* pfSense (since Oct'14)

DragonflyBSD, PC-BSD doesn't seems to have any announce mailing list or Security Announces (let me know if it change).

App has very simple design, whatever-device friendly. (<b>Any designer here?</b> Would love to get some logo maybe ;] At least for favicon.)

#### How it works
* As I mentioned, this is a Ruby on Rails app.
* to be able to use mail, I use [Mailgun](https://mailgun.com) with [Griddler](https://github.com/thoughtbot/griddler) gem.
* I subscribe lists with my Gmail address and then make a filter to resend the messages.
* Other stuff used: [FontAwesome](http://fontawesome.io/) for icons, [NewRelic](https://newrelic.com) to check it out how it works.  
* Hosted on [Heroku](https://heroku.com/) free tier.


So the only money I paid was for Domain, so far.

### TO-DO
* (always in prgress) code refactor ;] (anyone?)
* check other BSDs for SA
* (done, later removed - http://reddit.com/r/bsdsec) create reddit /r for discussions (so it would be on reddit, app and tweets would have link to it )
* create command line app (eg.: <tt>bsdec --tag freebsd --time week</tt>)
* (done) upgrade Griddler to version 1
* make method for adding more tags (like BSDCan, LibreSSL etc. ) as right now it's just freebsd for FreeBSD list etc...
* testing
* (done)  RSS
* (done) google analytics (when sure with basic funcionality, start pushing master branch only)

## Join!

Pull Requests are very welcome.

I do love learning new stuff and I hope this can become community project. I would like to get some testing on so this all would become much easier.

## I see ... Errors!

Use [Issues](https://github.com/hovancik/BSDSec/issues), so we all can see and figure it out!

## License

Copyright © 2014 Jan Hovancik <conta.srdr@gmail.com>

This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.
