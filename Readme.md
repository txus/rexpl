# rexpl [![Build Status](https://secure.travis-ci.org/txus/rexpl.png)](http://travis-ci.org/txus/rexpl)

**rexpl** is a sandbox to experiment and play with the [Rubinius](http:://rubini.us)
Virtual Machine and its bytecode instructions. It comes wrapped in a REPL
(Read-Eval-Print Loop) à la IRB, so that anytime you can open a terminal,
fire up **rexpl**, and start playing with instant feedback.

This intends to be a fun tool to use when learning how to use Rubinius
bytecode instructions, for example when bootstraping a new language targeting
the Rubinius VM for the first time.

Its main feature is **stack introspection**, which means you can inspect
what the stack looks like after each step of your instruction set.

![Rexpl](http://dl.dropbox.com/u/2571594/rexpl.png)

## How to use it?

Needless to say, **rexpl** runs only on Rubinius. Thus, your first step is to
install it. Go to the [Rubinius website](http://rubini.us) to find how, or if
you are using RVM, just follow [this instructions](http://beginrescueend.com/interpreters/rbx/).

    $ gem install rexpl
    $ rexpl

Now you should see a welcome banner and an IRB-like prompt, and you're good to
go! Just start typing some [VM instructions](http://rubini.us/doc/en/virtual-machine/instructions/)
and see what happens!

There are three extra commands to take advantage of the stack introspection:

* `list` lists the instruction set of the current program.
* `reset` empties the instruction set and starts a new program.
* `draw` prints a visual representation of the stack after each instruction of
your program.

## When to use it?

Imagine you are bootstrapping a new language targeting the Rubinius VM and you
just implemented a particular AST node, but when you try to run the tests, you
keep getting nasty stack validation errors. Net stack underflow? What the heck
does this even mean? Where the hell is that extra `pop`? Did this or that
instruction consume stack? Or maybe produce it? Oh fuck it, let's go fishing.

Don't panic. You always have your friends pen and paper ready to help you out,
Read through the source code, and knowing what each instruction does, try to
follow along and draw what the stack looks like at each step (does that sound
familiar to you?). Or just fire up **rexpl**.

## Resources

Documentation is online here:

* [Rexpl documentation](http://rdoc.info/github/txus/rexpl/master/frames)

##Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Josep M. Bach. See LICENSE for details.

