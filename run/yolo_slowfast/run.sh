apt install -y git
git clone https://github.com/wufan-tb/yolo_slowfast
cd yolo_slowfast
conda create -n yolo-slowfast python=3.8 -y
conda activate yolo-slowfast
echo -e "pytorchvideo\nscipy\npandas\nrequests\npsutil\nmatplotlib\nseaborn\nnumpy<=1.23" >> requirements.txt
pip install -r requirements.txt
pip uninstall opencv-python -y
pip install opencv-python-headless -y
# 传文件进容器用docker cp, 或者还是应该用目录映射。这种不是基础的文件不要写入dockerfile。
