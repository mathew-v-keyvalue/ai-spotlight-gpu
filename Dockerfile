# ---------- Base: NVIDIA CUDA for GPU Inference ----------
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04


ENV DEBIAN_FRONTEND=noninteractive
ENV CC=gcc

# ---------- Install Python and system dependencies ----------
RUN apt-get update && \
    apt-get install -y python3 python3-pip git build-essential \
    ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/*

# ---------- Upgrade pip and install key Python libraries ----------
RUN python3 -m pip install --upgrade pip && \
    pip install torch torchvision torchaudio \
        pandas jupyterlab \
        fastapi uvicorn transformers

# ---------- Working directory for notebooks and code ----------
WORKDIR /workspace

# ---------- Expose JupyterLab port ----------
EXPOSE 8890

# ---------- Start JupyterLab ----------
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8890", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
