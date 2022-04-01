# Private Events

> **Note:** Due to Heroku's aggresive sleep configuration for web dynos, initial load time may be longer than expected.
>
> **Warning:** Due to the nature of public, anonymous submissions, they may contain explicit or inappropriate content. You may report any content using any method of contact listed at the end of this README.

A mobile-friendly website where registered users may create private or public events, and mark events they are attending.

## General Information
Private Events is the place to host your next event! Users may host or attend events. Events may be public or private, and only invited users may access or attend private events. Anyone may access or attend public events.

Upon registration, users may choose their time zone from the dropdown list, with the current time displayed for the selected zone (for cross-reference). The website will attempt to automatically select proper time zone.
Events may be viewed, edited or deleted, depending on permissions the user has.

This project was created in Rails, with Devise for user authentication.

## Installing / Getting Started
> Prerequisites:
> * Ruby >= 3.0.3
> * Rails >= 6.1.4.6
> * Bundler >= 2.3.6
> * PostgreSQL >= 13.5

```bash
git clone https://github.com/Eduardo06sp/private-events.git
cd private-events/
bundle install
bin/rails server
```

Then visit http://localhost:3000/ to view the project.

## Features
* Log in/out
* Sign Up
* Create/edit/delete events
* Indicate you will be joining an event
* Create private events only visible to invited users
* Select time zone during registration
* Events will display in selected user time zone
* Responsive design

## Reporting Issues/Feedback/Contact
Bug reports are greatly appreciated. You may create a new issue with a simple description of the problem, and any steps leading up to it.
PRs are kindly appreciated.

You may also email me at: eduardopelaez@pm.me

## Acknowledgements
* [The Odin Project](https://www.theodinproject.com/home), my favorite, highly-recommended resource for learning full-stack web development
  - For providing this project idea ([see the instructions for this assignment here](https://www.theodinproject.com/lessons/ruby-on-rails-private-events))
  - For their kind, amazing Discord community
* Vecteezy artist Lincung Studio for [the creative bird mail illustration](https://www.vecteezy.com/vector-art/4677423-a-bird-mail-illustration-colorless-cartoon-for-drawing-and-coloring-activities-fun-activity-for-kids-development-and-creativity-object-isolated-on-white-background-in-vector-design) used as the logo
* Vecteezy artist Burhan Adiatma for [the wonderful open envelope design](https://www.vecteezy.com/vector-art/5191239-god-odin-mascot-viking-illustration) modified for use as the favicon
