FROM runpod/worker-comfyui:5.5.1-base
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /
RUN rm -rf /comfyui && git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git /comfyui && cd /comfyui && pip install -r requirements.txt --no-cache-dir
RUN rm -rf /comfyui/models && mkdir -p /comfyui/models
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml
