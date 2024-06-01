# Remaster Debian ISO with Docker
#### Comes with a nice post-install directory

## Prerequisites
1. Debian ISO file
2. Docker

## Installation Process

### Step 1: Modify isolinux.cfg
Modify the `isolinux.cfg` file to automate the installation process without the need to interact with the installation menu. Use the following configuration:

### Step 2: Create a Directory in cook-book
Copy one of the existing directories in the `cook-book` directory and rename it as desired.

### Step 3: Edit the Preseed Config File
Edit the preseed configuration file within your newly created directory to specify your automated installation settings.

### Step 4: Run cook.sh
Execute the script `cook.sh` followed by the name of your directory to generate your custom ISO.

### Result
You will get a new ISO with an added preseed file that will automatically install when the VM is started.

