# 命令行安装
参考文档：[ubuntu-linux-install-nvidia-driver-latest-proprietary-driver](https://www.cyberciti.biz/faq/ubuntu-linux-install-nvidia-driver-latest-proprietary-driver/)
## 查看GPU信息
```sh
sudo lshw -C display
# or
lspci | grep VGA
```
会输出类似下面的信息：
```
01:00.0 VGA compatible controller: NVIDIA Corporation GP107 [GeForce GTX 1050 Ti] (rev a1)
```
## 查看现在用的驱动(open-source Nouveau or proprietary NVIDIA)
```sh
lsmod | grep nouveau
```
这里会打印有nouveau模块。
如果没有还安装Nvidia驱动的话，Ubuntu is using the open-source nouveau drivers by default.
```
lsmod | grep nvidia
```
如果还没有安装，也就没有对应内核模块，这里什么都不会有。
## 命令行安装
借助apt工具进行安装。
### 更新系统
```sh
sudo apt update
sudo apt upgrade
```
### 首先搜索可用版本
```sh
apt search nvidia-driver
# 如果觉得信息太多，执行如下命令：
apt search nvidia-driver |  grep '^nvidia-driver-[[:digit:]]*'
apt search 'nvidia-dkms-' |  grep '^nvidia-dkms-[[:digit:]]*'
```
输出类似下面：
```sh
ty@ty-laptop:~$ apt search nvidia-driver |  grep '^nvidia-driver-[[:digit:]]*'

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

nvidia-driver-390/jammy-updates,jammy-security 390.157-0ubuntu0.22.04.1 amd64
nvidia-driver-418/jammy 430.50-0ubuntu3 amd64
nvidia-driver-418-server/jammy-updates,jammy-security 418.226.00-0ubuntu5~0.22.04.1 amd64
nvidia-driver-430/jammy 440.100-0ubuntu1 amd64
nvidia-driver-435/jammy 455.45.01-0ubuntu1 amd64
nvidia-driver-440/jammy 450.119.03-0ubuntu1 amd64
nvidia-driver-440-server/jammy-updates,jammy-security 450.216.04-0ubuntu0.22.04.1 amd64
nvidia-driver-450/jammy 460.91.03-0ubuntu1 amd64
nvidia-driver-450-server/jammy-updates,jammy-security 450.216.04-0ubuntu0.22.04.1 amd64
nvidia-driver-455/jammy 460.91.03-0ubuntu1 amd64
nvidia-driver-460/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-driver-460-server/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-driver-465/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-driver-470/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-driver-470-server/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-driver-495/jammy-updates,jammy-security 510.108.03-0ubuntu0.22.04.1 amd64
nvidia-driver-510/jammy-updates,jammy-security 510.108.03-0ubuntu0.22.04.1 amd64
nvidia-driver-510-server/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.2 amd64
nvidia-driver-515/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.1 amd64
nvidia-driver-515-open/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.1 amd64
nvidia-driver-515-server/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.2 amd64
nvidia-driver-520/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-driver-520-open/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-driver-525/jammy-updates,jammy-security,now 525.89.02-0ubuntu0.22.04.1 amd64 [installed]
nvidia-driver-525-open/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-driver-525-server/jammy-updates,jammy-security 525.85.12-0ubuntu0.22.04.1 amd64
ty@ty-laptop:~$ apt search 'nvidia-dkms-' |  grep '^nvidia-dkms-[[:digit:]]*'

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

nvidia-dkms-390/jammy-updates,jammy-security 390.157-0ubuntu0.22.04.1 amd64
nvidia-dkms-418/jammy 430.50-0ubuntu3 amd64
nvidia-dkms-418-server/jammy-updates,jammy-security 418.226.00-0ubuntu5~0.22.04.1 amd64
nvidia-dkms-430/jammy 440.100-0ubuntu1 amd64
nvidia-dkms-435/jammy 455.45.01-0ubuntu1 amd64
nvidia-dkms-440/jammy 450.119.03-0ubuntu1 amd64
nvidia-dkms-440-server/jammy-updates,jammy-security 450.216.04-0ubuntu0.22.04.1 amd64
nvidia-dkms-450/jammy 460.91.03-0ubuntu1 amd64
nvidia-dkms-450-server/jammy-updates,jammy-security 450.216.04-0ubuntu0.22.04.1 amd64
nvidia-dkms-455/jammy 460.91.03-0ubuntu1 amd64
nvidia-dkms-460/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-460-server/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-465/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-470/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-470-server/jammy-updates,jammy-security 470.161.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-495/jammy-updates,jammy-security 510.108.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-510/jammy-updates,jammy-security 510.108.03-0ubuntu0.22.04.1 amd64
nvidia-dkms-510-server/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.2 amd64
nvidia-dkms-515/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.1 amd64
nvidia-dkms-515-open/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.1 amd64
nvidia-dkms-515-server/jammy-updates,jammy-security 515.86.01-0ubuntu0.22.04.2 amd64
nvidia-dkms-520/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-dkms-520-open/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-dkms-525/jammy-updates,jammy-security,now 525.89.02-0ubuntu0.22.04.1 amd64 [installed]
nvidia-dkms-525-open/jammy-updates,jammy-security 525.89.02-0ubuntu0.22.04.1 amd64
nvidia-dkms-525-server/jammy-updates,jammy-security 525.85.12-0ubuntu0.22.04.1 amd64
```
### 选择版本安装
比如我选择安装上面提供的最新的525版本。
```sh
sudo apt install nvidia-driver-525 nvidia-dkms-525
```
### 重启
```sh
sudo reboot
```
### 验证
```sh
nvidia-smi
```
有类似如下输出即可：
```
Thu Mar 30 09:32:54 2023       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 525.89.02    Driver Version: 525.89.02    CUDA Version: 12.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0 Off |                  N/A |
| 32%   21C    P8    11W / 170W |     94MiB / 12288MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1245      G   /usr/lib/xorg/Xorg                 86MiB |
|    0   N/A  N/A      1449      G   /usr/bin/gnome-shell                5MiB |
+-----------------------------------------------------------------------------+
```
只查询版本：
```
nvidia-smi --query-gpu=driver_version --format=csv
```

# A note about ubuntu-drivers command-line method
> We can also change drivers without the use of the X GUI/Windows desktop. For these purposes, Ubuntu comes with a unique command called ubuntu-drivers to manage binary drivers for NVidia and other devices. This is an alternative to the apt command/apt-get command we used earlier.
>
## Show all driver packages which apply to the current system
```sh
sudo ubuntu-drivers list
```
## Display all OEM enablement packages which apply to this system
```sh
sudo ubuntu-drivers list-oem
```
## View all hardware NVidia devices which need drivers, and which packages
```
sudo ubuntu-drivers devices
```
## Ubuntu command to install a driver NVidia
就跟在那个图形化界面中安装推荐驱动一样，这行命令会自动安装推荐版本的驱动。
```
sudo ubuntu-drivers install
```
# Nvidia Driver,CUDA和CUDA Toolkit (PyTorch)间的关系
之前对这几个的关系一直不是很清楚，所以特意做过一篇笔记。

链接如下：[英伟达官网 CUDA、CUDA toolkit 和 Conda PyTorch 里 CUDA、CUDA toolkit的关系](https://www.notion.so/a-fly-fly-bird/CUDA-CUDA-toolkit-Conda-PyTorch-CUDA-CUDA-toolkit-7ae4812e26cc43c3a95cfc99c7905e75?pvs=4)

这里再着重记录一下。

* 平时说的安装cuda，其实是安装[CUDA toolkit](https://developer.nvidia.com/cuda-downloads)
* CUDA Toolkit (Nvidia)是完整的工具安装包，其中提供了 Nvidia 驱动程序
* CUDA Toolkit (PyTorch)： CUDA不完整的工具安装包，其主要包含在使用 CUDA 相关的功能时所依赖的动态链接库。不会安装驱动程序。
* 对于 Pytorch 之类的深度学习框架而言，其在大多数需要使用 GPU 的情况中只需要使用 CUDA 的动态链接库支持程序的运行(Pytorch 本身与 CUDA 相关的部分是提前编译好的)，就像常见的可执行程序一样，不需要重新进行编译过程，只需要其所依赖的动态链接库存在即可正常运行。

所以，安装的时候有两种可选方案：
* Drievr + CUDA Toolkit (PyTorch)
* CUDA Toolkit (Nvidia) + CUDA Toolkit (PyTorch)
  
最好第二种，最省时间，使用范围最广。

## 注意
注意需要查询[Nvidia Driver和CUDA Toolkit的对照关系](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html)和[CUDA Toolkit (PyTorch)中CUDA与PyTorch的对应关系](https://pytorch.org/get-started/previous-versions/)，不然就可能遇到我下面遇到的问题。

这里的一个简单的对照表。

| CUDA Toolkit | Linux x86_64 Minimum Required Driver Version | Windows Minimum Required Driver Version |
| ------------ | -------------------------------------------- | --------------------------------------- |
| CUDA 12.x    | >=525.60.13                                  | >=527.41                                |
| CUDA 11.x    | >= 450.80.02*                                | >=452.39*                               |

| CUDA版本 | 可用PyTorch版本    |
| -------- | ---------------------- |
| 7.5      | 0.4.1，0.3.0，0.2.0  |
| 8.0      | 1.1.0，1.0.0          |
| 9.2      | 1.6.0，1.5.0          |
| 10.2     | 1.6.0，1.5.0          |
| 11.0     | 1.7.0                  |
| 11.6     | 1.13.1，1.13.0，1.12.1 |

## RuntimeError: CUDA error: no kernel image is available for execution on the device

这次安装的时候还遇到过一个新问题：[RuntimeError: CUDA error: no kernel image is available for execution on the device](https://forums.developer.nvidia.com/t/runtimeerror-cuda-error-no-kernel-image-is-available-for-execution-on-the-device/167708)

总而言之就是安装的cuda, pytorch和当前的GPU型号，驱动并不匹配。参考上面的笔记解决即可。

其实最主要的就是**CUDA Toolkit (PyTorch)中CUDA的版本不能过高或者过低，过低，Driver不支持，过高，PyTorch不支持**。
