# Install required packages
sudo apt -y update
sudo apt -y install libncurses5-dev
sudo apt -y install build-essential
sudo apt -y install bc
sudo apt -y install lbzip2
sudo apt -y install qemu-user-static

# Create build folder
mkdir $HOME/jetson_nano
cd $HOME/jetson_nano

# Download the following files in the jetson_nano folder:
# L4T Jetson Driver Package
wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/jetson-210_linux_r32.6.1_aarch64.tbz2
# L4T Sample Root File System
wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2
# L4T Sources
wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/sources/t210/public_sources.tbz2

# Extract files
sudo tar xpvf jetson-210_linux_r32.6.1_aarch64.tbz2
cd Linux_for_Tegra/rootfs/ 
sudo tar xpvf ../../tegra_linux_sample-root-filesystem_r32.6.1_aarch64.tbz2
cd ../../
sudo tar -xjvf public_sources.tbz2
tar -xjvf Linux_for_Tegra/source/public/kernel_src.tbz2

# Apply PREEMPT-RT patches
cd kernel/kernel-4.9/ 
./scripts/rt-patch.sh apply-patches

# Compile kernel
TEGRA_KERNEL_OUT=jetson_nano_kernel 
mkdir $TEGRA_KERNEL_OUT 
make ARCH=arm64 O=$TEGRA_KERNEL_OUT tegra_defconfig 
make ARCH=arm64 O=$TEGRA_KERNEL_OUT menuconfig