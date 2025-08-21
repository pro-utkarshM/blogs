---
layout: post
title:  "Inside the Hedera (HBAR) App"
categories: jekyll update
tags: opensource 
---

# Architecting Hardware Wallet Firmware Like a Hacker: Inside the Hedera (HBAR) App 

If you’ve ever built embedded firmware, you know the rules are different. You’ve got kilobytes of RAM, zero room for mistakes, and attackers who *really* want to steal secrets. And if you’re building firmware for a hardware wallet? Forget it. Everything you design is a target.

So, let’s tear into a real-world example: the Hedera (HBAR) app running on the Cypherock X1 hardware wallet.

I’ll show you how this thing is architected — from the first line of code that says “hey, I’m the Hedera app” to the last byte that gets signed and sent back to the host. Along the way, I’ll point out the security traps, the modular tricks, and how this exact design doubles as a blueprint for adding *any* new blockchain in the future.

---

## 1. How apps even exist inside the firmware

The Hedera app isn’t its own standalone binary. It’s a **plug-in** that lives inside a much bigger firmware runtime. The core firmware handles all the heavy lifting: seed reconstruction, key derivation, secure UI, comms with the host, wiping secrets, etc.

The app itself? It’s just coin-specific logic.

That handshake with the firmware starts with this descriptor struct:

```c
static const cy_app_desc_t hedera_app_desc = {
    .id = 24, // unique ID for Hedera
    .version = {.major = 1, .minor = 0, .patch = 0},
    .app = hedera_main, // entrypoint
    .app_config = NULL
};
```

The system controller sees this and says: “Cool, app #24 is live, and if someone sends it a request, I’ll forward it to `hedera_main()`.”

That’s the pattern. Every new coin you add? Same deal: define your descriptor, point to your router, done. Zero changes to the firmware core.

---

## 2. Talking to the outside world: Protobuf or die

The host (desktop/mobile app) talks to the wallet using **Protocol Buffers (Protobuf)**. Why? Because if you’re on an embedded device, you need:

* A contract (schema) that’s unambiguous
* A binary format that’s compact
* Codegen for both C (firmware) and TypeScript/Python/etc. (host)

The Hedera app has an API layer (`hedera_api.c`) that’s basically a translator:

* `decode_hedera_query()`: takes raw bytes from the host → typed C struct
* `hedera_send_result()`: takes struct → bytes back to the host
* `hedera_send_error()`: unified error signaling

This layer exists so the rest of the app doesn’t care about Protobuf at all. It just deals with clean C structs.

And here’s the kicker: if you want to add a new coin, you just swap in your `.proto` schema and regenerate. No hand-rolled parsers, no spaghetti.

---

## 3. The real action: signing a transaction

Here’s where firmware either wins or dies: transaction signing.

The Hedera app’s signing flow (`hedera_txn.c`) is designed around one principle: **What You See Is What You Sign (WYSIWYS)**.

Let’s break it down:

### Step 1. User consent

The host says: “Sign this txn for wallet X at derivation path Y.”
The wallet says: “Hold up — user, do you approve this?”
No tap = no signature. End of story.

### Step 2. Store the raw bytes

The host sends over a serialized Protobuf `TransactionBody`. The firmware **immediately stores the exact raw bytes**. That’s what’s going to be signed. Not some decoded struct. Not some re-encoded copy. The *original host-sent bytes*.

### Step 3. Decode for display (never for signing)

The firmware decodes those raw bytes into a C struct, but only to display details to the user. If the decoder has bugs? Doesn’t matter. Because the signature is still over the original byte array.

### Step 4. User verification on device

The firmware now walks the decoded struct and displays:

* The operator account (payer)
* Every transfer (from/to, amounts)
* The fee
* The memo

It formats data using helpers (`hedera_format_tinybars_to_hbar_string()`, etc.) so you don’t see “100000000 tinybars” but “1.0 HBAR.”

The user physically checks each screen. That’s WYSIWYS. If anything’s off, they cancel.

### Step 5. The cryptographic hammer

Only after all that does the firmware touch the keys:

1. Reconstruct seed in volatile RAM.
2. Derive child key via BIP-44 (`m/44'/3030'/…`).
3. Guardrails (`hedera_derivation_path_guard()`) ensure you can’t sneak in a Bitcoin path and trick the wallet into signing Bitcoin data with a Hedera key.
4. Call `ed25519_sign(raw_txn_bytes)`.
5. Wipe the seed/private key (`memzero()`). Gone from RAM.

### Step 6. Send signature

The raw 64-byte Ed25519 signature goes back to the host. Done.

---

## 4. The hidden genius: why this scales

Here’s the magic: Hedera is just one app. The architecture is so modular that adding a new coin is literally filling in blanks.

If you were adding “NewCoin,” here’s the recipe:

1. **Constants:** Define coin index, unit, derivation path guard, ticker.
2. **Helpers:** Address formatting, unit conversion, validation.
3. **Protobuf schema:** Define txn + pubkey request/response.
4. **API layer:** Boilerplate wrappers.
5. **Core logic:**

   * Export pubkey flow (verify → format → send).
   * Sign txn flow (store raw bytes → decode for display → show user → sign raw).
6. **Main descriptor:** Register your app with the firmware.

Notice what’s missing: you never rewrite seed management, UI code, or comms. That’s all core firmware territory. You just bring your blockchain’s quirks.

---

## 5. Why this matters

The Hedera app isn’t just “support for HBAR.” It’s a living case study in how to:

* Keep secrets volatile and wipe them immediately.
* Enforce WYSIWYS in hardware.
* Avoid parser bugs from becoming signature bugs.
* Build coin apps like plug-ins, not hacks.

This is the kind of architecture that scales: one codebase, many coins, all with consistent, auditable security guarantees.

Future coins — whether they’re UTXO-based like Bitcoin, account-based like Ethereum, or weird ones like Hedera with Protobuf bodies — can all fit the same mold.

That’s how you build firmware that lasts.

---
