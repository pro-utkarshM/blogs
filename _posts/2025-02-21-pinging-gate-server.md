---
layout: post
title:  "Pinging the Exam Server"
categories: jekyll update
tags: system-design 
---

### **I Tried Pinging the GATE Exam Server—Here’s What I Found**  

So, picture this: I’m sitting in a TCS iON exam center, just finished my Electronics GATE exam, and my brain is running on 5% battery. But instead of walking out like a normal person, I had one last nerd urge—what if I ping the exam server?

So, I had window fired up, ran a quick ping, and boom. No response. Server disconnected. 🤯

Now, this got me thinking—how exactly does this whole exam system work? Why couldn’t I reach the server? And more importantly, how do they lock this system down like Fort Knox? And it got me thinking..

🧐 **How does this system stay secure?**  
🧐 **Where do my answers go?**  
🧐 **Can I hack this?** (*spoiler: no, but I tried anyway*)  

After finishing my paper, I **pinged the network** and got a **10.0.0.x** response—meaning, the system was running on a **private LAN** with no internet access. **The server was disconnected after the exam ended**, which got me thinking:  

📌 **How does this whole system actually work?**  
📌 **How does every candidate get a different question sequence?**  
📌 **Where do our answers actually go?**  

I did some digging, and here’s **everything I uncovered** about the **TCS iON exam system**—from **high-level architecture** to **low-level network security**. Buckle up. 🚀  

---

## **The High-Level System Design (How It All Works)**  

<img alt="HLD" src="/public/media/HLD.png">

If you thought you were just logging in and answering questions, **you’re wrong**. You were actually interacting with a **multi-layered, distributed system** designed to be **unhackable** (almost).  

### **🖥️ The Main Characters (System Components)**  
Imagine the whole exam system as a **movie** with these key players:  

🔹 **Your Exam Computer** → The **dumb terminal** that runs a locked-down browser (No Alt+Tab, no Task Manager, no fun).  
🔹 **Local Exam Server** → The **boss of the exam center** that handles all candidates' data and syncs with the cloud.  
🔹 **Central Cloud Server** → The **overlord sitting in a data center** collecting responses from every exam center.  
🔹 **Proctoring & Security System** → Watches your every move, records keystrokes, and makes sure you aren’t cheating.  
🔹 **Firewall & Network Security** → Ensures **you can’t hack your way in** (yes, I tried).  

### **🛠️ The Exam Flow (What Happens Behind the Scenes)**  

1️⃣ **Candidate Authentication**  
- You log in using your credentials (sometimes biometric verification).  
- The system checks if you’re legit before loading your paper.  

2️⃣ **Question Paper Distribution**  
- The **local exam server fetches** your exam questions from the **TCS iON cloud**.  
- **Your question sequence is randomized** (more on that later).  
- The exam **runs on a locked-down browser** that prevents screen-sharing, copy-pasting, or opening anything else.  

3️⃣ **Answer Storage & Auto-Saving**  
- As you answer, responses are first **saved locally on your machine** (in a cache or temp database).  
- The local server **periodically syncs your answers** over a **private LAN** connection.  
- Every answer gets pushed to the **central cloud** in batches.  

4️⃣ **Network Security in Action**  
- You’re inside a **private LAN (10.0.0.x network)** that only connects to the **local exam server**.  
- No Internet. **No escape.**  
- **Firewall rules block** all unauthorized traffic.  

5️⃣ **Exam Ends & Data Sync**  
- The moment the exam ends, your computer **disconnects from the local server**.  
- The **local server pushes all final responses** to the **TCS cloud**.  
- Your machine gets **reset for the next candidate**—everything wiped.  

🔥 **In short:** This isn’t just an exam—it’s a **well-oiled, military-grade data pipeline** running across thousands of centers **in real time**.  

---

## **The Low-Level System Design (Nerd Territory) 🚀**  

<img alt="LLD" src="/public/media/LLD.png">

### **1️⃣ Candidate’s Computer (Locked-Down Exam Machine)**  
Your exam PC isn’t really **yours**—it’s a **highly restricted machine** designed to do **one thing: run the exam**.  

🔹 **Runs a locked-down browser** (probably a Chromium fork like Safe Exam Browser).  
🔹 **Disables all external access** (USB, clipboard, print screen, Alt+Tab, everything).  
🔹 **Only connects to the local exam server** (not the internet).  

**Tech Stack:**  
✅ OS: Windows/Linux (locked down)  
✅ Browser: Custom Chromium-based secure browser  
✅ Local Storage: IndexedDB / SQLite / Temp File  

---

### **2️⃣ Local Exam Server (The Exam Center’s Brain)**  
This is the **real boss** inside your exam center.  

🔹 **Runs a secure Linux server (Ubuntu/CentOS).**  
🔹 **Stores all candidate responses** in a **temporary database** (PostgreSQL/MySQL).  
🔹 **Periodically syncs with the cloud** over a **secure VPN tunnel**.  
🔹 **Blocks all unauthorized access** using **firewall rules**.  

**Tech Stack:**  
✅ OS: Linux (Ubuntu/CentOS)  
✅ Web Server: Nginx/Apache  
✅ Database: PostgreSQL/MySQL  
✅ Security: OpenVPN, Firewall Rules  

---

### **3️⃣ Central Cloud Server (The Overlord) ☁️**  
This is where **ALL exam data is stored permanently**.  

🔹 **Collects responses from thousands of exam centers.**  
🔹 **Uses AI-powered proctoring** to flag cheating.  
🔹 **Stores everything in an encrypted database.**  
🔹 **Runs on a cloud provider (AWS/Azure/TCS Cloud).**  

**Tech Stack:**  
✅ Cloud Provider: AWS/Azure/TCS Cloud  
✅ Backend: Java/Python  
✅ Database: Encrypted PostgreSQL  
✅ Security: AES-256 Encryption, VPN  

---

### **4️⃣ How Every Candidate Gets a Different Question Order**  
TCS iON uses **dynamic paper generation + randomization** to make sure **no two candidates get the same question sequence**.  

🔹 **Question Bank with Metadata**  
- Questions are pre-stored in a **centralized database**.  
- Each question has **tags like difficulty level, topic, and weightage**.  

🔹 **Shuffling Algorithm at the Local Server**  
- Before the exam, your **question paper is generated dynamically**.  
- The system **randomizes the sequence** while ensuring **equal difficulty balance**.  
- This means:  
  ✅ **Your neighbor gets a different question order.**  
  ✅ **Even if someone memorizes a paper, it’s useless.**  

🔹 **Security Hashing to Prevent Tampering**  
- Each question set has a **unique hash/checksum** to prevent manipulation.  
- Even if someone tries to tamper with their paper, the system **catches it immediately**.  

🔥 **In short:** Your exam paper is **randomized, secured, and dynamically generated**, making it nearly impossible to cheat.  

---

## **Final Thoughts: Why This System is a Fortress**  

🔥 **You can’t hack it:**  
- No Internet access, only a **private LAN**.  
- Firewall rules block **everything** except exam traffic.  
- VPN tunnels **encrypt all data** before it hits the cloud.  

🔥 **You can’t cheat easily:**  
- **Question orders are randomized.**  
- **AI monitors everything** (keystrokes, webcam, mouse movement).  
- Your exam system is **fully locked down**.  

🔥 **You can’t crash it:**  
- **Local caching** ensures answers are saved.  
- **Load balancing** prevents overload.  
- **Auto-scaling cloud servers** handle massive traffic.  

So yeah, when I **tried pinging the server**, it basically said: **“Nice try, buddy.”** 😆  

TCS iON didn’t just build an exam system.  
They built a **freaking cybersecurity fortress.** 🚀  

---

**That’s it! Hope you enjoyed this deep dive into how the GATE exam system works.** Let me know if you want **more nerdy breakdowns like this!** 🔥