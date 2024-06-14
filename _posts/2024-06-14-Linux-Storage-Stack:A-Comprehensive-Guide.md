---
layout: post
title:  "Exploring the Linux Storage Stack: A Comprehensive Guide"
categories: jekyll update
tags: linux linux-kernel
---

### Exploring the Linux Storage Stack: A Comprehensive Guide

The strong and adaptable file systems we depend on are supported by an intriguing and intricate design called the Linux Storage Stack. The storage stack has grown to include a wide range of parts and tiers as of Linux Kernel version 6.9, which was made available on May 12, 2024. Each part and layer is essential to the management of storage devices and data. This blog post explores the nuances of the Linux Storage Stack, giving a synopsis of its different components and layers.

<img alt="Linux Storage Stack" src="/public/media/Linux-storage-stack-diagram-v6.9.svg">

#### 1. Applications Layer

At the top of the stack are user-level processes and applications. These interact with the file system through system calls. Some common system calls include:

- **`read`(2)**: Reads data from a file descriptor.
- **`write`(2)**: Writes data to a file descriptor.
- **`open`(2)**: Opens a file.
- **`stat`(2)**: Retrieves file status.
- **`chmod`(2)**: Changes file permissions.

This layer is where everyday applications, from text editors to databases, access the file system to store and retrieve data.

#### 2. Virtual File System (VFS)

An abstraction layer supplied by the kernel, the Virtual File System (VFS) provides a standard interface for various file system implementations. It makes it possible for the Linux kernel to effortlessly handle a variety of file systems, allowing applications to communicate with them consistently. In addition to managing file system functions, VFS hides the specifics of the underlying file systems and offers a common user space interface.

#### 3. File Systems

Linux supports a variety of file systems, each suited for different use cases:

- **Block-based File Systems**: These are used for general storage needs.
  - **ext4**: An improved version of the ext3 file system with support for larger volumes and files, better performance, and more efficient allocation.
  - **btrfs**: A modern file system with advanced features like snapshots, RAID support, and self-healing.
  - **xfs**: Known for its high performance and scalability, especially in enterprise environments.
  - **f2fs**: Optimized for flash storage, offering better performance and lifespan for SSDs.

- **Special Purpose File Systems**: Optimized for specific tasks.
  - **gfs2**: A cluster file system for sharing storage among multiple computers.
  - **ocfs2**: Another cluster file system designed for Oracle databases.
  - **iso9660**: Used for optical disc media.
  - **squashfs**: A compressed read-only file system, useful for embedded systems.

- **Stackable File Systems**: Provide additional functionality by stacking on top of other file systems.
  - **ecryptfs**: Offers encryption at the file system level.
  - **overlayfs**: Used for creating unified mount points, useful in container environments.

- **Network File Systems**: Allow for remote storage access over a network.
  - **NFS**: Network File System, a widely-used protocol for file sharing.
  - **Ceph**: A distributed object store and file system designed to provide excellent performance, reliability, and scalability.

- **Pseudo File Systems**: Do not store data persistently but provide interfaces to kernel data structures.
  - **proc**: Provides process and kernel information.
  - **sysfs**: Exposes kernel objects and their attributes.
  - **tmpfs**: A temporary file storage system in RAM.
  - **devtmpfs**: Automatically manages device nodes in `/dev`.

#### 4. Page Cache

A crucial part that keeps file data in memory cache and speeds up read and write operations considerably is the page cache. The system can improve speed by minimising the amount of disc accesses by storing frequently accessed data in memory. Since reading data from a disc is significantly slower than accessing it from memory, this cache is essential to the file system's overall performance.

#### 5. Block Layer

The Block Layer manages block devices and handles I/O scheduling. It includes components like:

- **blk_mq (block multi-queue)**: Manages multiple hardware queues for high-performance storage devices, allowing for parallel processing of I/O requests.
- **I/O Schedulers**: Optimize the order and efficiency of disk operations.
  - **bfq**: Budget Fair Queueing, provides per-process bandwidth control.
  - **kyber**: A low-latency I/O scheduler for fast storage devices.
  - **mq_deadline**: Ensures requests are processed within a certain deadline, balancing fairness and performance.

#### 6. Device Drivers

Device drivers are essential for communication between the operating system and hardware. The Linux Storage Stack includes drivers for a wide range of storage devices:

- **SCSI Drivers**: For SCSI devices and their derivatives, managing various types of storage hardware.
- **NVMe Drivers**: For NVMe storage, including PCIe-based NVMe drives, providing high-speed storage solutions.
- **ATA Drivers**: For ATA and SATA devices, commonly used in consumer-grade hardware.
- **Other Block Devices**: Drivers for other block devices like MMC (MultiMediaCard), DASD (Direct Access Storage Device), and virtual block devices used in virtualized environments.

#### 7. Request and BIO-Based Drivers

Block I/O requests and BIO (Block I/O) structures are managed by this layer. BIOs are essential for controlling how data is read from and written to disc since they define block I/O operations. These drivers convert commands that the storage hardware can understand from high-level file system operations.

#### 8. Physical Devices

At the bottom of the stack are the actual storage devices, including:

- **Hard Disk Drives (HDDs)**: Traditional spinning disks used for large capacity storage.
- **Solid-State Drives (SSDs)**: Faster storage devices with no moving parts, offering better performance and reliability.
- **NVMe Drives**: High-speed storage devices connected via PCIe, providing superior performance compared to SATA SSDs.
- **Other Technologies**: Various other storage technologies like UBI (Unsorted Block Images) for flash memory, MMC cards, and more.

#### 9. Transport Layers

Transport layers are responsible for the protocols and mechanisms used to transfer data between different components of the storage stack. This includes:

- **NVMe over Fabrics**: Supporting protocols like NVMe over TCP, RDMA, and Fibre Channel, enabling high-speed remote storage access.
- **SCSI Transport**: Protocols such as iSCSI and Fibre Channel for SCSI devices over networks.
- **Virtual Host Interfaces**: For virtualized environments and containerized applications, providing efficient storage solutions for VMs and containers.

#### 10. Memory Technologies

Linux supports various memory-based storage devices, including:

- **Persistent Memory (pmem)**: Non-volatile memory that retains data even when the power is off, providing high-speed storage solutions.
- **RAM Disks (zram)**: Use system RAM as storage, offering very high-speed storage but volatile in nature.

#### 11. Miscellaneous Components

The Linux Storage Stack also includes various additional modules:

- **Device Mapper**: For creating virtual block devices and managing storage volumes. It includes:
  - **dm-multipath**: For managing multiple paths to storage devices, providing redundancy and load balancing.
  - **dm-crypt**: For disk encryption.
  - **dm-thin**: For thin provisioning, allowing for efficient storage utilization.
  - **dm-raid**: For software RAID implementations.

- **Software RAID**: Combines multiple physical disks into a single logical unit for redundancy or performance improvements.
- **Caching Solutions**: Modules like bcache that cache data from slower storage devices on faster ones.
- **Debugging Tools**: Modules designed for testing and debugging storage configurations.

### Conclusion

The flexibility and strength of the Linux kernel are demonstrated by the Linux Storage Stack. Its layered architecture makes it possible to effortlessly combine a broad variety of storage devices and technologies, offering a strong platform for computing demands for both personal and business use. Comprehending the Linux Storage Stack can enhance your appreciation for the intricacy and sophistication of contemporary storage solutions, regardless of your background as a developer, system administrator, or tech enthusiast.

For more detailed information on each component, you can refer to the official [Linux documentation](https://www.kernel.org/doc/html/latest/).

### References

- [Linux Storage Stack Diagram](https://www.thomas-krenn.com/en/wiki/Linux_Storage_Stack_Diagram)
- [Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/)

You can obtain a better understanding of how Linux manages and optimises storage, guaranteeing dependable and effective data access across a range of devices and configurations, by investigating the many layers and components of the Linux Storage Stack.
