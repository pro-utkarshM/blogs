---
layout: post
title:  "Network Design: E02 (VLANs / Virtual Networks)"
categories: jekyll update
tags: network-design notes
---
TODO: ADD IMAGES

Hello everyone, welcome back to this tutorial on building a professional network using Linux. In the last blog, I explained the fundamentals of networking. In this blog, I want to expand on that by talking about virtual networks, specifically VLANs (Virtual Local Area Networks).

When managing a large network with hundreds or thousands of machines, it's often necessary to control which machines can communicate with each other for security reasons. For example, you might not want every machine to be able to communicate with every other machine. This control helps to prevent security issues and reduce unnecessary broadcast traffic, which although less of a problem with modern fast networks, can still be optimized.

A common security concern involves devices like printers, which are often vulnerable to attacks. If a printer gets infected with malware, it could potentially attack other machines on the network. Since there aren't typically antivirus solutions for printers, it becomes crucial to segment the network to limit such risks.

VLANs allow us to create these segments or sub-networks within a larger network. By using VLANs, we can control which devices can communicate with each other. Here's how it works:

### How VLANs Work

1. **VLAN Tagging**: Each port on a switch can be assigned a VLAN number. When a device sends data through a port configured for a specific VLAN, the Ethernet frame gets tagged with the VLAN number. For example, a packet sent from a port on VLAN 3 will be tagged as VLAN 3.

2. **Switch Processing**: When a switch receives a tagged frame, it processes it based on the VLAN tag. If the receiving port is configured for the same VLAN, the frame is forwarded. If not, the frame is discarded.

3. **Trunk Ports**: To allow communication between VLANs across multiple switches, we use trunk ports. A trunk port can carry traffic for multiple VLANs. Trunk ports are configured to allow tagged frames, meaning they can forward frames that include VLAN tags.

### Configuring VLANs

Let's look at a practical example with TP-Link TL-SG108E switches, which are not industrial strength but sufficient for demonstration.

1. **Initial Setup**:
    - Connect the switch to your network and log in using the default credentials (typically admin/admin). Change the password as prompted.
    - Connect your devices (e.g., laptop and Raspberry Pi) to the switch ports.

2. **Enabling VLANs**:
    - Access the switch’s web interface.
    - Enable 802.1Q VLAN configuration.
    - Create VLANs (e.g., VLAN 2, 3, and 4) and assign ports to these VLANs. Ensure ports that connect to other switches (trunk ports) are tagged.

3. **Assigning Ports to VLANs**:
    - For each VLAN, assign the appropriate ports. Use tagged mode for trunk ports and untagged mode for ports connected to devices.
    - Configure the switch to ensure packets from VLAN 2 can only be received by ports configured for VLAN 2.

### Example Configuration

Let's say we have two switches connected together. We'll configure VLANs on both switches:

1. **Switch 1**:
    - Port 1 (trunk port to Switch 2) is tagged for VLAN 2, 3, and 4.
    - Port 3 (laptop) is untagged for VLAN 4.
    - Port 4 (Raspberry Pi) is untagged for VLAN 4.

2. **Switch 2**:
    - Port 7 (trunk port to Switch 1) is tagged for VLAN 2, 3, and 4.
    - Other ports configured similarly for their respective VLANs.

3. **Trunk Ports Configuration**:
    - Mark the ports connecting the two switches as trunk ports and allow VLAN 2, 3, and 4 traffic.

### Testing the Configuration

- Connect your laptop to the switch and ping the Raspberry Pi. If everything is configured correctly, devices on the same VLAN should be able to communicate, while devices on different VLANs should not, unless specifically configured to do so.

### Advanced Configuration: VLAN on Raspberry Pi

To further illustrate, we can configure a Raspberry Pi to handle multiple VLANs:

1. **Install VLAN Package**:
    ```bash
    sudo apt-get install vlan
    ```

2. **Configure Network Interfaces**:
    - Edit `/etc/network/interfaces` or create files in `/etc/network/interfaces.d/` for each VLAN.
    - Define virtual interfaces (e.g., `eth0.2` for VLAN 2).

3. **Assign Static IP Addresses**:
    - Assign IP addresses to each VLAN interface.

4. **Restart Network**:
    ```bash
    sudo systemctl restart networking
    ```

This setup enables the Raspberry Pi to act as if it has multiple network interfaces, each on a different VLAN, allowing it to communicate with devices in multiple VLANs.

### Conclusion

By using VLANs, you can significantly improve the security and manageability of your network. VLANs allow you to logically segment your network, controlling communication between devices and reducing broadcast traffic. This setup is crucial for maintaining a secure and efficient network, especially in large organizations.

We’ll explore setting up a DHCP server on the Raspberry Pi to assign IP addresses within these VLANs. Stay tuned!

I am recording videos as well :)
