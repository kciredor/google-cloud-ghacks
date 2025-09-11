# AI Infrastructure with Google

## Introduction

Welcome to the coaches guide for the AI Infrastructure on Google gHack.

> **Note** If you are a gHacks participant, this is the answer guide. Don't cheat yourself by looking at this guide during the hack!

## Coaches Guides

TODO

- Challenge 1: xxxxxxxxxxxxxxx
  - xxxxxxxxxxxxxxxxxxxxxxxx

## Coach Prerequisites

This hack has prerequisites that a coach is responsible for understanding and/or setting up BEFORE hosting an event. Please review the [gHacks Hosting Guide](https://ghacks.dev/faq/howto-host-hack.html) for information on how to host a hack event.

The guide covers the common preparation steps a coach needs to do before any gHacks event, including how to properly setup Google Meet and Chat Spaces.

### Student Resources

Before the hack, it is the coaches responsibility create and make available needed resources including:

- Files for students
- Lecture presentation
- Terraform scripts for setup (if running in the customer's own environment)

Follow [these instructions](https://ghacks.dev/faq/howto-host-hack.html#making-resources-available) to create the zip files needed and upload them to your gHack's Google Space's Files area.

Always refer students to the [gHacks website](https://ghacks.dev) for the student guide: [https://ghacks.dev](https://ghacks.dev)

> **Note** Students should **NOT** be given a link to the gHacks Github repo before or during a hack. The student guide intentionally does **NOT** have any links to the coaches guide or the GitHub repo.

### Additional Coach Prerequisites

Mandatory: ensure you go through LFS capacity planning, because this gHack uses GPUs.

## Google Cloud Requirements

This hack requires students to have access to Google Cloud project where they can create and consume Google Cloud resources. These requirements should be shared with a stakeholder in the organization that will be providing the Google Cloud project that will be used by the students.

Students will need access to a working and unrestricted GCP environment. With gHacks this is typically provided by Qwiklabs, powered by LFS. They'll need to bring their own laptops with un-firewalled access to *.qwiklabs.com and *.google.com.

## Repository Contents

- `README.md`
  - Students Challenge Guide
- `solutions.md`
  - Coaches Guide
- `./artifacts`
  - Terraform scripts and other files needed to set up the environment for the gHack

## Environment

- Setting Up the Environment (if not on Qwiklabs)
  - Before we can hack, you will need to set up a few things.
  - Run the instructions on our [Environment Setup](../../faq/howto-setup-environment.md) page.

## Challenge 1: TODO

### Notes & Guidance

The solution has two parts:
1.  **Choosing the right machine type:** Students need to discover that Intel AMX is available on certain VM families like C3 and C4.
2.  **Verifying the feature:** The `lscpu` command on Linux lists all CPU flags. Students just need to `grep` this output for `amx`.

### Solution Steps

Here is the fastest `gcloud` path to solving the challenge.

**Step 1: Create the VM**

The command below creates a **C3 (Sapphire Rapids)** machine, which is guaranteed to have AMX.

> **Note**
> C3 machines are not available in all zones. `us-central1-a` is a reliable choice. If students get a zone error, they can find a valid one by running `gcloud compute machine-types list --filter="name=c3-standard-4"`.

```
# We use c3-standard-4 here.
gcloud compute instances create amx-instance \
  --project=STUDENT_PROJECT_ID \
  --zone=us-central1-a \
  --machine-type=c3-standard-4 \
  --image-family=ubuntu-2404-lts \
  --image-project=ubuntu-os-cloud
```

**Step 2: SSH into the VM**

`gcloud compute ssh amx-instance --zone=us-central1-a`

** Step 3: Verify the AMX Extensions **

# Run lscpu and filter for 'amx'
`lscpu | grep amx`

The student should see an output similar to this, which confirms the success criteria:
`Flags:               ... amx_bf16 amx_tile amx_int8 ...`

### Common Pitfalls
Student chose another VM family like e2-standard-2 or n1-standard-2. These machines use older CPUs. If they run lscpu | grep amx, they will get no output. Guide them to the Machine Types documentation to find a machine series that supports 3rd or 4th Gen Intel CPUs.

"Resource not found" or Zone error: The student picked a machine type (like C3) that isn't available in their chosen or default zone. Have them explicitly specify a zone like us-central1-a or europe-west4-a.
