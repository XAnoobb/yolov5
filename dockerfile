# 使用 NVIDIA Jetson 的官方基础镜像
FROM nvidia/jetson:ubuntu20.04-cuda11.2-devel

# 设置工作目录
WORKDIR /app

# 安装必要的系统包
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    build-essential \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 及其依赖
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install --upgrade pip setuptools wheel && \
    pip3 install flask opencv-python-headless

# 安装 NVIDIA TensorRT
RUN apt-get install -y nvidia-container-toolkit && \
    nvidia-container-runtime config --set=registry=nvidia.com && \
    docker run --rm nvidia/cuda:11.2.0-base nvidia-smi

# 安装 YOLOv5 相关依赖
RUN pip3 install -U torch torchvision

# 复制应用代码
#COPY . .

# 复制优化后的模型
#COPY model.onnx /app/model.onnx

# 设置环境变量
#ENV LABELS_FILE /app/labels.txt
#ENV MODEL_PATH /app/model.onnx

# 启动 Flask 服务
#CMD ["python3", "app.py"]
