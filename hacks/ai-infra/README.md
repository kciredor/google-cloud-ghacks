# AI Infrastructure with Google

## Introduction

Running AI workloads requires specific infrastructure. We will go hands-on with accelerators like GPUs. Further, let's bridge the gap between hardware and software with platforms like Vertex AI.

## Learning Objectives

1. Getting familiar with compute related to AI: welcome to GPUs
1. How to obtain capacity? Try Dynamic Workload Scheduler
1. The link between AI Infra and Software: this is Vertex AI

## Challenges

- Challenge 1: Hello, CPU!
  - Creating a Virtual Machine with Intel AMX extensions
  - Code an example script or bash command to confirm the enabled exentions
- Challenge 2: Hello, GPU!
  - Creating a Virtual Machine with a NVIDIA L4 GPU attached
  - Verify the driver
  - Code an example script to detect the attached GPU
- Challenge 3: Benchmarking CPU vs GPU
  - Training on CPU
  - Training on GPU
  - Inference on CPU
  - Inference on GPU
- Challenge 4: Dynamic Workload Scheduler
  - Obtaining an A100 GPU
  - TODO
- Challenge 5: Vertex AI
  - TODO

## Prerequisites

Requirements are part of the Coaches Guide. You'll need a GCP project with the IAM Owner role.

## Contributors

- Roderick Schaefer (kciredor@google.com)

---

## Challenge 1: Hello, CPU!

### Pre-requisites

* Access to your assigned GCP project.
* Basic knowledge of the Linux command line.

### Introduction

When we think of AI and Machine Learning, we usually think of GPUs. However, modern CPUs are not standing still. They now include specialized instruction sets to accelerate matrix calculations—the heart of many AI operations.

One of the most important new instruction sets is **Intel Advanced Matrix Extensions (AMX)**. AMX allows the CPU to perform matrix multiplication operations much faster, making it a powerful tool for AI **inference** and even small-scale training.

In this challenge, your goal is to provision a VM on Google Cloud that has these special AMX capabilities and prove that they are active.

### Description

Your task is to launch a Google Compute Engine virtual machine that is equipped with Intel AMX extensions. Not all machine types on GCP have this feature; you will need to find one that does.

> **Note**
> You will need to research which GCP machine types run on the required CPU platforms. The key is to find a VM that uses a **3rd Generation (Ice Lake)** or **4th Generation (Sapphire Rapids)** Intel Xeon processor.

Once your VM is running, you must SSH into it and run a command to inspect the CPU's features and confirm that AMX is enabled.

Your specifications are:
* Launch a new Compute Engine VM instance.
* The instance must use a machine type that provides Intel AMX extensions.
* The instance should use a modern Linux OS, for example, the **Ubuntu 24.04 LTS** image.
* Once running, you must find a way to confirm from the command line that the CPU flags `amx_tile`, `amx_int8`, and `amx_bf16` are present.

### Success Criteria

* Demonstrate to your coach that your VM instance is running in the GCP Console.
* Show the output of a Linux command that lists your VM's CPU features.
* Verify that the output clearly shows the `amx_tile`, `amx_int8`, and `amx_bf16` flags.

### Tips

* The `lscpu` command in Linux is very useful for inspecting CPU features and flags.
* You can use the `gcloud` command-line tool or the GCP Console to create your VM.
* The GCP documentation for [Machine Types](https://cloud.google.com/compute/docs/machine-types) is your best friend. Look for pages that describe the CPU platforms for different machine series (like C3, N4, N2, etc.).

### Learning Resources

* [Google Cloud Machine Types documentation](https://cloud.google.com/compute/docs/machine-types)
* [An overview of Intel AMX](https://www.intel.com/content/www/us/en/products/docs/accelerator-engines/advanced-matrix-extensions/overview.html)
* [How to use the `lscpu` command](https://man7.org/linux/man-pages/man1/lscpu.1.html)
