---
layout: post
title:  "Part 0: Introduction-Compiler"
categories: jekyll update
tags: compiler projects software-dev

---
# Part 0: Introduction 

Hello there, I hope you'll are doing fine well I finally have gained the courage to start this project (it took about 2 weeks to convince myself to even start this, I wanted to start this project after I placed a bet against my friend ;D). I've never written a compiler that can compile itself. So that's where I'm headed on this magical journey(i am listening to Harry Potter Book-3 E04).

As part of the process, I'm going to write up my work so that you'll can follow along. This will also help me to clarify my thoughts and ideas. Hopefully you, and I, will find this useful!

 
## Goals of the Journey

Here are my goals and non-goals (i don't want to make a project which will hunt me for the rest of my life) for the journey:

- **Write a self-compiling compiler:** If the compiler can compile itself, it qualifies as a *real* compiler.
- **Target real hardware platforms:** I want my compiler to work on actual hardware, and if possible, support multiple backends for different platforms.
- **Practical over theoretical:** I aim for a practical approach, though I will introduce theoretical concepts when necessary.
- **Keep it simple:** Following Ken Thompson's principle: "When in doubt, use brute force."
- **Take small steps:** Breaking the journey into small, manageable steps to make each addition to the compiler more digestible.

## Target Language

Choosing a target language is challenging. High-level languages like Python or Go require implementing extensive libraries and classes. While languages like Lisp can be compiled easily, I've decided to write a compiler for a subset of C. This subset will be sufficient to allow the compiler to compile itself.

C is just a step up from assembly language, making the task of compiling C code down to assembly somewhat easier. Additionally, I like C.

## The Basics of a Compiler's Job

A compiler translates input from one language (usually high-level) into another language (usually lower-level). The main steps are:

![Compiler Steps](/public/media/compiler-steps.jpg)

1. **Lexical Analysis:** Recognize lexical elements or tokens.
2. **Parsing:** Recognize syntax and structural elements to ensure they conform to the grammar of the language.
3. **Semantic Analysis:** Understand the meaning of the input, different from just recognizing syntax and structure.
4. **Translation:** Convert the input into a lower-level language.

## Resources

### Learning Resources

For books, papers, and tools on compilers, I recommend:

- [Curated list of awesome resources on Compilers, Interpreters, and Runtimes](https://github.com/aalhour/awesome-compilers) by Ahmad Alhour

### Existing Compilers

I'll look at other compilers for ideas and possibly borrow some of their code:

- [SubC](http://www.t3x.org/subc/) by Nils M Holm
- [Swieros C Compiler](https://github.com/rswier/swieros/blob/master/root/bin/c.c) by Robert Swierczek
- [fbcc](https://github.com/DoctorWkt/fbcc) by Fabrice Bellard
- [tcc](https://bellard.org/tcc/), also by Fabrice Bellard and others
- [catc](https://github.com/yui0/catc) by Yuichiro Nakada
- [amacc](https://github.com/jserv/amacc) by Jim Huang
- [Small C](https://en.wikipedia.org/wiki/Small-C) by Ron Cain, James E. Hendrix, and derivatives by others

In particular, I'll use a lot of ideas and some code from all the compiler.

## Setting Up the Development Environment

For those who want to join the journey, set up your favorite Linux system. I'll use Ubuntu 23.10.

I'm targeting two hardware platforms: Intel x86-64 and 32-bit ARM. I'll use a PC running Ubuntu 23.10 for Intel and a Raspberry Pi running Raspbian for ARM.

On the Intel platform, we'll need an existing C compiler. Install it with:

```sh
$ sudo apt-get install build-essential
```


## The Next Step

In the next part of our compiler writing journey, we'll start with the code to scan our input file and find the *tokens* that are the lexical elements of our language.
