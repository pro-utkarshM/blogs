---
layout: post
title:  "My Notes on Linux Kernel"
categories: jekyll update
tags: Linux-Kernel Notes

---
Hello there, I am making notes on Linux kernel I hate reading books and other people notes, well I am refering Linux Kernel Development by Robert Love, The art of Linux Kernel Design by Yang Lixiang, The Linux Kernel Primer by Claudia Sakzberg Rodriguez, [The Linux Kernel Teaching](https://linux-kernel-labs.github.io/refs/heads/master/index.html), and their official documentation.

## The Process:
Program executing in the system.
Thread of execution(its a special process) has:
    Unique Program Counter
    Process Stack
    Set of Processors register
### Process related system call
    fork(): creates new child process done by clone() system call
    exec(): create new address and loads the program into thoes addresses
    wait(): enables a process to wait for termination of specific process.
    exit(): Terminates the process, frees the resources.

> Kernel internally calls a process Task

## Process discriptor & Task struct:

Task struct-> task list & process discriptor
process discriptor-> stores the information about a process that kernel needs.
    pid
    parent_pid
    open files
    process address space
    pending signals
    process state
    .
    .
    etc

## Allocating Process discriptor (task_struct)
* allocated dynamically by "SLAB ALLOCATOR"-> it catches the process making it easy for kernel to use it.
    wihtout this "object_based_allocator"--> kernel will spend to much time allocating, initialisiing and freeing the same object.
* provides object reuse and cache coloring

## struct thread_info
* lives at bottom (in stacks that grow down)
* lives at top (that stacks that grow up)

![alt text](/public/media/thread_info_stack.png)

#### struct thread_info
* it has a pointer to process discriptor.
* has fixed address (easy for kernel to find)

## Storing the Process discriptor:
+ PID (type pid-t): usually an integer, can be changed at the boot time.
    maxvalue--> max value of processes that can live on the system concurrently.
+ /proc/sys/kernel/pid_max :: (mine 4194304): in a working a system (not in a compiled kernel --> it is still untouched by any machine).

+ wrap arround: pid's will overlap when we increase the number of pid's possible on a machime.
+ current macro: masking out 13 LSB bits of kernel stack pointer to get current_thread_info() function.

> visit :: /init/init_task.c --> /task_struct init_task :: first task to run on a system 