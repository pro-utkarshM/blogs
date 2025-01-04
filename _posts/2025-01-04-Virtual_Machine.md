---
layout: post
title:  "Build a Virtual Machine in C"
categories: jekyll update
tags: VirtualMachine opensource
---

# **Let’s Build a Virtual Machine in C! A Fun Dive into Low-Level Programming**

Hey there, tech adventurers!

Have you ever wondered what makes your computer tick? Or how all those magical "instructions" get processed under the hood? Well, you're in for a treat because today, we’re building our very own **Virtual Machine (VM)** from scratch!

Don’t worry if this sounds daunting—it’s a learning journey, and we’ll take it step by step. Grab your favorite beverage, crack your knuckles, and let’s get coding!

This is my source code [github.com/pro-utkarshM/KEMU](https://github.com/pro-utkarshM/KEMU).

---

## **What Exactly is a Virtual Machine?**

Imagine having a tiny computer… inside your computer! That’s what a VM is. It emulates a real machine, complete with its own:
- **CPU**: The brain that crunches numbers.
- **Memory**: Where it stores its thoughts (data, programs, etc.).
- **Instruction Set**: Its language, like "MOVE this" or "ADD that."

Think of it like a retro gaming console you program yourself. How cool is that? 

---

## **Step 1: Setting Up Our VM Playground**

Let’s get the boring-but-essential stuff out of the way:
1. **Create a Project**: Use your favorite setup, or if you’re feeling fancy, try making a template which you can use to setup any C project.
2. **Tools You’ll Need**:
   - A Linux system (or WSL on Windows).
   - A solid text editor (VSCode, Vim, or even Notepad++ if you're feeling rebellious).
   - GCC for compiling our masterpiece.

---

## **Step 2: Meet the CPU, the Star of Our Show**

The CPU is like the VM’s brain, so let’s give it some smarts! Here’s how we’ll represent it in code:

```c
typedef struct {
    uint16_t AX, BX, CX, DX; // Registers for holding data
    uint16_t SP, IP;         // Stack Pointer and Instruction Pointer
} CPU;
```

- **Registers (AX, BX, etc.)**: Think of them as tiny sticky notes for quick calculations.
- **SP & IP**: These are the navigators. The stack pointer (SP) keeps track of temporary data, and the instruction pointer (IP) tells the CPU what to do next.

---

## **Step 3: Building a Tiny Brain for Memory**

Our VM will need memory to store its programs and data. Let’s give it a modest 64 KB of space (plenty for our little project!):

```c
#define MEMORY_SIZE 65536
uint8_t memory[MEMORY_SIZE];
```

Yes, it’s just a big array, but hey, every great journey starts with a single step, right?

---

## **Step 4: Speaking the VM’s Language**

Now comes the fun part: teaching our VM how to understand instructions. Here’s the blueprint for its “language”:

```c
typedef enum {
    OP_MOVE = 0x01,  // Move data
    OP_ADD  = 0x02,  // Add numbers
    OP_NOP  = 0xFF   // Do nothing (but look cool doing it)
} OpCode;

typedef struct {
    uint8_t opcode; // What to do
    uint8_t args[2]; // The details (like where to move data)
} Instruction;
```

### Example: MOVE Instruction
Let’s say you want to move the number `42` into the `AX` register. Here’s what the instruction would look like:
- Opcode: `0x01` (MOVE)
- Args: `[AX, 42]`

Easy peasy, right?

---

## **Step 5: Making the VM Work**

Now it’s time to make our VM actually *do stuff*! This is where we interpret the instructions:

```c
void execute(CPU *cpu, uint8_t *memory, Instruction instr) {
    switch (instr.opcode) {
        case OP_MOVE:
            cpu->AX = memory[instr.args[0]];
            break;
        case OP_ADD:
            cpu->AX += memory[instr.args[0]];
            break;
        case OP_NOP:
            // Chill, do nothing
            break;
        default:
            printf("Unknown instruction: 0x%02X\n", instr.opcode);
            break;
    }
}
```

Here’s the magic:
1. The CPU reads an instruction.
2. It decodes it.
3. It performs the action, like moving data or adding numbers.

Boom—your VM is alive!

---

## **Step 6: Let’s Write a Program for Our VM**

Let’s give our baby VM something to do. Here’s a simple program:
```c
Instruction program[] = {
    {OP_MOVE, {0x10, 0x00}}, // Move value at memory[0x10] to AX
    {OP_ADD, {0x11, 0x00}},  // Add value at memory[0x11] to AX
    {OP_NOP, {0x00, 0x00}}   // Do nothing
};
```

### Load and Run the Program
1. Load the program into memory:
    ```c
    void load_program(uint8_t *memory, Instruction *program, size_t size) {
        memcpy(memory, program, size * sizeof(Instruction));
    }
    ```
2. Initialize the CPU and execute:
    ```c
    CPU cpu = {0};
    for (size_t i = 0; i < sizeof(program)/sizeof(Instruction); i++) {
        execute(&cpu, memory, program[i]);
    }
    printf("AX: %d\n", cpu.AX); // Should print 15
    ```

You just wrote a VM program!

---

## **Challenges and Lessons Learned**

Building a VM is no cakewalk, but it’s incredibly rewarding. Here’s what you’ll face:
- **Debugging Pointers**: Be prepared for the occasional head-scratching moment when something crashes.
- **Balancing Simplicity and Power**: The instruction set needs enough features without becoming a beast to manage.
- **Optimization**: Figuring out how to make your VM run smoothly is an art.

But don’t sweat it—it’s all part of the learning process. And trust me, the "aha!" moments make it worth it.

---

## **What’s Next?**

Congrats on building your VM! Now, the sky’s the limit. Here are some ideas to level up:
- **Add More Instructions**: Implement new opcodes like `SUB`, `JUMP`, or even basic I/O.
- **Create an Assembler**: Write a tool to translate human-readable code into your VM’s bytecode.
- **Introduce Multithreading**: Why stop at one CPU? Let’s make this baby multitask!

---

## **Final Thoughts**

Building a virtual machine is like creating your own mini-universe—a tiny computer that you control. It’s challenging, sure, but also ridiculously fun. Whether you're experimenting or building this as part of a larger project, pat yourself on the back for diving deep into systems programming.

Thanks for coding along! Did you enjoy this guide? Share your thoughts (or VM success stories) in the comments. Until next time, happy coding!

